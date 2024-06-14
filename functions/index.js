const functions = require("firebase-functions");
const admin = require("firebase-admin");
const jwt = require("jsonwebtoken");
const fetch = require("node-fetch");

admin.initializeApp();

const TEAM_ID = "K9W97KFJK3";
const KEY_ID = "KDUU3UQUC5";
const PRIVATE_KEY = `-----BEGIN PRIVATE KEY-----
MIGTAgEAMBMGByqGSM49AgEGCCqGSM49AwEHBHkwdwIBAQQgSkQ0k/0lTF6mqjKd
qeLAKdTsNKPuCe6KEp+2DPohJ9CgCgYIKoZIzj0DAQehRANCAARAO3Lbvn5MNdvF
+5ONTyMNNsZbfJJxh50CzQJfe4QSJviV2hpCgGKe6vgRsbjbJDWZfNwXK7+wQoZ9
3dn+sa9h
-----END PRIVATE KEY-----`;

/**
 * Firebase Cloud Function to exchange authorization code for Apple Music User Token.
 * @param {Object} data - The data passed to the Cloud Function containing authorizationCode.
 * @param {Object} context - The context object of the Cloud Function.
 * @returns {Promise<Object>} Returns an object containing musicUserToken and expirationTime.
 */
exports.exchangeAuthorizationCodeForMusicToken = functions.https.onCall(async (data, context) => {
  try {
    const {authorizationCode} = data;

    // Generate Apple Developer Token
    const developerToken = generateDeveloperToken();

    // Exchange authorizationCode for Apple Music User Token
    const tokenResponse = await fetch("https://appleid.apple.com/auth/token", {
      method: "POST",
      headers: {
        "Content-Type": "application/x-www-form-urlencoded",
      },
      body: new URLSearchParams({
        client_id: "com.musicpacemaker.app-service",
        client_secret: developerToken,
        code: authorizationCode,
        grant_type: "authorization_code",
      }),
    }).then((res) => res.json());

    console.log("RESPONSE : ", tokenResponse);

    const musicUserToken = tokenResponse.access_token;
    const expirationTime = Date.now() + (tokenResponse.expires_in * 1000);

    console.log("Music Token : ", musicUserToken);

    // Return the Apple Music User Token and expiration time
    return {
      musicUserToken: musicUserToken,
      expirationTime: expirationTime,
    };
  } catch (error) {
    console.error("Error exchanging authorization code for music token:", error);
    return {
      error: error,
    };
  }
});

/**
 * Function to generate Apple Developer Token using JWT.
 * @return {string} Returns the generated Apple Developer Token.
 */
function generateDeveloperToken() {
  const now = Math.floor(Date.now() / 1000);
  const expiration = now + 60 * 60 * 24; // Expires in 24 hours

  const token = jwt.sign(
      {
        iss: TEAM_ID,
        iat: now,
        exp: expiration,
        aud: "https://music.apple.com",
      },
      PRIVATE_KEY,
      {
        algorithm: "ES256",
        keyid: KEY_ID,
      },
  );

  return token;
}
