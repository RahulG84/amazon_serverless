const express = require("express");

const auth = require("../middleware/auth");
const { Product } = require("../model/products_model");
const productRouter = express.Router();

// /api/products?category=Mobile
// api/amazon?theme=dark
// api/product:category=Mobile

//get products
productRouter.get("/api/products", auth, async (req, res) => {
  try {
    console.log(req.query.category);
    const products = await Product.find({ category: req.query.category });
    res.json(products);
  } catch (error) {
    res.status(500).json({ error: error.message });
  }
});

// search products and get them

productRouter.get("/api/products/search/:name", auth, async (req, res) => {
  // /api/products/search/i
  try {
    const products = await Product.find({
      name: { $regex: req.params.name, $options: "i" }
      //       to acess the name parameter so that we passed in the params
      //       i ----> iphone
      //       regex is built-in method in the mogoDB
    });
    // in the Product item is find with the name and return to the products and this products is send in the response
    res.json(products);
    //    console.log(name);
  } catch (e) {
    res.status(500).json({ error: e.message });
  }
});

module.exports = productRouter;
