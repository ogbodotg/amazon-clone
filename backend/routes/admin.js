const express = require('express');
const adminMiddleware = require('../middlewares/admin');
const {Product} = require('../models/product');
const adminRouter = express.Router();

// add products

adminRouter.post('/admin/add-product', adminMiddleware, async (req, res) => {
    try {
        const { productName, productDescription, quantity, price, productImages, category, } = req.body;
        let product = new Product({
            productName, productDescription, quantity, price, productImages, category,
        });
        product = await product.save();
        res.json(product);
    } catch (error) {
        res.status(500).json({ error: error.message });
    }
});

// get all products
adminRouter.get('/admin/get-products', adminMiddleware, async (req, res) => {
    try {
        const products = await Product.find({});
        res.json(products);
        
    } catch (error) {
        res.status(500).json({ error: error.message });
    }
});

// get single product

// delete product
adminRouter.post('/admin/delete-product', adminMiddleware, async (req, res) => {
    try {
        const { id } = req.body;
        let product = await Product.findByIdAndDelete(id);
        res.json(product);
        
    } catch (error) {
        res.status(500).json({ error: error.message });
    }
});



module.exports = adminRouter;
