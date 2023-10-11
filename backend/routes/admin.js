const express = require('express');
const adminMiddleware = require('../middlewares/admin');
const Order = require('../models/order');
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

// get all orders
adminRouter.get('/admin/get-orders', adminMiddleware, async (req, res) => {
    try {
        const orders = await Order.find({});
        res.json(orders);
        
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


// update order status
adminRouter.post('/admin/update-order-status', adminMiddleware, async (req, res) => {
    try {
        const { id , status} = req.body;
        let order = await Order.findById(id);
        order.status = status;
        order = await order.save();
        res.json(order);
        
    } catch (error) {
        res.status(500).json({ error: error.message });
    }
});

adminRouter.get('/admin/get-total-sales', adminMiddleware, async (req, res)=>{
try {
    
    const orders = await Order.find({});
    let totalSales = 0;
    for (let i = 0; i < orders.length; i++){
        for (let j = 0; j < orders[i].products.length; j++){
            totalSales += orders[i].products[j].product.price*orders[i].products[j].quantity;
            category=orders[i].products[j].category
        }
    }
    // get categories from product collection
    const category = await Product.find({});
    let cat = '';
    let catList = [];
    for (let i = 0; i < category.length; i++){
        cat = category[i].category;
    }


    // get sales by orders category
    let catSales = await geProductCategory(cat);
    let phoneSales = await geProductCategory('Phones and Accessories');
    let bookSales = await geProductCategory('Books');
    let fashionSales = await geProductCategory('Fashion');
    let electronicSales = await geProductCategory('Electronics');
    let computerSales = await geProductCategory('Computers');

    // add categories sales into list
    catList.push(catSales);


    let sales = {
        totalSales,
        catList,
        phoneSales,
        bookSales,
        fashionSales,
        electronicSales,
        computerSales,
    }
    
    res.json(sales);
} catch (error) {
    res.status(500).json({ error: error.message });
    
}
    
})

async function geProductCategory(category) {
    let sales = 0;
    let orderCategory = await Order.find({
        'products.product.category': category,
    });

    for (let i = 0; i < orderCategory.length; i++){
        for (let j = 0; j < orderCategory[i].products.length; j++){
            sales += orderCategory[i].products[j].product.price*orderCategory[i].products[j].quantity;
        }
    }
    
    return sales;
}


module.exports = adminRouter;
