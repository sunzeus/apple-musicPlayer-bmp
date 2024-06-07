const functions = require("firebase-functions");
const admin = require("firebase-admin");
const jwt = require("jsonwebtoken");
const axios = require("axios");

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
  const userDoc = await firestoreClient
      .collection("users").doc(uid).get();
  const userData = userDoc.data();

  // Check if token exists and is still valid
  if (userData && userData.musicToken && userData.expirationTime > Date.now()) {
    return {musicUserToken: userData.musicToken};
  }

  const authorizationCode = data.authorizationCode;
  const developerToken = generateDeveloperToken();

  try {
    const response = await axios.post("https://api.music.apple.com/v1/me/token", `grant_type=authorization_code&code=${authorizationCode}`, {
      headers: {
        "Authorization": `Bearer ${developerToken}`,
        "Content-Type": "application/x-www-form-urlencoded",
      },
    });

    const musicUserToken = response.data.musicUserToken;
    const expiresIn = response.data.expires_in; // Expiration time in seconds
    const expirationTime = Date.now() + expiresIn * 1000;

    // Store the Music User Token and expiration time in Firestore
    await firestoreClient.collection("users").doc(uid).set({
      musicToken: musicUserToken,
      expirationTime: expirationTime,
    });

    return {musicUserToken: musicUserToken, expirationTime: expirationTime};
  } catch (error) {
    console.error("Error obtaining Music User Token:", error);
  }
});
