import 'package:amazon_clone/features/address/services/address_services.dart';
import 'package:amazon_clone/provider/user_provider.dart';
import 'package:amazon_clone/widgets/custom_textfield.dart';
import 'package:flutter/material.dart';
import 'package:pay/pay.dart';
import 'package:provider/provider.dart';
import '../../../payment_configurations.dart';
import '../../../constants/global_variables.dart';
import 'dart:io' show Platform;

import '../../../utils/utils.dart';

class AddressScreen extends StatefulWidget {
  static const String routeName = '/address_screen';
  final String totalAmount;
  const AddressScreen({Key? key, required this.totalAmount}) : super(key: key);

  @override
  State<AddressScreen> createState() => _AddressScreenState();
}

class _AddressScreenState extends State<AddressScreen> {
  TextEditingController flatBuildingController = TextEditingController();
  TextEditingController areaController = TextEditingController();
  TextEditingController pinCodeController = TextEditingController();
  TextEditingController cityController = TextEditingController();
  TextEditingController landMarkController = TextEditingController();
  final _addressFormKey = GlobalKey<FormState>();
  String addressToBeUsed = '';
  List<PaymentItem> paymentItem = [];

  AddressServices addressServices = AddressServices();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    paymentItem.add(PaymentItem(
      amount: widget.totalAmount,
      label: 'TotalAmount',
      status: PaymentItemStatus.final_price,
    ));
  }

  void payPressed(String addressFromProvider) {
    addressToBeUsed = '';
    String totalAddress =
        '${flatBuildingController.text} , ${areaController.text} , ${landMarkController.text} , ${cityController.text} - ${pinCodeController.text}';
    bool isForm = flatBuildingController.text.isNotEmpty ||
        areaController.text.isNotEmpty ||
        pinCodeController.text.isNotEmpty ||
        cityController.text.isNotEmpty ||
        landMarkController.text.isNotEmpty;

    if (isForm) {
      if (_addressFormKey.currentState!.validate()) {
        addressToBeUsed = totalAddress;
      } else {
        //showSnackPopup(context, 'Enter All The Input Values');
        throw Exception('Enter All The Input Values!');
      }
    } else if (addressFromProvider.isNotEmpty) {
      addressToBeUsed = addressFromProvider;
    } else {
      showSnackPopup(context, 'Something Went Wrong');
    }
    print('Actual Address To Be Used : $addressToBeUsed');
  }

  void onGooglePayResult(res) {
    if (Provider.of<UserProvider>(context).user.address.isEmpty) {
      addressServices.saveTheUserData(
        context: context,
        address: addressToBeUsed,
      );
    }
  }

  void onApplePayResult(res) {}

  @override
  Widget build(BuildContext context) {
    final address = Provider.of<UserProvider>(context).user.address;
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(60),
        child: AppBar(
          flexibleSpace: Container(
            decoration: const BoxDecoration(
              gradient: GlobalVariables.appBarGradient,
            ),
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              if (address.isNotEmpty)
                Column(
                  children: [
                    Container(
                      height: 40,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: GlobalVariables.blackColor,
                          width: 1,
                        ),
                        borderRadius: BorderRadius.circular(5),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          address,
                          textAlign: TextAlign.start,
                          style: const TextStyle(
                            fontSize: 18,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 15),
                    const Text(
                      'OR',
                      style: TextStyle(
                        fontSize: 18,
                      ),
                    ),
                    const SizedBox(height: 15),
                  ],
                ),
              Form(
                key: _addressFormKey,
                child: Column(
                  children: [
                    CustomTextField(
                      hintText: 'Flat, House, Building No',
                      prefixIcon: const Icon(
                        Icons.house,
                        color: Colors.black,
                      ),
                      controller: flatBuildingController,
                      secureText: false,
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    CustomTextField(
                      hintText: 'Area, Street',
                      prefixIcon: const Icon(
                        Icons.add_road,
                        color: Colors.black,
                      ),
                      controller: areaController,
                      secureText: false,
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    CustomTextField(
                      hintText: 'Landmark',
                      prefixIcon: const Icon(
                        Icons.label_important_outline_sharp,
                        color: Colors.black,
                      ),
                      controller: landMarkController,
                      secureText: false,
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    CustomTextField(
                      hintText: 'PinCode',
                      prefixIcon: const Icon(
                        Icons.pin,
                        color: Colors.black,
                      ),
                      controller: pinCodeController,
                      secureText: false,
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    CustomTextField(
                      hintText: 'Town/City',
                      prefixIcon: const Icon(
                        Icons.location_city,
                        color: Colors.black,
                      ),
                      controller: cityController,
                      secureText: false,
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                  ],
                ),
              ),
              Platform.isIOS
                  ? Container(
                      color: Colors.white54,
                      child: ApplePayButton(
                        onPressed: () => payPressed(address),
                        paymentConfiguration:
                            PaymentConfiguration.fromJsonString(
                          defaultApplePay,
                        ),
                        paymentItems: paymentItem,
                        type: ApplePayButtonType.buy,
                        width: double.infinity,
                        height: 55,
                        style: ApplePayButtonStyle.whiteOutline,
                        margin: const EdgeInsets.only(top: 15.0),
                        onPaymentResult: onApplePayResult,
                        loadingIndicator: const Center(
                          child: CircularProgressIndicator(),
                        ),
                      ),
                    )
                  : GooglePayButton(
                      onPressed: () => payPressed(address),
                      paymentConfiguration: PaymentConfiguration.fromJsonString(
                        defaultGooglePay,
                      ),
                      paymentItems: paymentItem,
                      type: GooglePayButtonType.buy,
                      width: double.infinity,
                      height: 55,
                      margin: const EdgeInsets.only(top: 15.0),
                      onPaymentResult: onGooglePayResult,
                      loadingIndicator: const Center(
                        child: CircularProgressIndicator(),
                      ),
                    ),
            ],
          ),
        ),
      ),
    );
  }
}
