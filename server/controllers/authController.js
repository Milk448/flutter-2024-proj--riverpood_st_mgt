// server\controllers\authController.js
const User = require("../models/User");
const jwt = require("jsonwebtoken"); // Import jsonwebtoken

const signup = async (req, res) => {
  try {
    const { username, password } = req.body;
    const userExists = await User.findOne({ username });
    if (userExists) {
      return res.status(400).json({ message: "Username already exists" });
    }
    const newUser = new User({ username, password });
    await newUser.save();
    const token = jwt.sign(
      { userId: newUser._id, role: newUser.role },
      process.env.JWT_SECRET,
      {
        expiresIn: "1h",
      }
    );
    res.status(201).json({ token, userId: newUser._id, role: newUser.role }); // Send role
  } catch (error) {
    res.status(500).json({ message: "Something went wrong" });
  }
};

const signin = async (req, res) => {
  try {
    const { username, password } = req.body;
    const user = await User.findOne({ username });
    if (!user) {
      return res.status(401).json({ message: "Invalid credentials" });
    }
    const isMatch = await user.comparePassword(password);
    if (!isMatch) {
      return res.status(401).json({ message: "Invalid credentials" });
    }
    const token = jwt.sign(
      { userId: user._id, role: user.role },
      process.env.JWT_SECRET,
      {
        expiresIn: "1h",
      }
    );
    res.json({ token, userId: user._id, role: user.role }); // Send role
  } catch (error) {
    res.status(500).json({ message: "Something went wrong" });
  }
};

const updateUser = async (req, res) => {
  try {
    const { username, password } = req.body;
    const updatedUser = await User.findOneAndUpdate(
      { _id: req.user.userId }, // Find the user based on their user ID
      { username, password }, // Update the username and password
      { new: true } // Return the updated user document
    );
    if (!updatedUser) {
      return res.status(404).json({ message: "User not found" });
    }
    res.json(updatedUser);
  } catch (error) {
    res.status(500).json({ message: "Something went wrong" });
  }
};

const deleteUser = async (req, res) => {
  try {
    const deletedUser = await User.findOneAndDelete({
      _id: req.user.userId, // Find the user based on their user ID
    });
    if (!deletedUser) {
      return res.status(404).json({ message: "User not found" });
    }
    res.json({ message: "User deleted successfully" });
  } catch (error) {
    res.status(500).json({ message: "Something went wrong" });
  }
};

module.exports = { signup, signin, updateUser, deleteUser };
