function initializeMusicKit(developerToken) {
    document.addEventListener('musickitloaded', () => {
        // MusicKit global is now defined
        const music = MusicKit.configure({
            developerToken: developerToken,
            app: {
                name: 'Music Pacemaker',
                build: '1.0.0'
            }
        });

        document.getElementById('authorize-btn').addEventListener('click', async () => {

            await music.authorize().then(musicUserToken => {
                console.log(`Authorized, music-user-token: ${musicUserToken}`);
            }).catch(err => {
                console.error('Authorization Error:', err);
            });
        });

        // expose our instance globally for testing
        window.music = music;
    });
}

