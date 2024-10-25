import 'package:amazon_clone/common/widgets/customButton.dart';
import 'package:amazon_clone/constants/globalVariables.dart';
import 'package:amazon_clone/features/admin/services/admin_services.dart';
import 'package:amazon_clone/features/search/screens/search_screen.dart';
import 'package:amazon_clone/models/order.dart';
import 'package:amazon_clone/providers/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class OrderDetailsScreen extends StatefulWidget {
  static const String routeName = '/order-details';
  final Order order;
  const OrderDetailsScreen({super.key, required this.order});

  @override
  State<OrderDetailsScreen> createState() => _OrderDetailsScreenState();
}

class _OrderDetailsScreenState extends State<OrderDetailsScreen> {
  final AdminServices adminServices = AdminServices();
  int currentStep = 0;
  void navigateToSearchScreen(String query) {
    Navigator.pushNamed(context, SearchScreen.routeName, arguments: query);
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    currentStep = widget.order.status;
  }

  // @override
  // void initState() {
  //   super.initState();
  //   currentStep = widget.order.status;
  // }

  void changeOrderStatus(int status) {
    adminServices.changeOrderStatus(
        context: context,
        status: status + 1,
        order: widget.order,
        onSuccess: () {
          setState(() {
            currentStep += 1;
          });
        });
  }

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserProvider>(context).user;
    bool isAdmin = user.type == 'admin';
    return Scaffold(
      appBar: isAdmin
          ? AppBar()
          : PreferredSize(
              preferredSize: Size.fromHeight(60),
              child: AppBar(
                flexibleSpace: Container(
                  decoration: BoxDecoration(
                    gradient: GlobalVariables.appBarGradient,
                  ),
                ),
                title: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Container(
                        height: 42,
                        margin: EdgeInsets.only(left: 15),
                        child: Material(
                          borderRadius: BorderRadius.circular(7),
                          elevation: 1,
                          child: TextFormField(
                            onFieldSubmitted: navigateToSearchScreen,
                            decoration: InputDecoration(
                              prefixIcon: InkWell(
                                onTap: () {},
                                child: Padding(
                                  padding: EdgeInsets.only(left: 6),
                                  child: Icon(
                                    Icons.search,
                                    // color: Colors.black,
                                    size: 23,
                                  ),
                                ),
                              ),
                              filled: true,
                              fillColor: Colors.white,
                              contentPadding: EdgeInsets.only(top: 10),
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(7),
                                  ),
                                  borderSide: BorderSide.none),
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.all(
                                  Radius.circular(7),
                                ),
                                borderSide:
                                    BorderSide(color: Colors.black38, width: 1),
                              ),
                              hintText: "Search Amazon.in",
                              hintStyle: TextStyle(
                                  fontSize: 17, fontWeight: FontWeight.w500),
                            ),
                          ),
                        ),
                      ),
                    ),
                    Container(
                      color: Colors.transparent,
                      height: 42,
                      margin: EdgeInsets.symmetric(horizontal: 10),
                      child: Icon(
                        Icons.mic,
                        color: Colors.black,
                        size: 25,
                      ),
                    )
                  ],
                ),
              ),
            ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "View Order Details",
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
              ),
              Container(
                width: double.infinity,
                padding: EdgeInsets.all(10),
                decoration:
                    BoxDecoration(border: Border.all(color: Colors.black12)),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                        'Order Date:           ${DateFormat().format(DateTime.fromMillisecondsSinceEpoch(
                      widget.order.orderedAt,
                    ))}'),
                    Text('Order Id:               ${widget.order.id}'),
                    Text('Order Total:          \$${widget.order.totalPrice}'),
                  ],
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                "Purchased Details",
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
              ),
              Container(
                decoration:
                    BoxDecoration(border: Border.all(color: Colors.black12)),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    for (int i = 0; i < widget.order.products.length; i++)
                      Row(
                        children: [
                          Image.network(
                            widget.order.products[i].images[0],
                            height: 120,
                            width: 120,
                          ),
                          SizedBox(
                            width: 5,
                          ),
                          Expanded(
                              child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Text(
                                widget.order.products[i].name,
                                style: TextStyle(
                                    fontSize: 17, fontWeight: FontWeight.bold),
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                              ),
                              Text(
                                'Quantity ordered: ${widget.order.quantity[i]}',
                                style: TextStyle(
                                    fontSize: 14, fontWeight: FontWeight.w600),
                              )
                            ],
                          ))
                        ],
                      ),
                  ],
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                "Purchased Details",
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
              ),
              Container(
                  decoration:
                      BoxDecoration(border: Border.all(color: Colors.black12)),
                  child: Stepper(
                      currentStep: currentStep,
                      controlsBuilder: (context, details) {
                        if (user.type == 'admin') {
                          if (currentStep <= 2) {
                            return CustomButton(
                              color: Colors.purple[400],
                              text: 'Done',
                              onTap: () {
                                changeOrderStatus(details.currentStep);
                              },
                            );
                          }
                        }
                        return const SizedBox();
                      },
                      steps: [
                        Step(
                            state: currentStep > 0
                                ? StepState.complete
                                : StepState.indexed,
                            isActive: currentStep > 0,
                            title: Text("Pending"),
                            content: Text("Your order is yet to be delivered")),
                        Step(
                            state: currentStep > 1
                                ? StepState.complete
                                : StepState.indexed,
                            isActive: currentStep > 1,
                            title: Text("Completed"),
                            content: Text("Your order has been placed")),
                        Step(
                            state: currentStep > 2
                                ? StepState.complete
                                : StepState.indexed,
                            isActive: currentStep > 2,
                            title: Text("Received"),
                            content: Text(
                                "Your order has been reached out logistics")),
                        Step(
                            state: currentStep == 3
                                ? StepState.complete
                                : StepState.indexed,
                            isActive: currentStep == 3,
                            title: Text("Delivered"),
                            content: Text("Order delivered")),
                      ])),
            ],
          ),
        ),
      ),
    );
  }
}
