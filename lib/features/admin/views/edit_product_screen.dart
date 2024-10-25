import 'dart:io';

import 'package:amazon_clone/common/widgets/customButton.dart';
import 'package:amazon_clone/common/widgets/customTextfield.dart';
import 'package:amazon_clone/constants/globalVariables.dart';
import 'package:amazon_clone/constants/utils.dart';
import 'package:amazon_clone/features/admin/services/admin_services.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';

class EditProductScreen extends StatefulWidget {
  static const String routeName = '/edit-product';
  const EditProductScreen({super.key});

  @override
  State<EditProductScreen> createState() => _EditProductScreenState();
}

class _EditProductScreenState extends State<EditProductScreen> {
  final TextEditingController productNameController = TextEditingController();
  final TextEditingController productDescriptionController =
      TextEditingController();
  final TextEditingController productPriceController = TextEditingController();
  final TextEditingController productQuantityController =
      TextEditingController();
  final AdminServices adminServices = AdminServices();

  String category = 'Literature';
  List<File> images = [];
  final _addProductFormKey = GlobalKey<FormState>();
  @override
  void dispose() {
    productNameController.dispose();
    productDescriptionController.dispose();
    productPriceController.dispose();
    productQuantityController.dispose();
    super.dispose();
  }

  List<String> productCategories = [
    "Literature",
    "Romance",
    "Science",
    "Horror",
    "History",
    "Discipline",
    "Biography"
  ];

  void updateProduct() {
    if (_addProductFormKey.currentState!.validate() && images.isNotEmpty) {
      adminServices.editProduct(
        context: context,
        name: productNameController.text,
        description: productDescriptionController.text,
        price: double.parse(productPriceController.text),
        quantity: double.parse(productQuantityController.text),
        category: category,
        newImages: images,
      );
    }
  }

  void selectImages() async {
    var res = await pickImages();
    setState(() {
      images = res;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
          preferredSize: Size.fromHeight(50),
          child: AppBar(
              flexibleSpace: Container(
                decoration: BoxDecoration(
                  gradient: GlobalVariables.appBarGradient,
                ),
              ),
              title: Text(
                "Edit Product",
                style: TextStyle(),
              ))),
      body: SingleChildScrollView(
        child: Form(
            key: _addProductFormKey,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10.0),
              child: Column(
                children: [
                  SizedBox(
                    height: 20,
                  ),
                  images.isNotEmpty
                      ? CarouselSlider(
                          items: images.map(
                            (i) {
                              return Builder(
                                builder: (BuildContext context) => Image.file(
                                  i,
                                  fit: BoxFit.cover,
                                  height: 200,
                                ),
                              );
                            },
                          ).toList(),
                          options:
                              CarouselOptions(viewportFraction: 1, height: 200),
                        )
                      : GestureDetector(
                          onTap: selectImages,
                          child: DottedBorder(
                            borderType: BorderType.RRect,
                            radius: Radius.circular(10),
                            dashPattern: [10, 4],
                            strokeCap: StrokeCap.round,
                            child: Container(
                              width: double.infinity,
                              height: 150,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(
                                    Icons.folder_open,
                                    size: 40,
                                  ),
                                  SizedBox(
                                    height: 15,
                                  ),
                                  Text(
                                    "Select Product Images",
                                    style: TextStyle(
                                        fontSize: 15,
                                        color: Colors.grey.shade400),
                                  )
                                ],
                              ),
                            ),
                          ),
                        ),
                  SizedBox(
                    height: 30,
                  ),
                  //product name TextFormField
                  Customtextfield(
                    passwordtext: false,
                    textInputType: TextInputType.text,
                    controller: productNameController,
                    hintText: "New Name",
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  //Description TextFormField
                  Customtextfield(
                    passwordtext: false,
                    textInputType: TextInputType.text,
                    controller: productDescriptionController,
                    hintText: "Description",
                    maxLines: 7,
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  //product Price TextFormField
                  Customtextfield(
                    passwordtext: false,
                    textInputType: TextInputType.number,
                    controller: productPriceController,
                    hintText: "Price",
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  //product Quantity TextFormField
                  Customtextfield(
                    passwordtext: false,
                    textInputType: TextInputType.number,
                    controller: productQuantityController,
                    hintText: "Quantity",
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  SizedBox(
                    width: double.infinity,
                    child: DropdownButton(
                        value: category,
                        icon: Icon(Icons.keyboard_arrow_down),
                        items: productCategories.map((String item) {
                          return DropdownMenuItem(
                            value: item,
                            child: Text(item),
                          );
                        }).toList(),
                        onChanged: (String? newVal) {
                          setState(() {
                            category = newVal!;
                          });
                        }),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  CustomButton(
                      color: Colors.deepPurpleAccent,
                      text: "Update",
                      onTap: updateProduct),
                ],
              ),
            )),
      ),
    );
  }
}
