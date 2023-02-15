const express = require("express");
const User = require("../models/users");
const bcrypt = require("bcryptjs");
const jwt = require("jsonwebtoken");
const authMiddleware = require("../middlewares/auth");

const auth = express.Router();

// register route
auth.post("/api/register", async (req, res) => {
  try {
    const { name, email, password } = req.body;
    const userExists = await User.findOne({ email });
    if (userExists) {
      return res.status(400).json({ msg: "Email already in use" });
    }
    const salt = bcrypt.genSaltSync(10);
    const hashedPassword = await bcrypt.hash(password, salt);

    let user = new User({
      email,
      password: hashedPassword,
      name,
    });
    user = await user.save();
    res.json(user);
  } catch (error) {
    res.status(500).json(error.message);
  }
});

// login route
auth.post("/api/login", async (req, res) => {
  try {
    const { email, password } = req.body;
    const user = await User.findOne({ email: email });
    if (!user) {
      return res.status(400).json({ msg: "User doesn't exist" });
    }
    // compare password
    const passwordMatches = await bcrypt.compare(password, user.password);
    if (!passwordMatches) {
      return res.status(400).json({ msg: "Incorrect login credential" });
    }

    const token = jwt.sign({ id: user._id }, "key");
    res.json({ token, ...user._doc });
  } catch (error) {
    res.status(500).json({ error: error.message });
  }
});

auth.post("/tokenValidity", async (req, res) => {
  try {
    const token = req.header("auth-token");
    if (!token) return res.json(false);
    const verifyToken = jwt.verify(token, "key");
    if (!verifyToken) return res.json(false);
    const user = await User.findById(verifyToken.id);
    if (!user) return res.json(false);
    res.json(true);
  } catch (error) {
    res.status(500).json({ error: error.message });
  }
});

// get user data
auth.get("/", authMiddleware, async (req, res) => {
  const user = await User.findById(req.user);
  res.json({ ...user._doc, token: req.token });
});
module.exports = auth;
