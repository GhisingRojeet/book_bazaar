const express = require("express");
const adminRouter = express.Router();
const admin = require("../middlewares/admin");
const { Product } = require("../models/product");
const Order = require("../models/order");
const User = require("../models/user");

//  add product
adminRouter.post("/admin/add-products", admin, async (req, res) => {
  try {
    const { name, description, images, price, category, quantity } = req.body;
    let product = new Product({
      name,
      description,
      images,
      quantity,

      price,
      category,
    });
    product = await product.save();
    res.json(product);
  } catch (e) {
    res.status(501).json({ error: e.message });
  }
});

//edit Product
adminRouter.post("/admin/edit-products/:id", admin, async (req, res) => {
  try {
    const { id } = req.params;
    const { name, description, images, price, category, quantity } = req.body;

    let product = await Product.findById(id);
    if (!product) {
      return res.status(404).json({ error: "Product not found" });
    }

    product.name = name || product.name;
    product.description = description || product.description;
    product.images = images || product.images;
    product.price = price || product.price;
    product.category = category || product.category;
    product.quantity = quantity || product.quantity;

    product = await product.save();

    res.json(product);
  } catch (e) {
    res.status(500).json({ error: e.message });
  }
});
//get all users
adminRouter.get("/admin/get-users", admin, async (req, res) => {
  try {
    const users = await User.find({});
    res.json(users);
  } catch (e) {
    res.status(500).json({ error: e.message });
  }
});

//get all products
adminRouter.get("/admin/get_products", admin, async (req, res) => {
  try {
    const products = await Product.find({});
    res.json(products);
  } catch (e) {
    res.status(500).json({ error: e.message });
  }
});

//delete user
adminRouter.post("/admin/delete-user", admin, async (req, res) => {
  try {
    const { id } = req.body;
    let users = await User.findByIdAndDelete(id);

    res.json(users);
  } catch (e) {
    res.status(500).json({ error: e.message });
  }
});

//delete all products
adminRouter.post("/admin/delete_products", admin, async (req, res) => {
  try {
    const { id } = req.body;
    let product = await Product.findByIdAndDelete(id);

    res.json(product);
  } catch (e) {
    res.status(500).json({ error: e.message });
  }
});

//fetchallOrders
adminRouter.get("/admin/get-orders", admin, async (req, res) => {
  try {
    const orders = await Order.find({});
    res.json(orders);
  } catch (e) {
    res.status(500).json({ error: e.message });
  }
});

//change order status
adminRouter.post("/admin/change-order-status", admin, async (req, res) => {
  try {
    const { id, status } = req.body;
    let order = await Order.findById(id);
    order.status = status;
    order = await order.save();

    res.json(order);
  } catch (e) {
    res.status(500).json({ error: e.message });
  }
});

adminRouter.get("/admin/analytics", admin, async (req, res) => {
  try {
    const orders = await Order.find({});
    let totalEarnings = 0;
    for (let i = 0; i < orders.length; i++) {
      for (let j = 0; j < orders[i].products.length; j++) {
        totalEarnings +=
          orders[i].products[j].quantity * orders[i].products[j].product.price;
      }
    }
    //categoryWise Order Fetching
    let literatureEarnings = await fetchCategoryWiseProducts("Literature");
    let romanceEarnings = await fetchCategoryWiseProducts("Romance");
    let scienceEarnings = await fetchCategoryWiseProducts("Science");
    let horrorEarnings = await fetchCategoryWiseProducts("Horror");
    let historyEarnings = await fetchCategoryWiseProducts("History");
    let disciplineEarnings = await fetchCategoryWiseProducts("Discipline");
    let biographyEarnings = await fetchCategoryWiseProducts("Biography");

    let earnings = {
      totalEarnings,
      literatureEarnings,
      romanceEarnings,
      scienceEarnings,
      horrorEarnings,
      historyEarnings,
      disciplineEarnings,
      biographyEarnings,
    };
    res.json(earnings);
  } catch (e) {
    res.status(500).json({ error: e.message });
  }
});

async function fetchCategoryWiseProducts(category) {
  let earnings = 0;
  let categoryOrders = await Order.find({
    "products.product.category": category,
  });
  for (let i = 0; i < categoryOrders.length; i++) {
    for (let j = 0; j < categoryOrders[i].products.length; j++) {
      earnings +=
        categoryOrders[i].products[j].quantity *
        categoryOrders[i].products[j].product.price;
    }
  }
  return earnings;
}

module.exports = adminRouter;
