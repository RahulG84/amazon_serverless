const express = require("express");
const User = require("../model/user_model");
const bcryptjs = require("bcryptjs");
const jwt = require("jsonwebtoken");
const auth = require("../middleware/auth");

const authRouter = express.Router();

// SignUp
authRouter.post("/api-signup", async (req, res) => {
  // 1. to send the request to the server
  // 2. to save the request in the server
  // 3. to recive the reponse from the server

  try {
    const { name, email, password, address } = req.body;

    const existingUser = await User.findOne({ email });
    if (existingUser) {
      return res.status(400).json({
        message: "User with same email already exist"
      });
    }

    //8 is the salt not length of password its basically algorithm concept not know much more
    const hasedPassword = await bcryptjs.hash(password, 8);

    // let is used instated of var for bloc scope
    let user = new User({
      name,
      email,
      address,
      password: hasedPassword
    });

    user = await user.save();
    res.json({ user: user });
    // print('helooo,,,,,',user);
  } catch (error) {
    return res.status(500).json({ error: error.message });
  }
});

//signIn
authRouter.post("/api-signIn", async (req, res) => {
  try {
    const { email, password } = req.body;
    const user = await User.findOne({ email });
    if (!user) {
      return res
        .statusCode(400)
        .json({ message: "User With this email not exist!" });
    }
    const isPasswordMatch = await bcryptjs.compare(password, user.password);
    if (!isPasswordMatch) {
      return res.statusCode(400).json({ message: "Incorrect Password" });
    }
    const token = jwt.sign({ id: user._id }, "passwordKey");
    //
    res.json({ token, ...user._doc });
    //console.log(user);
  } catch (error) {
    return res.status(500).json({ error: `Catch Error ${error.message}` });
  }
});

//Token is Valid or Not
authRouter.post("/tokenIsValid", async (req, res) => {
  try {
    const token = req.header("x-auth-token");
    if (!token) return res.json(false);
    const isVerified = jwt.verify(token, "passwordKey");
    //console.log("isVerified", isVerified);
    if (!isVerified) return res.json(false);
    const user = await User.findById(isVerified.id);
    if (!user) return res.json(false);
    res.json(true);
  } catch (error) {
    return res.status(500).json({ error: `Catch Error ${error.message}` });
  }
});

// get user data

authRouter.get("/", auth, async (req, res) => {
  try {
    const user = await User.findById(req.user);
    res.json({ ...user._doc, token: req.token });
  } catch (error) {
    return res
      .status(500)
      .json({ error: `get user token error ${error.message}` });
  }
});

//

module.exports = authRouter;
