// web/firebase-messaging-sw.js

importScripts('https://www.gstatic.com/firebasejs/9.0.0/firebase-app-compat.js');
importScripts('https://www.gstatic.com/firebasejs/9.0.0/firebase-messaging-compat.js');

firebase.initializeApp({
  apiKey: "AIzaSyAUwYqwfekzl72dvGkyFE7irzZdh4Qa9fk",
  authDomain: "cool-app-641a1.firebaseapp.com",
  projectId: "my-cool-id",
  storageBucket: "my-cool-id.firebaseio.com",
  messagingSenderId: "460609975158",
  appId: "1:460609975158:android:4368eef2b9acf8efb38057",
  measurementId: "G-2JY8LGXM4M"
});

// Retrieve an instance of Firebase Messaging so that it can handle background
// messages.
const messaging = firebase.messaging();
