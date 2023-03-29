const express = require("express");
const mongoose = require("mongoose");
const auth = require("./routes/auth");
const adminRouter = require("./routes/admin");
const dotenv = require("dotenv");
const productRouter = require("./routes/products");
const userRouter = require("./routes/user");

const app = express();
dotenv.config();

// middlewares
app.use(express.json());
app.use(auth);
app.use(adminRouter);
app.use(productRouter);
app.use(userRouter);


 
// DB connections
const connect = async () => {
  try {
    await mongoose.connect(process.env.MONGO_URI);
    console.log("Connected to Mongoose");
  } catch (error) {
    console.log("Cannot connect to Mongoose");
    throw error;
  }
};

mongoose.connection.on("disconnected", () => {
  console.log("Database Disconnected");
});

const PORT = 4000;
app.listen(PORT, "0.0.0.0", () => {
  connect();

  console.log(`Amazon Clone Connected Successfully on port: ${PORT} `);
});
