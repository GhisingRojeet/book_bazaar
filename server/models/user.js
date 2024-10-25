const mongoose = require("mongoose");
const { productSchema } = require("./product");

const userSchema = mongoose.Schema({
  name: {
    required: true,
    type: String,
    trim: true,
  },
  email: {
    required: true,
    type: String,
    trim: true,
    validate: {
      validator: (value) => {
        const regExp = /^(?=.*[a-zA-Z])(?=.*\d)[a-zA-Z0-9._%+-]+@gmail\.com$/;
        return value.match(regExp);
      },
      message: "Please enter a valid email address",
    },
  },
  password: {
    required: true,
    type: String,
  },

  phone: {
    type: Number,
    required: true,
    validate: {
      validator: (value) => {
        // Phone number must be 10 digits and start with 98
        const regExp = /^98\d{8}$/;
        return regExp.test(value.toString());
      },
      message: "Enter valid phone number",
    },
  },

  address: {
    type: String,
    default: "",
  },
  type: {
    type: String,
    default: "user",
  },
  cart: [
    {
      product: productSchema,
      quantity: {
        type: Number,
        required: true,
      },
    },
  ],
});

const userModel = mongoose.model("user", userSchema);

module.exports = userModel;
