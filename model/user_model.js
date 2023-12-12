const mongoose = require("mongoose");
const { productSchema } = require("./products_model");

const userSchema = mongoose.Schema({
  name: {
    type: String,
    required: true,
    trim: true
  },
  email: {
    required: true,
    type: String,
    trim: true,
    validate: {
      validator: (value) => {
        const emailRegex = /^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$/;

        return value.match(emailRegex);
      },
      message: "Please enter a valid email address"
    }
  },
  password: {
    type: String,
    required: true,
    validate: {
      validator: (value) => {
        return value.length > 6;
        // return value.length > 6 && value.length <= 12;
        // const passwordRegex = /^.{6,12}$/;
        // return value.match(passwordRegex);
      },
      message: "Maximum 12 and Minimum 6 Character"
    }
  },
  address: {
    type: String,
    default: ""
  },
  type: {
    type: String,
    default: "user"
  },
  cart: [
    {
      product: productSchema,
      quantity: {
        type: Number,
        required: true
      }
    }
  ]
});

const User = mongoose.model("User", userSchema);
module.exports = User;
