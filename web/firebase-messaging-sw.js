importScripts("https://www.gstatic.com/firebasejs/8.6.1/firebase-app.js");
importScripts("https://www.gstatic.com/firebasejs/8.6.1/firebase-messaging.js");

firebase.initializeApp({
    apiKey: "AIzaSyDRF7BMLI17OgI2vNWOCm3m56_b56dwTbw",
    authDomain: "axxa-e81e3.firebaseapp.com",
    //databaseURL: "https://[YOUR_PROJECT].firebaseio.com",
    projectId: "axxa-e81e3",
    storageBucket: "axxa-e81e3.appspot.com",
    messagingSenderId: "137626525780",
    appId: "1:137626525780:web:f4fb5b34e9dc7853c78dc1",
    measurementId: "G-1DMMQVLN1V",
});
// Necessary to receive background messages:
const messaging = firebase.messaging();
/*messaging.setBackgroundMessageHandler(function (payload) {
    const promiseChain = clients
        .matchAll({
            type: "window",
            includeUncontrolled: true
        })
        .then(windowClients => {
            for (let i = 0; i < windowClients.length; i++) {
                const windowClient = windowClients[i];
                windowClient.postMessage(payload);
            }
        })
        .then(() => {
            const title = payload.notification.title;
            const options = {
                body: payload.notification.score
              };
            return registration.showNotification(title, options);
        });
    return promiseChain;
});
self.addEventListener('notificationclick', function (event) {
    console.log('notification received: ', event)
});*/


// Optional:
messaging.onBackgroundMessage((m) => {
  console.log("onBackgroundMessage", m);
});

/*const messaging = firebase.messaging();
messaging.setBackgroundMessageHandler(function (payload) {
    const promiseChain = clients
        .matchAll({
            type: "window",
            includeUncontrolled: true
        })
        .then(windowClients => {
            for (let i = 0; i < windowClients.length; i++) {
                const windowClient = windowClients[i];
                windowClient.postMessage(payload);
            }
        })
        .then(() => {
            return registration.showNotification("New Message");
        });
    return promiseChain;
});*/