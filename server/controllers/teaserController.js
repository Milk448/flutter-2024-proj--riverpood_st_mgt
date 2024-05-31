const Teaser = require("../models/Teaser");

const getTeasers = async (req, res) => {
  try {
    const teasers = await Teaser.find({});
    res.json(teasers);
  } catch (error) {
    res.status(500).json({ message: "Something went wrong" });
  }
};

module.exports = { getTeasers };
