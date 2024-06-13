/* eslint-disable camelcase */
const functions = require("firebase-functions");
const admin = require("firebase-admin");
const jwt = require("jsonwebtoken");
const https = require("https");
const querystring = require("querystring");

// Initialize Firebase Admin SDK
admin.initializeApp();

const firestoreClient = admin.firestore();

const TEAM_ID = "K9W97KFJK3";
const KEY_ID = "R5J4D75W9V";
const PRIVATE_KEY = `-----BEGIN PRIVATE KEY-----
MIGTAgEAMBMGByqGSM49AgEGCCqGSM49AwEHBHkwdwIBAQQgSkQ0k/0lTF6mqjKd
qeLAKdTsNKPuCe6KEp+2DPohJ9CgCgYIKoZIzj0DAQehRANCAARAO3Lbvn5MNdvF
+5ONTyMNNsZbfJJxh50CzQJfe4QSJviV2hpCgGKe6vgRsbjbJDWZfNwXK7+wQoZ9
3dn+sa9h
-----END PRIVATE KEY-----`;

// Generate Developer Token
const generateDeveloperToken = () => {
  const token = jwt.sign(
      {
        iss: TEAM_ID,
        iat: Math.floor(Date.now() / 1000),
        exp: Math.floor(Date.now() / 1000) + 180 * 24 * 60 * 60,
        aud: "https://api.music.apple.com",
      },
      PRIVATE_KEY,
      {
        algorithm: "ES256",
        header: {
          alg: "ES256",
          kid: KEY_ID,
        },
      },
  );
  return token;
};

// HTTP Cloud Function to get or update music user token
exports.getMusicUserToken = functions.https.onCall(async (data, context) => {
  const uid = context.auth.uid;

  try {
    // Retrieve user's document from Firestore
    const userDocRef = firestoreClient.collection("users").doc(uid);
    const userDoc = await userDocRef.get();

    if (!userDoc.exists) {
      throw new Error("User document does not exist");
    }

    const userData = userDoc.data();

    // Check if token exists and is still valid
    if (userData.musicUserToken && userData.expirationTime > Date.now()) {
      return {musicUserToken: userData.musicUserToken, expirationTime: userData.expirationTime};
    }

    const authorizationCode = data.authorizationCode;
    const developerToken = generateDeveloperToken();

    const postData = querystring.stringify({
      grant_type: "authorization_code",
      code: authorizationCode,
    });

    const options = {
      hostname: "api.music.apple.com",
      port: 443,
      path: "/v1/me/token",
      method: "POST",
      headers: {
        "Authorization": `Bearer ${developerToken}`,
        "Content-Type": "application/x-www-form-urlencoded",
        "Content-Length": postData.length,
      },
    };

    // Perform HTTPS request to Apple Music API
    const {musicUserToken, expires_in} = await new Promise((resolve, reject) => {
      const req = https.request(options, (res) => {
        let data = "";
        res.on("data", (chunk) => {
          data += chunk;
        });
        res.on("end", () => {
          const response = JSON.parse(data);
          if (response.musicUserToken && response.expires_in) {
            resolve({
              musicUserToken: response.musicUserToken,
              expires_in: response.expires_in,
            });
          } else {
            reject(new Error("Failed to obtain Music User Token"));
          }
        });
      });

      req.on("error", (e) => {
        reject(e);
      });

      req.write(postData);
      req.end();
    });

    const expirationTime = Date.now() + expires_in * 1000;

    // Update the Music User Token and expiration time in Firestore
    await userDocRef.update({
      musicUserToken: musicUserToken,
      expirationTime: expirationTime,
    });

    return {musicUserToken: musicUserToken, expirationTime: expirationTime};
  } catch (error) {
    console.error("Error obtaining or updating Music User Token:", error);
    return {error: error.message || error};
  }
});

