const express = require("express");
const User = require("../models/user");

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

        res.json({user: user});

    } catch (e) {
        
    }
});

module.exports = authRouter;