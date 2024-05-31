const mongoose = require("mongoose");

const teaserSchema = new mongoose.Schema({
  question: { type: String, required: true },
  options: [{ type: String, required: true }],
  correctAnswer: { type: Number, required: true },
  category: {
    type: String,
    required: true,
    enum: [
      "General Knowledge",
      "Science",
      "History",
      "Sports",
      "Entertainment",
      "Geography",
    ],
  },
});

module.exports = mongoose.model("Teaser", teaserSchema);
