const express = require('express');
const Document = require('../models/documentm');
const auth = require('../middlewares/authm')
const documentRouter = express.Router();

documentRouter.post('/doc/create', auth, async (req, res) => {
    try {
        const {createdAt} = req.body;
        let document = new Document({
            uid: req.user,
            title: 'Untitiled Document',
            createdAt,
        });

        document = await document.save();
        res.json(document);
        
    } catch (e) {
        res.status(500).json({ error: e.message});
    }
});

module.exports =  documentRouter;