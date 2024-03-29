const express = require('express');
const authMiddleware = require('../middlewares/auth');
const {Product} = require('../models/product');
var Double = require("mongodb").Double;


const productRouter = express.Router();

// get products category
productRouter.get('/api/products', authMiddleware, async (req, res) => {
    try {
        const products = await Product.find({
            category: req.query.category,
        });
        res.json(products);
        
    } catch (error) {
        res.status(500).json({ error: error.message });
    }
});

// search products
productRouter.get('/api/products/search/:productName', authMiddleware, async (req, res) => {
    try {
        const products = await Product.find({
            productName: { $regex: req.params.productName, $options: "i" }
            // name:req.params.name, // find product by specific query
            
        });
        res.json(products);
        
    } catch (error) {
        res.status(500).json({ error: error.message });
    }
});

// product rating route
productRouter.post('/api/product/rate', authMiddleware, async (req, res) => {
    try {
        const { id, rating } = req.body;

        var rate = Double(rating);

        console.log(`This is normal rating ${rate}`);
        let product = await Product.findById(id);

        for (let i = 0; i < product.ratings.length; i++){
            if (product.ratings[i].userId == req.user) {
                product.ratings.splice(i, 1);
                break;
            }
        }


        const ratingSchema = {
            userId: req.user,
            rating:rate,
        };
        product.ratings.push(ratingSchema);
        product = await product.save();

        res.json(product);
        
    } catch (error) {
        res.status(500).json({ error: error.message });
    }
});

// deal of the day calculated by the number of product ratings
productRouter.get("/api/top-deal", authMiddleware, async (req, res) => {
    try {
        let products = await Product.find({});

        products = products.sort((a, b) => {
            let aTotal = 0;
            let bTotal = 0;
            for (let i = 0; i < a.ratings.length; i++) {
                aTotal = a.ratings[i].rating;
            }

            for (let i = 0; i < b.ratings.length; i++) {
                bTotal = b.ratings[i].rating;
            }

            return aTotal < bTotal ? 1 : -1;

        });
        res.json(products[0]);

    } catch (error) {
        res.status(500).json({ error: error.message });
    }
})

module.exports = productRouter;
