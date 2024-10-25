import 'package:amazon_clone/features/account/widgets/single_product.dart';
import 'package:amazon_clone/features/home/services/home_services.dart';
import 'package:amazon_clone/features/product_details/screens/product_details_screen.dart';
import 'package:amazon_clone/models/product.dart';
import 'package:flutter/material.dart';

class ProductView extends StatefulWidget {
  const ProductView({super.key});

  @override
  State<ProductView> createState() => _ProductViewState();
}

class _ProductViewState extends State<ProductView> {
  final HomeServices homeServices = HomeServices();
  List<Product>? products;
  @override
  void initState() {
    super.initState();
    fetchAllProducts();
  }

  void fetchAllProducts() async {
    products = await homeServices.fetchAllProducts(context: context);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
        itemCount: products!.length,
        gridDelegate:
            SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
        itemBuilder: (context, index) {
          final productData = products![index];
          return InkWell(
            onTap: () {
              Navigator.pushNamed(context, ProductDetailsScreen.routeName,
                  arguments: productData);
            },
            child: Column(
              // crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                SizedBox(
                  height: 140,
                  child: SingleProduct(
                    image: productData.images[0],
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Expanded(
                        child: Column(
                      children: [
                        Text(
                          productData.name,
                          overflow: TextOverflow.ellipsis,
                        ),
                        Text('\$${productData.price.toString()}'),
                      ],
                    )),
                  ],
                )
              ],
            ),
          );
        });
  }
}
