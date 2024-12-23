import mongoose from "mongoose"
import validator from "validator";

const userSchema = new mongoose.Schema({
    email: {
        type: String,
        required: true,
        unique: true,
        validate: {
            validator: validator.isEmail,
            message: "Invalid email address"
        }
    },
    fullName: {
        type: String,
        required: true,
    },
    password: {
        type: String,
        required: true,
        minlength: 6
    },
})


const User = mongoose.model('User', userSchema)


export default User