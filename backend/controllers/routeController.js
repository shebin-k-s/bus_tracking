import Route from "../models/routeModel.js";

export const addRoute = async (req, res) => {

    console.log(req.body);
    

    const { routeNumber, stops } = req.body
    try {

        const reversedStops = stops.map(stop => {
            const reversedCoordinates = [stop.location.coordinates[1], stop.location.coordinates[0]];

            return {
                ...stop,
                location: {
                    ...stop.location,
                    coordinates: reversedCoordinates 
                }
            };
        });
        const route = new Route({
            routeNumber,
            stops :reversedStops,

        });
        await route.save();
        res.status(201).json({ route });
    } catch (error) {
        if (error.name === "ValidationError") {
            const errors = Object.values(error.errors).map(err => err.message);
            return res.status(400).json({ message: errors.join(", ") });
        }
        return res.status(500).json({ message: "Internal server error" })
    }
};


export const getAllRoutes = async (req, res) => {
    try {
        const routes = await Route.find();

        if (routes.length === 0) {
            return res.status(404).json({ message: 'No routes found' });
        }

        res.status(200).json({ routes });
    } catch (error) {
        res.status(400).json({ message: error.message });
    }
};