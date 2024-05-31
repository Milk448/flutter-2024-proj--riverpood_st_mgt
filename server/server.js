const express = require("express");
const connectDB = require("./config/database");
const authRoutes = require("./routes/authRoutes");
const teaserRoutes = require("./routes/teaserRoutes");
const adminRoutes = require("./routes/adminRoutes");
require("dotenv").config();

const app = express();
const port = process.env.PORT || 5000;

app.use(express.json());

connectDB();

app.use("/api/auth", authRoutes);
app.use("/api/teasers", teaserRoutes);
app.use("/api/admin", adminRoutes);

app.listen(port, () => {
  console.log(`Server listening at http://localhost:${port}`);
});
