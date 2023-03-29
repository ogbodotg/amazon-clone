const mongoose = require("mongoose");
const {productSchema} = require('../models/product');

const userSchema = mongoose.Schema({
  name: {
    type: String,
    required: true,
    trim: true,
  },
  email: {
    type: String,
    required: true,
    trim: true,
    validate: {
      validator: (value) => {
        const regexp =
          /^(([^<>()[\]\.,;:\s@\"]+(\.[^<>()[\]\.,;:\s@\"]+)*)|(\".+\"))@(([^<>()[\]\.,;:\s@\"]+\.)+[^<>()[\]\.,;:\s@\"]{2,})$/i;
        return value.match(regexp);
      },
      message: "The Email you entered is invalid",
    },
  },
  password: {
    required: true,
    type: String,
    validate: {
      validator: (value) => {
        return value.length > 8;
      },
      message: "Password length must be up to eight characters",
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
  isAdmin: {
    type: Boolean,
    default: false,
  },
  cart: [
    {
      product: productSchema,
      quantity: {
        type: Number,
        required: true,
      },
    }
  ],
});

const User = mongoose.model("User", userSchema);
module.exports = User;
