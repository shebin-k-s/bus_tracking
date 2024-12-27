import Bus from "../models/busModel.js";
import Route from "../models/routeModel.js";

export const addBus = async (req, res) => {
    const { busNumber, routeId, driverName, driverNumber, currentLocation } = req.body;

    try {
        const route = await Route.findById(routeId);
        if (!route) {
            return res.status(404).json({ message: 'Route not found' });
        }

        const newBus = new Bus({
            busNumber,
            routeId,
            driverName,
            driverNumber,
            currentLocation
        })
        await newBus.save();

        return res.status(201).json({ message: "Bus added", bus: newBus, });

    } catch (error) {
        console.log(error);
        if (error.name === "ValidationError") {
            const errors = Object.values(error.errors).map(err => err.message);
            return res.status(400).json({ message: errors.join(", ") });
        }
        return res.status(500).json({ message: "Internal server error" })

    }
}

export const getAllBuses = async (req, res) => {
    try {
        const buses = await Bus.find().populate('routeId');
        res.status(200).json({ buses });

    } catch (error) {
        res.status(500).json({ message: error.message });
    }
};

export const getBusById = async (req, res) => {
    try {
        const { id } = req.params;
        const bus = await Bus.findById(id).populate('routeId');
        if (!bus) {
            return res.status(404).json({ message: 'Bus not found' });
        }
        res.status(200).json({ bus });
    } catch (error) {
        res.status(500).json({ message: error.message });
    }
};

export const updateBus = async (req, res) => {
    try {
        const { id } = req.params;
        const updates = req.body;

        if (!Object.keys(updates).length) {
            return res.status(400).json({ message: 'No updates provided' });
        }

        const updatedBus = await Bus.findByIdAndUpdate(id, updates, { new: true, runValidators: true });

        if (!updatedBus) {
            return res.status(404).json({ message: 'Bus not found' });
        }

        res.status(200).json({ updatedBus });
    } catch (error) {
        if (error.name === "ValidationError") {
            const errors = Object.values(error.errors).map(err => err.message);
            return res.status(400).json({ message: errors.join(", ") });
        }
        res.status(400).json({ message: error.message });
    }
};
