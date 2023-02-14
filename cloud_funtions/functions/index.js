const functions = require('firebase-functions');
const admin = require('firebase-admin');
admin.initializeApp(functions.config().functions);

// deploy post notification completed to publisher user
exports.postCompletedTrigger = functions.firestore
    .document('posts/{userUid}/AllPosts/{postId}')
    .onCreate(async (snapshot, context) => {
        print(context.auth.uid);
        const payload = {
            notification: {
                title: 'Post added successfully',
                body: snapshot.data().postText,
            },
            data: {
                click_action: 'FLUTTER_NOTIFICATION_CLICK',
                sound: 'default',
                status: 'done',
                screen: 'viewPost',
            },
        };
        const yourUid = context.auth.uid;
        var yourDeviceToken;
        await admin
            .firestore()
            .collection('tokens')
            .doc(yourUid)
            .get()
            .then((value) => {
                yourDeviceToken = value.data().deviceToken;
            });
        const res = await admin
            .messaging()
            .sendToDevice(yourDeviceToken, payload);
    });
// deploy post notifications to followers users
// deploy story notification completed to publisher user
// deploy story notifications to followers users
