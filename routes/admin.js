const express = require("express");
const admin = require("../middleware/admin");
const { Product } = require("../model/products_model");

const adminRouter = express.Router();

//Add-Post
adminRouter.post("/admin/add-product", admin, async (req, res) => {
  try {
    const { name, description, quantity, images, category, price } = req.body;
    let products = new Product({
      name,
      description,
      quantity,
      images,
      category,
      price
    });
    products = await products.save();
    res.json(products);
  } catch (e) {
    return res.status(500).json({ error: e.error });
  }
});

//get the products

adminRouter.get("/admin/get-products", admin, async (req, res) => {
  try {
    const productData = await Product.find({});
    res.json(productData);
    console.log(productData);
  } catch (error) {
    res.status(500).json({ error: error.message });
  }
});

//delete the products

adminRouter.post("/admin/delete-product", async (req, res) => {
  try {
    const { id } = req.body;
    let product = await Product.findByIdAndDelete(id);
    // particular id document is deleted and remaining all the doc saved in the product variable
    // product = await product.save();
    // This will save the all update list of  the product doc expecting deleted id
    res.json("product");
    // This will return the product doc in the response
  } catch (error) {
    res.status(500).json({ error: "error.message" });
  }
});

module.exports = adminRouter;
