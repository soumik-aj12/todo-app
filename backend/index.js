import express from "express";
import bodyParser from "body-parser";
import cors from "cors";
import dotenv from "dotenv";
import { TodoRouter } from "./routes/todoRoute.js";
dotenv.config();

const app = express();

app.use(bodyParser.json());
app.use(cors());

app.use("/api",TodoRouter);


app.listen(process.env.PORT, () => {
    console.log(`Server running on port ${process.env.PORT}`);
  });