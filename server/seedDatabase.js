const mongoose = require("mongoose");
const Teaser = require("./models/Teaser"); // Import your Teaser model

require("dotenv").config(); // Load environment variables

async function seedDatabase() {
  try {
    await mongoose.connect(`${process.env.MONGODB_URI}`, {
      useNewUrlParser: true,
      useUnifiedTopology: true,
    });

    console.log("Connected to MongoDB");

    // Define your teaser data here
    const teasers = [
      // general knowledge
      {
        question: "What is the capital of France?",
        options: ["Berlin", "Paris", "Rome", "Madrid"],
        correctAnswer: 1, // Index of the correct answer in the options array
        category: "General Knowledge",
      },
      {
        question:
          "What is the name of the world's largest collection of mummies?",
        options: [
          "Terracotta Army",
          "Valley of the Kings",
          "British Museum",
          "Catacombs of Paris",
        ],
        correctAnswer: 0,
        category: "General Knowledge",
      },
      {
        question:
          "What is the traditional name for the six strings on a classical guitar?",
        options: [
          "Melody, Harmony, Rhythm, Bass",
          "Solfege Do-Re-Mi",
          "E A D G B E",
          "High, Middle, Low",
        ],
        correctAnswer: 2,
        category: "General Knowledge",
      },
      {
        question: "What is the technical term for the fear of public speaking?",
        options: [
          "Agoraphobia",
          "Glossophobia",
          "Claustrophobia",
          "Xenophobia",
        ],
        correctAnswer: 1,
        category: "General Knowledge",
      },
      {
        question: "What was the original name of the search engine 'Google'?",
        options: ["BackRub", "AltaVista", "Yahoo!", "WebCrawler"],
        correctAnswer: 0,
        category: "General Knowledge",
      },
      {
        question: "What is the pigment that gives blood its red color?",
        options: ["Melanin", "Chlorophyll", "Hemoglobin", "Carotene"],
        correctAnswer: 2,
        category: "General Knowledge",
      },
      //science
      {
        question: "What is the smallest unit of life?",
        options: ["Organ", "Tissue", "Cell", "Molecule"],
        correctAnswer: 2,
        category: "Science",
      },
      {
        question: "Neutrons decay into protons and what other particle?",
        options: ["Electron", "Positron", "Neutrino", "Quark"],
        correctAnswer: 2,
        category: "Science",
      },
      {
        question:
          "What is the name of the specific type of bond that joins sugar molecules in a chain?",
        options: [
          "Peptide bond",
          "Ionic bond",
          "Hydrogen bond",
          "Glycosidic bond",
        ],
        correctAnswer: 3,
        category: "Science",
      },
      {
        question:
          "In the theory of evolution, what is the mechanism by which advantageous traits become more common in a population over generations?",
        options: [
          "Ontogeny recapitulates phylogeny",
          "Natural selection",
          "Genetic drift",
          "Lamarckism",
        ],
        correctAnswer: 1,
        category: "Science",
      },
      {
        question:
          "What is the name of the phenomenon where light bends as it passes through a gravitational field?",
        options: [
          "Doppler effect",
          "Photoelectric effect",
          "Gravitational lensing",
          "Compton scattering",
        ],
        correctAnswer: 2,
        category: "Science",
      },
      {
        question:
          "What is the outermost, high-temperature layer of the Sun's atmosphere?",
        options: ["Photosphere", "Chromosphere", "Corona", "Convection zone"],
        correctAnswer: 3,
        category: "Science",
      },
      // history
      {
        question: "Who painted the Mona Lisa?",
        options: ["Michelangelo", "Leonardo da Vinci", "Raphael", "Donatello"],
        correctAnswer: 1,
        category: "History",
      },
      {
        question:
          "The theory of Heliocentrism, placing the Sun at the center of the solar system, was championed by which scientist during the Scientific Revolution?",
        options: [
          "Isaac Newton",
          "Galileo Galilei",
          "Johannes Kepler",
          "René Descartes",
        ],
        correctAnswer: 1,
        category: "History",
      },
      {
        question:
          "The Gupta Empire, known for its advancements in mathematics, astronomy, and literature, flourished in which region of the world?",
        options: [
          "Mesopotamia",
          "Ancient Egypt",
          "Indus Valley",
          "Indian Subcontinent",
        ],
        correctAnswer: 4,
        category: "History",
      },
      {
        question:
          "The storming of the Bastille prison in 1789 is considered a pivotal event in which revolution?",
        options: [
          "The American Revolution",
          "The French Revolution",
          "The Haitian Revolution",
          "The Russian Revolution",
        ],
        correctAnswer: 1,
        category: "History",
      },
      {
        question:
          "The doctrine of Mandate System, established after World War I, aimed to oversee the colonies of defeated empires by which international organization?",
        options: [
          "The United Nations",
          "The League of Nations",
          "The North Atlantic Treaty Organization (NATO)",
          "The World Trade Organization (WTO)",
        ],
        correctAnswer: 1,
        category: "History",
      },
      {
        question:
          "Which event is considered the end of the Middle Ages in Western Europe?",
        options: [
          "The fall of the Roman Empire",
          "The Black Death",
          "The Renaissance",
          "The printing press invention",
        ],
        correctAnswer: 1,
        category: "History",
      },
      {
        question: "What is the fuel used in nuclear power plants?",
        options: [
          "Fossil fuels",
          "Solar energy",
          "Wind power",
          "Fissionable isotopes",
        ],
        correctAnswer: 4,
        category: "Science",
      },

      {
        question:
          "What force is responsible for keeping the Earth in its orbit around the Sun?",
        options: ["Friction", "Electromagnetism", "Gravity", "Nuclear force"],
        correctAnswer: 2,
        category: "Science",
      },
      // sports
      {
        question: "What country won the FIFA World Cup in 2022?",
        options: ["Argentina", "Brazil", "France", "Germany"],
        correctAnswer: 0,
        category: "Sports",
      },
      {
        question:
          "In baseball, what is the term for a pitch that intentionally hits the batter?",
        options: ["Beanball", "Fastball", "Curveball", "Slider"],
        correctAnswer: 0,
        category: "Sports",
      },
      {
        question:
          "In which sport is a 'gimmie' a putt considered extremely easy to make?",
        options: ["Basketball", "Golf", "Tennis", "Soccer"],
        correctAnswer: 1,
        category: "Sports",
      },
      {
        question:
          "What is the name of the prestigious annual horse race held in Epsom Downs, England?",
        options: [
          "Kentucky Derby",
          "Preakness Stakes",
          "Belmont Stakes",
          "The Epsom Derby",
        ],
        correctAnswer: 3,
        category: "Sports",
      },
      {
        question:
          "In professional cycling, what is the name given to the rider who leads the peloton (main group) during a stage?",
        options: [
          "Sprinter",
          "Climber",
          "Time Trialist",
          "Maillot Jaune (Yellow Jersey)",
        ],
        correctAnswer: 2,
        category: "Sports",
      },
      {
        question:
          "In snooker, how many points are awarded for potting the black ball?",
        options: ["4", "7", "10", "14 (highest possible score)"],
        correctAnswer: 3,
        category: "Sports",
      },
      // entertainment
      {
        question:
          "What is the name of the main character in the Harry Potter series?",
        options: [
          "Hermione Granger",
          "Ron Weasley",
          "Draco Malfoy",
          "Harry Potter",
        ],
        correctAnswer: 3,
        category: "Entertainment",
      },
      {
        question:
          "What is the name of the fictional detective who always wears a deerstalker hat and smokes a calabash pipe?",
        options: [
          "Sherlock Holmes",
          "Hercule Poirot",
          "C. Auguste Dupin",
          "Adrian Monk",
        ],
        correctAnswer: 0,
        category: "Entertainment",
      },
      {
        question:
          "What is the name of the reclusive artist who painted a series of water lilies?",
        options: [
          "Claude Monet",
          "Vincent van Gogh",
          "Pablo Picasso",
          "Leonardo da Vinci",
        ],
        correctAnswer: 0,
        category: "Entertainment",
      },
      {
        question:
          "Which iconic rock band is known for their song 'Stairway to Heaven'?",
        options: [
          "Led Zeppelin",
          "The Beatles",
          "Pink Floyd",
          "The Rolling Stones",
        ],
        correctAnswer: 0,
        category: "Entertainment",
      },
      {
        question:
          "What is the name of the fictional film director who appears in many of Quentin Tarantino's movies?",
        options: [
          "Robert Rodriguez",
          "Samuel L. Jackson",
          "Uma Thurman",
          "Bruce Willis",
        ],
        correctAnswer: 1,
        category: "Entertainment",
      },
      {
        question:
          "What is the name of the annual awards ceremony that honors excellence in television?",
        options: ["The Grammys", "The Oscars", "The Emmys", "The Tonys"],
        correctAnswer: 2,
        category: "Entertainment",
      },
      // geography
      {
        question: "What is the highest mountain in the world?",
        options: ["K2", "Kangchenjunga", "Lhotse", "Mount Everest"],
        correctAnswer: 3,
        category: "Geography",
      },
      {
        question: "Which landlocked country borders the most countries?",
        options: ["Austria", "Bolivia", "Switzerland", "Kazakhstan"],
        correctAnswer: 3,
        category: "Geography",
      },
      {
        question:
          "What is the name of the world's largest hot desert, outside of the polar regions?",
        options: ["Sahara", "Kalahari", "Gobi", "Patagonian"],
        correctAnswer: 0,
        category: "Geography",
      },
      {
        question: "The Strait of Gibraltar connects which two seas?",
        options: [
          "Black Sea and Aegean Sea",
          "Mediterranean Sea and Atlantic Ocean",
          "Red Sea and Arabian Sea",
          "Caspian Sea and Black Sea",
        ],
        correctAnswer: 1,
        category: "Geography",
      },
      {
        question:
          "What is the name of the large island located east of Madagascar?",
        options: ["Sri Lanka", "Sumatra", "Borneo", "Réunion"],
        correctAnswer: 1,
        category: "Geography",
      },
      {
        question:
          "The Amazon River flows through which South American country for the longest distance?",
        options: ["Brazil", "Peru", "Colombia", "Bolivia"],
        correctAnswer: 0,
        category: "Geography",
      },
    ];

    // Clear the existing teasers collection
    await Teaser.deleteMany({});

    // Insert the teaser data into the database
    await Teaser.insertMany(teasers);

    console.log("Database seeded successfully");
    process.exit(0); // Exit the script after seeding
  } catch (error) {
    console.error("Error seeding database:", error);
    process.exit(1);
  } finally {
    await mongoose.disconnect(); // Disconnect from the database
  }
}

seedDatabase();
