import express from "express";
import { addBus, getAllBuses, getBusById, updateBus } from "../controllers/busController.js";

const router = express.Router()



router.route("/")
    .get(getAllBuses)


router.route("/add")
    .post(addBus)


router.route("/:id")
    .get(getBusById)

router.route("/update/:id")
    .patch(updateBus)






export default router;