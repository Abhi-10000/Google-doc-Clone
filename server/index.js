const express = require("express");
const mongoose = require("mongoose");
const authRouter = require("./routes/auth");


const PORT =  3001;


const app = express();


app.use(express.json());
app.use(authRouter);

const DB = "mongodb+srv://nagaabhilash18:180105@cluster0.lpqoczr.mongodb.net/?retryWrites=true&w=majority&appName=Cluster0";


mongoose.connect(DB).then(() => {
    console.log('Connection Successful!')
}).catch((err) =>{
    console.log(err);
})

app.listen(PORT, "0.0.0.0", () =>{
    console.log(`Connected at port ${PORT}`);
});