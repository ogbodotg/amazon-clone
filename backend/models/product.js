const mongoose = require("mongoose");
const ratingSchema = require("./rating");

const productSchema = mongoose.Schema({
    productName: {
        type: String,
        required: true,
        trim: true,
    },
    productDescription: {
        type: String,
        required: true,
        trim: true,
    },
    productImages: [
        {
            type: String,
            required: true,
        }
    ],
    quantity: {
        type: Number,
        required:true,
    },
    price: {
        type: Number,
        required: true,
    },
    category: {
        type: String,
        required:true,
    },
    ratings: [
        ratingSchema
    ],
        
    
});

const Product = mongoose.model('Product', productSchema);
module.exports = Product;
