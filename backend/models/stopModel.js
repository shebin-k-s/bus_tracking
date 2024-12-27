import mongoose from "mongoose";

const stopSchema = new mongoose.Schema({
    name: {
        type: String,
        required: [true, 'Stop name is required'],
        trim: true
    },
    location: {
        type: {
            type: String,
            default: 'Point'
        },
        coordinates: {
            type: [Number],
            required: [true, 'Coordinates are required'],
            validate: {
                validator: function (v) {
                    return v.length === 2;
                },
                message: 'Coordinates must include exactly two values: [longitude, latitude]'
            }
        }
    },


});

export default stopSchema;