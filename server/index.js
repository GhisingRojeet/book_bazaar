const express = require("express");
const app = express();

const authRouter = require("./routes/auth");
const mongoose = require("mongoose");
const adminRouter = require("./routes/admin");
const productRouter = require("./routes/product");
const userRouter = require("./routes/user");

const dbUrl =
  "mongodb+srv://Rojeet:Forbes@cluster0.y82pfsu.mongodb.net/?retryWrites=true&w=majority&appName=Cluster0";

const PORT = process.env.PORT || 3000;
app.use(express.json());
app.use(authRouter);
app.use(userRouter);
app.use(adminRouter);
app.use(productRouter);

mongoose
  .connect(dbUrl)
  .then(() => {
    console.log("Connected to mongoDB successfully");
  })
  .catch((e) => {
    console.log(e);
  });

app.listen(PORT, "0.0.0.0", () => console.log(`Server started at ${PORT} `));
