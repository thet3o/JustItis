importScripts('https://www.gstatic.com/firebasejs/9.22.0/firebase-app.js');
importScripts('https://www.gstatic.com/firebasejs/9.22.0/firebase-messaging.js');

/*Update with yours config*/
const firebaseConfig = {
    apiKey: "AIzaSyA99HRQhOpoCTirxZxFEKiGk9uL7PTMvgQ",
    authDomain: "justitis-b275e.firebaseapp.com",
    projectId: "justitis-b275e",
    storageBucket: "justitis-b275e.appspot.com",
    messagingSenderId: "977297428392",
    appId: "1:977297428392:web:96a22d654490345a8f579d",
    measurementId: "G-KH4RKC7YJ1"
};
firebase.initializeApp(firebaseConfig);
const messaging = firebase.messaging();

/*messaging.onMessage((payload) => {
console.log('Message received. ', payload);*/
messaging.onBackgroundMessage(function (payload) {
    console.log('Received background message ', payload);

    const notificationTitle = payload.notification.title;
    const notificationOptions = {
        body: payload.notification.body,
    };

    self.registration.showNotification(notificationTitle,
        notificationOptions);
});