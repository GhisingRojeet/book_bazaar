const express = require("express");
const userRouter = express.Router();
const auth = require("../middlewares/auth");
const { Product } = require("../models/product");
const User = require("../models/user");
const Order = require("../models/order");

//edit user api

// userRouter.put("/api/edit-user/:id", auth, async (req, res) => {
//   try {
//     const id = req.params.id;
//     const { name, email, phone, password } = req.body;

//     if (!id) {
//       return res.status(400).json({ error: "User ID is required" });
//     }

//     const user = await User.findById(id); // Await the promise

//     // If no user is found, return an error
//     if (!user) {
//       return res.status(404).json({ error: "User not found" });
//     }

//     // Update only the specified fields
//     if (name !== undefined) user.name = name;
//     if (email !== undefined) user.email = email;
//     if (phone !== undefined) user.phone = phone;
//     if (password !== undefined) user.password = password;

//     // Save the updated user to the database
//     const updatedUser = await user.save();

//     res.status(200).json({
//       message: "User updated successfully",
//       user: {
//         id: updatedUser.id,
//         name: updatedUser.name,
//         email: updatedUser.email,
//         phone: updatedUser.phone,
//         password: updatedUser.password,
//       },
//     });
//   } catch (e) {
//     res.status(500).json({ error: e.message });
//   }
// });

userRouter.put("/api/edit-user/:id", auth, async (req, res) => {
  try {
    const id = req.params.id;
    const { name, email, phone } = req.body;

    if (!id) {
      return res.status(400).json({ error: "User ID is required" });
    }

    const user = await User.findById(id); // Await the promise

    // If no user is found, return an error
    if (!user) {
      return res.status(404).json({ error: "User not found" });
    }

    // Update fields only if they are provided
    if (name !== undefined) user.name = name;

    if (email !== undefined) {
      const emailRegExp =
        /^(?=.*[a-zA-Z])(?=.*\d)[a-zA-Z0-9._%+-]+@gmail\.com$/;
      if (!email.match(emailRegExp)) {
        return res.status(400).json({ error: "Invalid email format" });
      }
      user.email = email;
    }

    if (phone !== undefined) {
      const phoneRegExp = /^98\d{8}$/; // Adjust regex as needed
      if (!phone.toString().match(phoneRegExp)) {
        return res.status(400).json({ error: "Invalid phone number format" });
      }
      user.phone = phone;
    }

    // Only update the password if it's provided
    // if (password !== undefined) {
    //   // Optionally hash the password here if required
    //   user.password = password; // Consider hashing if updating
    // }

    // Save the updated user to the database
    const updatedUser = await user.save();

    res.status(200).json({
      message: "User updated successfully",
      user: {
        id: updatedUser.id,
        name: updatedUser.name,
        email: updatedUser.email,
        phone: updatedUser.phone,
      },
    });
  } catch (e) {
    console.error("Error in edit-user endpoint:", e);
    res.status(500).json({ error: e.message });
  }
});

//add-to-cart api
userRouter.post("/api/add-to-cart", auth, async (req, res) => {
  try {
    const { id } = req.body;
    const product = await Product.findById(id);
    let user = await User.findById(req.user);

    if (user.cart.length == 0) {
      user.cart.push({ product, quantity: 1 });
    } else {
      let isProductFound = false;
      for (let i = 0; i < user.cart.length; i++) {
        if (user.cart[i].product._id.equals(product._id)) {
          isProductFound = true;
        }
      }

      if (isProductFound) {
        let producttt = user.cart.find((productt) =>
          productt.product._id.equals(product._id)
        );
        producttt.quantity += 1;
      } else {
        user.cart.push({ product, quantity: 1 });
      }
    }
    user = await user.save();
    res.json(user);
  } catch (e) {
    res.status(500).json({ error: e.message });
  }
});

//delete route
userRouter.delete("/api/remove-from-cart/:id", auth, async (req, res) => {
  try {
    const { id } = req.params;
    const product = await Product.findById(id);
    let user = await User.findById(req.user);

    for (let i = 0; i < user.cart.length; i++) {
      if (user.cart[i].product._id.equals(product._id)) {
        if (user.cart[i].quantity == 1) {
          user.cart.splice(i, 1);
        } else {
          user.cart[i].quantity -= 1;
        }
      }
    }
    user = await user.save();
    res.json(user);
  } catch (e) {}
});

//save user address
userRouter.post("/api/save-user-address", auth, async (req, res) => {
  try {
    const { address } = req.body;
    let user = await User.findById(req.user);
    user.address = address;
    user = await user.save();
    res.json(user);
  } catch (e) {
    res.status(500).json({ error: e.message });
  }
});

//ordering product
userRouter.post("/api/order", auth, async (req, res) => {
  try {
    const { cart, totalPrice, address } = req.body;
    let products = [];

    for (let i = 0; i < cart.length; i++) {
      let product = await Product.findById(cart[i].product._id);
      if (product.quantity >= cart[i].quantity) {
        product.quantity -= cart[i].quantity;
        products.push({ product, quantity: cart[i].quantity });
        await product.save();
      } else {
        return res.status(400).json({ msg: `${product.name} is out of stock` });
      }
    }
    let user = await User.findById(req.user);
    user.cart = [];
    user = await user.save();

    let order = new Order({
      products,
      totalPrice,
      address,
      userId: req.user,
      orderedAt: new Date().getTime(),
    });
    order = await order.save();
    res.json(order);
  } catch (e) {
    res.status(500).json({ error: e.message });
  }
});

userRouter.get("/api/orders/me", auth, async (req, res) => {
  try {
    const orders = await Order.find({ userId: req.user });
    res.json(orders);
  } catch (e) {
    res.status(500).json({ error: e.message });
  }
});

module.exports = userRouter;
