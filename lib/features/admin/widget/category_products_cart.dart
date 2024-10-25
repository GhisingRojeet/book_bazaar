// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:flutter/material.dart';
import 'package:pie_chart/pie_chart.dart';

// ignore: must_be_immutable
class CategoryProductsCart extends StatelessWidget {
  Map<String, double> dataMap;

  CategoryProductsCart({
    Key? key,
    required this.dataMap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return PieChart(chartRadius: 900, dataMap: dataMap);
  }
}
