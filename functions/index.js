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

exports.exchangeAuthorizationCodeForMusicToken = functions.https.onCall(async (data, context) => {
  try {
    const authorizationCode = data.authorizationCode;

    console.log("AuthorizationCode : ", authorizationCode);

    // Generate Apple Developer Token
    const developerToken = await generateDeveloperToken();

    console.log("DEVELOPER TOKEN : ", developerToken);

    // Exchange authorizationCode for Apple Music User Token
    const response = await fetch("https://appleid.apple.com/auth/token", {
      method: "POST",
      headers: {
        "Content-Type": "application/x-www-form-urlencoded",
      },
      body: new URLSearchParams({
        client_id: "com.musicpacemaker.app-service",
        client_secret: developerToken,
        code: authorizationCode,
        grant_type: "authorization_code",
        redirect_uri: "https://valley-amplified-fright.glitch.me/callbacks/sign_in_with_apple",
      }),
    });

    const tokenResponse = await response.json();
    if (response.ok) {
      const musicUserToken = tokenResponse.access_token;
      const expirationTime = Date.now() + (tokenResponse.expires_in * 1000);

      console.log("Music User Token:", musicUserToken);

      // Return the Apple Music User Token and expiration time
      return {
        musicUserToken: musicUserToken,
        expirationTime: expirationTime,
      };
    } else {
      console.error("Error response from Apple : ", tokenResponse);
      return {
        error: tokenResponse,
      };
    }
  } catch (error) {
    console.error("Error exchanging authorization code for music token:", error);
    return {
      error: error.message,
    };
  }
});

/**
 * Function to generate Apple Developer Token using JWT.
 * @return {string} Returns the generated Apple Developer Token.
 */
async function generateDeveloperToken() {
  const now = Math.floor(Date.now() / 1000);
  const expiration = now + 60 * 60 * 24; // Expires in 24 hours

  const token = await jwt.sign(
      {
        iss: TEAM_ID,
        iat: now,
        exp: expiration,
        aud: "https://appleid.apple.com",
      },
      PRIVATE_KEY,
      {
        algorithm: "ES256",
        keyid: KEY_ID,
      },
  );


  return token;
}

exports.generateDeveloperToken = functions.https.onCall(async (data, context) => {
  try {
    const developerToken = await generateDeveloperToken();

    return {token: developerToken};
  } catch (e) {
    return {error: e};
  }
});
