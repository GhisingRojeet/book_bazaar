import 'package:amazon_clone/constants/error_handling%20.dart';
import 'package:amazon_clone/constants/globalVariables.dart';
import 'package:amazon_clone/constants/utils.dart';
import 'package:amazon_clone/providers/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:provider/provider.dart'; // For encoding JSON

class UserServices {
  Future<void> editUser({
    required BuildContext context,
    required String id,
    required String name,
    required String email,
    required String phone,
    required String password,
  }) async {
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    try {
      Map<String, String> userDetails = {
        'name': name,
        'email': email,
        'phone': phone,
        'password': password,
      };

      // Send a PUT request to the Node.js API
      http.Response res = await http.put(
        Uri.parse('$uri/api/edit-user/$id'), // Replace with your server URL
        body: jsonEncode(userDetails),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'x-auth-token': userProvider.user.token,
        },
      );

      // Handle the response
      httpErrorHandler(
        context: context,
        response: res,
        onSuccess: () {
          showSnackBar(context, 'User details updated successfully');
          Navigator.pop(context);
        },
      );
    } catch (e) {
      // Handle any error during the request
      showSnackBar(context, 'Error updating user: ${e.toString()}');
    }
  }
}
