const jwt = require("jsonwebtoken");

const authenticateJWT = (req, res, next) => {
  const authHeader = req.headers.authorization;
  if (authHeader) {
    const token = authHeader.split(" ")[1]; // Extract the token

    jwt.verify(token, process.env.JWT_SECRET, (err, user) => {
      if (err) {
        return res.status(401).json({ message: "Invalid or expired token" });
      }
      req.user = user; // Attach user info to the request object
      next();
    });
  } else {
    res.status(401).json({ message: "Unauthorized: Missing token" });
  }
};

module.exports = authenticateJWT;
