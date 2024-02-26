const functions = require("firebase-functions");
const admin = require("firebase-admin");
admin.initializeApp();

const firestore = admin.firestore();

exports.onUserStatusChange=functions.database.ref("/{userId}/active").onUpdate(
    async (change, context)=>{
      const isActive = change.after.val();
      const firestoreRef = firestore.doc("user/${context.params.userId}");
      return firestoreRef.update({
        active: isActive,
        lastSeen: Date.now(),
      });
    },
);

