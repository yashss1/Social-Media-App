import 'package:flutter/material.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import '../constants.dart';
import '../textfield.dart';
import 'add_product2.dart';

class AddProduct extends StatefulWidget {
  const AddProduct({Key? key}) : super(key: key);

  @override
  _AddProductState createState() => _AddProductState();
}

class _AddProductState extends State<AddProduct> {
  TextEditingController brand = TextEditingController();
  TextEditingController item = TextEditingController();
  TextEditingController details = TextEditingController();
  TextEditingController price = TextEditingController();

  // TextEditingController location = TextEditingController();
  // TextEditingController email = TextEditingController();
  bool showSpinner = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        body: ModalProgressHUD(
          inAsyncCall: showSpinner,
          child: Container(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            // decoration: BoxDecoration(
            //   gradient: LinearGradient(
            //     begin: Alignment.topCenter,
            //     end: Alignment.bottomCenter,
            //     colors: [
            //       Color(0xff1F00FC),
            //       Colors.black,
            //       Colors.black,
            //     ],
            //   ),
            // ),
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                children: [
                  SizedBox(height: 70),
                  Stack(
                    children: [
                      InkWell(
                        onTap: () {
                          Navigator.pop(context);
                        },
                        child: Align(
                          alignment: Alignment.topLeft,
                          child: Icon(Icons.arrow_back, size: 30, color: pink),
                        ),
                      ),
                      Center(
                          child: Text(
                        'Add Product',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            color: pink,
                            fontFamily: 'Syne',
                            fontSize: 25,
                            letterSpacing:
                                0 /*percentages not used in flutter. defaulting to zero*/,
                            fontWeight: FontWeight.bold,
                            height: 1),
                      )),
                    ],
                  ),
                  Flexible(
                    child: SingleChildScrollView(
                      physics: BouncingScrollPhysics(),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(height: 40),
                          Container(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text("Brand Name",
                                    style: myStyle(17, "Syne",
                                        fw: FontWeight.normal,
                                        color: Colors.black)),
                                SizedBox(
                                  height: 5,
                                ),
                                textfieldSmall(
                                    hint_text: 'Brand Name', controller: brand),
                                SizedBox(
                                  height: 10,
                                ),
                                Text("Item Name",
                                    style: myStyle(17, "Syne",
                                        fw: FontWeight.normal,
                                        color: Colors.black)),
                                SizedBox(
                                  height: 5,
                                ),
                                textfieldSmall(
                                    hint_text: 'Item Name', controller: item),
                                SizedBox(
                                  height: 10,
                                ),
                                Text("Price (USD)",
                                    style: myStyle(17, "Syne",
                                        fw: FontWeight.normal,
                                        color: Colors.black)),
                                SizedBox(
                                  height: 5,
                                ),
                                textfieldNumber2(
                                    hint_text: '\$0.00', controller: price),
                                SizedBox(
                                  height: 10,
                                ),
                                Text("Short Description",
                                    style: myStyle(17, "Syne",
                                        fw: FontWeight.normal,
                                        color: Colors.black)),
                                SizedBox(
                                  height: 5,
                                ),
                                Container(
                                  width: double.infinity,
                                  height: 150,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.only(
                                      topLeft: Radius.circular(10),
                                      topRight: Radius.circular(10),
                                      bottomLeft: Radius.circular(10),
                                      bottomRight: Radius.circular(10),
                                    ),
                                    color: Colors.grey.shade100,
                                  ),
                                  child: textfieldLarge(
                                      hint_text:
                                          'Include Details (Size, Condition, Year, etc.)',
                                      controller: details),
                                ),
                                SizedBox(height: 10),
                                // Text("Email for Buyers to Contact",
                                //     style: myStyle(17, "Syne",
                                //         fw: FontWeight.normal,
                                //         color: Colors.black)),
                                // SizedBox(
                                //   height: 5,
                                // ),
                                // textfieldSmall(
                                //     hint_text: 'Email', controller: email),
                                // SizedBox(height: 10),
                                // Text("Location",
                                //     style: myStyle(17, "Syne",
                                //         fw: FontWeight.normal,
                                //         color: Colors.white)),
                                // SizedBox(
                                //   height: 5,
                                // ),
                                // textfieldSmall(
                                //     hint_text: 'Location',
                                //     controller: location),
                                SizedBox(height: 50),
                                Container(
                                  alignment: Alignment.center,
                                  child: button(
                                    onPressed: () async {
                                      if (brand.text == null ||
                                          brand.text.length == 0) {
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(
                                          SnackBar(
                                            content: Text(
                                              "Please Enter the Brand Name",
                                              style: TextStyle(fontSize: 16),
                                            ),
                                          ),
                                        );
                                      } else if (item.text == null ||
                                          item.text.length == 0) {
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(
                                          SnackBar(
                                            content: Text(
                                              "Please Enter the Item Name",
                                              style: TextStyle(fontSize: 16),
                                            ),
                                          ),
                                        );
                                      } else if (price.text == null ||
                                          price.text.length == 0) {
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(
                                          SnackBar(
                                            content: Text(
                                              "Please Enter Desired Asking Price",
                                              style: TextStyle(fontSize: 16),
                                            ),
                                          ),
                                        );
                                      } else if (details.text == null ||
                                          details.text.length == 0) {
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(
                                          SnackBar(
                                            content: Text(
                                              "Please write some Description about the Product",
                                              style: TextStyle(fontSize: 16),
                                            ),
                                          ),
                                        );
                                      } else {
                                        Navigator.pushReplacement(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    AddProduct2(
                                                      brand: brand.text,
                                                      item: item.text,
                                                      detail: details.text,
                                                      price: price.text,
                                                    )));
                                      }
                                    },
                                    child: Text("Next"),

                                    // ignore: prefer_const_constructors
                                  ),
                                ),
                                SizedBox(
                                  height: 20,
                                ),
                                SizedBox(
                                  height: 30,
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ));
  }
}
