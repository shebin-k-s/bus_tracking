import express from "express";
import mongoose from "mongoose";
import dotenv from 'dotenv';
import { authRouter, busRouter, routeRouter } from "./routes/index.js";


dotenv.config();

const app = express();
app.use(express.json());
app.use(express.urlencoded({ extended: true }));

app.use("/api/v1/auth", authRouter);
app.use("/api/v1/bus", busRouter);
app.use("/api/v1/route", routeRouter);


const PORT = process.env.PORT || 5000;



mongoose.connect(process.env.CONNECTION_URL)
    .then(() => {
        app.listen(PORT, () => {
            console.log(`Server running at ${PORT}`);
        });

    })
    .catch((error) => {
        console.log(error);
    });