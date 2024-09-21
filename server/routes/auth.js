const express = require("express");
const User = require("../models/user");
const jwt = require("jsonwebtoken");
const auth = require("../middlewares/authm");

const authRouter =  express.Router();

authRouter.post("/api/signup", async (req, res) =>{
    try {
        const {name, email, profilepic} = req.body;

        let user = await User.findOne({email: email});

        if(!user){
            user = new User({
                email,
                profilepic,
                name,
            });
            user = await user.save();
        }

        const token = jwt.sign({id: user._id}, "passwordKey");
        res.status.json({ user, token });

        res.json({user, token});

    } catch (e) {
        res.status(500).json({ error: e.message});

    }
});

authRouter.get('/', auth, async (req, res) => {
    //console.log(req.user);
    const user = await User.findById(req.user);
    //const token = req.token;
    res.json({ user, token: req.token });
});

module.exports = authRouter;