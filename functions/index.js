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
const KEY_ID = "W3ZK6X526K";
const PRIVATE_KEY = `-----BEGIN PRIVATE KEY-----
MIGTAgEAMBMGByqGSM49AgEGCCqGSM49AwEHBHkwdwIBAQQgqO6UCXA4zGG9lEWl
4xJukvNqO9cQamOrd0SccQZQfyCgCgYIKoZIzj0DAQehRANCAAT/4lPDQX5C0O3W
D0cWopT5S0UxB7wY7Is/EiGgtkt/q3EAkoxjxI5iTmEk58hyB38lC8p+7SVOMJV9
ZiuwPrBF
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

// HTTP Cloud Function to generate developer token
exports.getDeveloperToken = functions.https.onRequest((request, response) => {
  const token = generateDeveloperToken();
  response.json({token});
});

exports.getMusicUserToken = functions.https.onCall(async (data, context) => {
  const uid = context.auth.uid;

  // Retrieve user's token from Firestore
  const userDoc = await firestoreClient.collection("users").doc(uid).get();
  const userData = userDoc.data();

  // Check if token exists and is still valid
  if (userData && userData.musicUserToken && userData.expirationTime > Date.now()) {
    return {musicUserToken: userData.musicUserToken};
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

  try {
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

    // Store the Music User Token and expiration time in Firestore
    await firestoreClient.collection("users").doc(uid).set({
      musicUserToken: musicUserToken,
      expirationTime: expirationTime,
    });

    return {musicUserToken: musicUserToken, expirationTime: expirationTime};
  } catch (error) {
    console.error("Error obtaining Music User Token:", error);
    return {error: "Failed to obtain Music User Token"};
  }
});
