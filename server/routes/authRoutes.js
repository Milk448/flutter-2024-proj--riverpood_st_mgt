const express = require("express");
const router = express.Router();
const {
  signup,
  signin,
  updateUser,
  deleteUser,
} = require("../controllers/authController");
const authenticateJWT = require("../middleware/authMiddleware");

// Sign up route
router.post("/signup", signup);
// Sign in route
router.post("/signin", signin);
// Update user route - protected by JWT authentication
router.put("/update", authenticateJWT, updateUser);
// Delete user route - protected by JWT authentication
router.delete("/delete", authenticateJWT, deleteUser);

module.exports = router;
