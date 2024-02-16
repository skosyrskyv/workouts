/**
 * Import function triggers from their respective submodules:
 *
 * import {onCall} from "firebase-functions/v2/https";
 * import {onDocumentWritten} from "firebase-functions/v2/firestore";
 *
 * See a full list of supported triggers at https://firebase.google.com/docs/functions
 */

import { onRequest } from "firebase-functions/v2/https";

// The Firebase Admin SDK to access Firestore.
const { initializeApp } = require("firebase-admin/app");

initializeApp();

exports.getList = onRequest(async (req, res) => {
    res.json({ result: ['1', '2', '3'] });
});