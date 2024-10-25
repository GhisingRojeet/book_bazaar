import 'dart:convert';
import 'dart:io';

import 'package:amazon_clone/constants/error_handling%20.dart';
import 'package:amazon_clone/constants/globalVariables.dart';
import 'package:amazon_clone/constants/utils.dart';
import 'package:amazon_clone/features/admin/models/sales.dart';
import 'package:amazon_clone/features/auth/screens/logIn_screen.dart';
import 'package:amazon_clone/models/order.dart';
import 'package:amazon_clone/models/product.dart';
import 'package:amazon_clone/models/user.dart';
import 'package:amazon_clone/providers/user_provider.dart';
import 'package:cloudinary_public/cloudinary_public.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AdminServices {
  void sellProduct({
    required BuildContext context,
    required String name,
    required String description,
    required double price,
    required double quantity,
    required String category,
    required List<File> images,
  }) async {
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    try {
      final cloudinary = CloudinaryPublic('duhnso480', 'v6gixnu8');
      List<String> imageUrls = [];
      for (int i = 0; i < images.length; i++) {
        CloudinaryResponse res = await cloudinary.uploadFile(
          CloudinaryFile.fromFile(images[i].path, folder: name),
        );
        imageUrls.add(res.secureUrl);
      }
      Product product = Product(
        name: name,
        description: description,
        quantity: quantity,
        images: imageUrls,
        category: category,
        price: price,
      );

      http.Response res = await http.post(
        Uri.parse('$uri/admin/add-products'),
        headers: {
          "Content-Type": "application/json; charset=UTF-8",
          'x-auth-token': userProvider.user.token
        },
        body: product.toJson(),
      );

      httpErrorHandler(
          context: context,
          response: res,
          onSuccess: () {
            showSnackBar(context, 'Product added successfully');
            Navigator.pop(context);
            // onSuccess();
          });
    } catch (e) {
      showSnackBar(context, e.toString());
    }
  }

  //edit product
  void editProduct({
    required BuildContext context,
    required String name,
    required String description,
    required double price,
    required double quantity,
    required String category,
    required List<File> newImages,
  }) async {
    final userProvider = Provider.of<UserProvider>(context, listen: false);

    try {
      final cloudinary = CloudinaryPublic('duhnso480', 'v6gixnu8');
      List<String> imageUrls = [];

      // Upload new images
      for (int i = 0; i < newImages.length; i++) {
        CloudinaryResponse res = await cloudinary.uploadFile(
          CloudinaryFile.fromFile(newImages[i].path, folder: name),
        );
        imageUrls.add(res.secureUrl);
      }

      Product updatedProduct = Product(
        name: name,
        description: description,
        quantity: quantity,
        images: imageUrls,
        category: category,
        price: price,
      );

      http.Response res = await http.put(
        Uri.parse('$uri/admin/edit-product'),
        headers: {
          "Content-Type": "application/json; charset=UTF-8",
          'x-auth-token': userProvider.user.token
        },
        body: updatedProduct.toJson(),
      );

      httpErrorHandler(
        context: context,
        response: res,
        onSuccess: () {
          showSnackBar(context, 'Product updated successfully');
          Navigator.pop(context);
        },
      );
    } catch (e) {
      showSnackBar(context, e.toString());
    }
  }

//fetchAllUsers
  Future<List<User>> fetchAllUsers(BuildContext context) async {
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    List<User> userList = [];

    try {
      http.Response res =
          await http.get(Uri.parse('$uri/admin/get-users'), headers: {
        "Content-Type": "application/json; charset=UTF-8",
        'x-auth-token': userProvider.user.token,
      });
      httpErrorHandler(
        response: res,
        context: context,
        onSuccess: () {
          for (int i = 0; i < jsonDecode(res.body).length; i++) {
            userList.add(
              User.fromJson(
                jsonEncode(
                  jsonDecode(res.body)[i],
                ),
              ),
            );
          }
        },
      );
    } catch (e) {
      showSnackBar(context, e.toString());
    }
    return userList;
  }

  //deleteUser
  void deleteProduct({
    required BuildContext context,
    required Product product,
    required VoidCallback onSuccess,
  }) async {
    final userProvider = Provider.of<UserProvider>(context, listen: false);

    try {
      http.Response res = await http.post(
        Uri.parse('$uri/admin/delete_products'),
        headers: {
          "Content-Type": "application/json; charset=UTF-8",
          'x-auth-token': userProvider.user.token
        },
        body: jsonEncode({"id": product.id}),
      );

      httpErrorHandler(
          context: context,
          response: res,
          onSuccess: () {
            onSuccess();
          });
    } catch (e) {
      showSnackBar(context, e.toString());
    }
  }

  //fetch all products
  Future<List<Product>> fetchAllProducts(BuildContext context) async {
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    List<Product> productList = [];

    try {
      http.Response res =
          await http.get(Uri.parse('$uri/admin/get_products'), headers: {
        "Content-Type": "application/json; charset=UTF-8",
        'x-auth-token': userProvider.user.token,
      });
      httpErrorHandler(
        response: res,
        context: context,
        onSuccess: () {
          for (int i = 0; i < jsonDecode(res.body).length; i++) {
            productList.add(
              Product.fromJson(
                jsonEncode(
                  jsonDecode(res.body)[i],
                ),
              ),
            );
          }
        },
      );
    } catch (e) {
      showSnackBar(context, e.toString());
    }
    return productList;
  }

  //delete product

  void deleteUser({
    required BuildContext context,
    required User user,
    required VoidCallback onSuccess,
  }) async {
    final userProvider = Provider.of<UserProvider>(context, listen: false);

    try {
      http.Response res = await http.post(
        Uri.parse('$uri/admin/delete-user'),
        headers: {
          "Content-Type": "application/json; charset=UTF-8",
          'x-auth-token': userProvider.user.token
        },
        body: jsonEncode({"id": user.id}),
      );

      httpErrorHandler(
          context: context,
          response: res,
          onSuccess: () {
            onSuccess();
          });
    } catch (e) {
      showSnackBar(context, e.toString());
    }
  }

  //fetchOrder
  Future<List<Order>> fetchAllOrders(BuildContext context) async {
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    List<Order> orderList = [];

    try {
      http.Response res =
          await http.get(Uri.parse('$uri/admin/get-orders'), headers: {
        "Content-Type": "application/json; charset=UTF-8",
        'x-auth-token': userProvider.user.token,
      });
      httpErrorHandler(
        response: res,
        context: context,
        onSuccess: () {
          for (int i = 0; i < jsonDecode(res.body).length; i++) {
            orderList.add(
              Order.fromJson(
                jsonEncode(
                  jsonDecode(res.body)[i],
                ),
              ),
            );
          }
        },
      );
    } catch (e) {
      showSnackBar(context, e.toString());
    }
    return orderList;
  }

  //change orderStatus
  void changeOrderStatus({
    required BuildContext context,
    required int status,
    required Order order,
    required VoidCallback onSuccess,
  }) async {
    final userProvider = Provider.of<UserProvider>(context, listen: false);

    try {
      http.Response res = await http.post(
        Uri.parse('$uri/admin/change-order-status'),
        headers: {
          "Content-Type": "application/json; charset=UTF-8",
          'x-auth-token': userProvider.user.token
        },
        body: jsonEncode({"id": order.id, "status": status}),
      );

      httpErrorHandler(
        context: context,
        response: res,
        onSuccess: onSuccess,
      );
    } catch (e) {
      showSnackBar(context, e.toString());
    }
  }

  //analytics earnings graph api
  Future<Map<String, dynamic>> getEarnings(BuildContext context) async {
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    List<Sales> sales = [];
    int totalEarning = 0;

    try {
      http.Response res =
          await http.get(Uri.parse('$uri/admin/analytics'), headers: {
        "Content-Type": "application/json; charset=UTF-8",
        'x-auth-token': userProvider.user.token,
      });
      httpErrorHandler(
          response: res,
          context: context,
          onSuccess: () {
            var response = jsonDecode(res.body);
            totalEarning = response['totalEarnings'];
            sales = [
              Sales('Literature', response['literatureEarnings']),
              Sales('Romance', response['romanceEarnings']),
              Sales('Science', response['scienceEarnings']),
              Sales('Horror', response['horrorEarnings']),
              Sales('History', response['historyEarnings']),
              Sales('Discipline', response['disciplineEarnings']),
              Sales('Biography', response['biographyEarnings']),
            ];
          });
    } catch (e) {
      showSnackBar(context, e.toString());
    }
    return {'sales': sales, 'totalEarnings': totalEarning};
  }

  //logout route
  void logOut(BuildContext context) async {
    try {
      SharedPreferences sharedPreferences =
          await SharedPreferences.getInstance();
      await sharedPreferences.setString('x-auth-token', "");
      Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (context) => LogInScreen()),
          (route) => false);
    } catch (e) {
      showSnackBar(context, e.toString());
    }
  }
}
