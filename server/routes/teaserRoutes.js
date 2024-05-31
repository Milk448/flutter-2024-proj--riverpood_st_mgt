const express = require("express");
const router = express.Router();
const { getTeasers } = require("../controllers/teaserController");

router.get("/", getTeasers);

module.exports = router;
