import 'package:amazon_clone/common/widgets/customTextfield.dart';
import 'package:amazon_clone/constants/globalVariables.dart';
import 'package:amazon_clone/constants/utils.dart';
import 'package:amazon_clone/features/address/services/address_services.dart';
import 'package:amazon_clone/providers/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pay/pay.dart';
import 'package:provider/provider.dart';

class AddressScreen extends StatefulWidget {
  static const String routeName = '/address';
  final String totalAmount;
  const AddressScreen({super.key, required this.totalAmount});

  @override
  State<AddressScreen> createState() => _AddressScreenState();
}

class _AddressScreenState extends State<AddressScreen> {
  PaymentConfiguration? _applePaymentConfiguration;
  PaymentConfiguration? _googlePaymentConfiguration;
  @override
  void initState() {
    super.initState();
    paymentItems.add(PaymentItem(
        amount: widget.totalAmount,
        label: "Total amount",
        status: PaymentItemStatus.final_price));
    _loadApplePaymentConfiguration();
    _loadGooglePaymentConfiguration();
  }

  final TextEditingController flatBuildingController = TextEditingController();
  final TextEditingController areaController = TextEditingController();
  final TextEditingController postalCodeController = TextEditingController();
  final TextEditingController cityController = TextEditingController();
  final addressFormKey = GlobalKey<FormState>();
  List<PaymentItem> paymentItems = [];
  String addressToBeUsed = '';
  final AddressServices addressServices = AddressServices();

  @override
  void dispose() {
    super.dispose();
    flatBuildingController.dispose();
    areaController.dispose();
    postalCodeController.dispose();
    cityController.dispose();
  }

  Future<void> _loadApplePaymentConfiguration() async {
    try {
      String configString = await rootBundle.loadString('assets/applepay.json');
      setState(() {
        _applePaymentConfiguration =
            PaymentConfiguration.fromJsonString(configString);
      });
    } catch (e) {
      print('Error loading payment configuration: $e');
    }
  }

  Future<void> _loadGooglePaymentConfiguration() async {
    try {
      String configString = await rootBundle.loadString('assets/gpay.json');
      setState(() {
        _googlePaymentConfiguration =
            PaymentConfiguration.fromJsonString(configString);
      });
    } catch (e) {
      print('Error loading payment configuration: $e');
    }
  }

  void onApplePayResult(res) {
    if (Provider.of<UserProvider>(context, listen: false)
        .user
        .address
        .isEmpty) {
      addressServices.saveUserAddress(
          context: context, address: addressToBeUsed);
    }
    addressServices.placeOrder(
        context: context,
        address: addressToBeUsed,
        totalSum: double.parse(widget.totalAmount));
    Navigator.pop(context);
  }

  void onGooglePayResult(res) {
    if (Provider.of<UserProvider>(context, listen: false)
        .user
        .address
        .isEmpty) {
      addressServices.saveUserAddress(
          context: context, address: addressToBeUsed);
    }
    addressServices.placeOrder(
        context: context,
        address: addressToBeUsed,
        totalSum: double.parse(widget.totalAmount));
  }

  void payPressed(String addressFormProvider) {
    addressToBeUsed = '';
    bool isForm = flatBuildingController.text.isNotEmpty ||
        areaController.text.isNotEmpty ||
        postalCodeController.text.isNotEmpty ||
        cityController.text.isNotEmpty;

    if (isForm) {
      if (addressFormKey.currentState!.validate()) {
        addressToBeUsed =
            '${flatBuildingController.text},${areaController.text},${cityController.text} - ${postalCodeController.text}';
      }
    } else if (addressFormProvider.isNotEmpty) {
      addressToBeUsed = addressFormProvider;
    } else {
      showSnackBar(context, "Please enter all the values");
    }
    // print(addressToBeUsed);
  }

  @override
  Widget build(BuildContext context) {
    final address = context.watch<UserProvider>().user.address;

    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(60),
        child: AppBar(
          flexibleSpace: Container(
            decoration: BoxDecoration(
              gradient: GlobalVariables.appBarGradient,
            ),
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            children: [
              if (address.isNotEmpty)
                Column(
                  children: [
                    Container(
                      width: double.infinity,
                      decoration: BoxDecoration(
                          border: Border.all(color: Colors.black12)),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          address,
                          style: TextStyle(fontSize: 18),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Text(
                      "OR",
                      style: TextStyle(fontSize: 18),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                  ],
                ),
              Form(
                key: addressFormKey,
                child: Column(
                  children: [
                    Customtextfield(
                        passwordtext: false,
                        textInputType: TextInputType.emailAddress,
                        hintText: "Flat house number",
                        controller: flatBuildingController),
                    SizedBox(
                      height: 12,
                    ),
                    Customtextfield(
                      passwordtext: false,
                      textInputType: TextInputType.text,
                      hintText: "Area Street",
                      controller: areaController,
                    ),
                    SizedBox(
                      height: 12,
                    ),
                    Customtextfield(
                      passwordtext: false,
                      textInputType: TextInputType.text,
                      hintText: "Postal Code",
                      controller: postalCodeController,
                    ),
                    SizedBox(
                      height: 12,
                    ),
                    Customtextfield(
                      passwordtext: false,
                      textInputType: TextInputType.text,
                      hintText: "Town, City",
                      controller: cityController,
                    ),
                    SizedBox(
                      height: 12,
                    ),
                  ],
                ),
              ),
              ApplePayButton(
                onPressed: () {
                  payPressed(address);
                },
                margin: EdgeInsets.only(top: 15),
                width: double.infinity,
                height: 50,
                type: ApplePayButtonType.buy,
                paymentConfiguration: _applePaymentConfiguration!,
                paymentItems: paymentItems,
                onPaymentResult: onApplePayResult,
                loadingIndicator: Center(
                  child: CircularProgressIndicator(),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              GooglePayButton(
                onPressed: () => payPressed(address),
                width: double.infinity,
                height: 50,
                margin: EdgeInsets.only(top: 15),
                theme: GooglePayButtonTheme.light,
                type: GooglePayButtonType.buy,
                paymentConfiguration: _googlePaymentConfiguration!,
                paymentItems: paymentItems,
                onPaymentResult: onGooglePayResult,
                loadingIndicator: Center(
                  child: CircularProgressIndicator(),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
