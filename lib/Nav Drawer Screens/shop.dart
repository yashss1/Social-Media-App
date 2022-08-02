import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:social_media/constants.dart';
import 'package:social_media/model/shop_category_model.dart';
import 'package:social_media/model/shop_picked_model.dart';

import '../OtherScreens/add_product.dart';

class Shop extends StatefulWidget {
  const Shop({Key? key}) : super(key: key);

  @override
  _ShopState createState() => _ShopState();
}

class _ShopState extends State<Shop> {
  TextEditingController search = TextEditingController();
  String searchField = "";

  Future<List> getData() async {
    List l1 = [], l2 = [];
    final QuerySnapshot result =
        await FirebaseFirestore.instance.collection('Shop').get();
    final List<DocumentSnapshot> documents = result.docs;

    // Iterate through all the Documents
    documents.forEach((data) {
      bool docStatus = data.exists;
      if (docStatus == true) {
        l2 = data['Items'];
        if (l1 == null) {
          l1 = l2;
        } else {
          l1 += l2;
        }
      }

      if (l1 != null) {
        //Sorting
        l1.sort(
          (a, b) {
            return b['createdAt'].toString().toLowerCase().compareTo(
                  a['createdAt'].toString().toLowerCase(),
                );
          },
        );
        print(l1);
      }
    });
    return l1;
  }

  bool resultData(List arr, int index, String _key) {
    String brand = arr[index]['BrandName'];
    String name = arr[index]['ItemName'];
    brand = brand.toLowerCase();
    name = name.toLowerCase();
    _key = _key.toLowerCase();
    // print(
    // "Email -> ${email} : Name -> ${name} : Phone -> ${phone} : Handle -> ${handle}");
    if (brand.contains(_key) || name.contains(_key)) return true;
    return false;
  }

  @override
  Widget build(BuildContext context) {
    final deviceWidth = MediaQuery.of(context).size.width;
    final deviceHeight = MediaQuery.of(context).size.height;
    return SafeArea(
      child: Scaffold(
        floatingActionButton: InkWell(
          onTap: () {
            Navigator.pushReplacement(
                context, MaterialPageRoute(builder: (context) => AddProduct()));
          },
          child: Container(
            height: 65,
            width: 65,
            decoration: BoxDecoration(shape: BoxShape.circle, color: pink),
            child: Icon(
              Icons.add,
              color: Colors.white,
              size: 30,
            ),
          ),
        ),
        body: Container(
          width: deviceWidth,
          height: deviceHeight,
          child: Column(
            children: [
              Container(
                padding: EdgeInsets.symmetric(horizontal: 16),
                width: deviceWidth,
                height: 70,
                color: Colors.white,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        InkWell(
                          splashColor: Colors.pink,
                          onTap: () {
                            Navigator.pop(context);
                          },
                          child: const Icon(
                            Icons.arrow_back,
                            size: 28,
                          ),
                        ),
                        SizedBox(width: 25),
                        const Text(
                          'Shop',
                          textAlign: TextAlign.left,
                          style: TextStyle(
                              color: Color.fromRGBO(255, 79, 90, 1),
                              fontFamily: 'Lato',
                              fontSize: 20,
                              letterSpacing:
                                  0 /*percentages not used in flutter. defaulting to zero*/,
                              fontWeight: FontWeight.normal,
                              height: 1),
                        ),
                      ],
                    ),
                    Row(
                      children: const [
                        Icon(
                          Icons.search,
                          size: 30,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 16),
                width: deviceWidth,
                child: SingleChildScrollView(
                  physics: BouncingScrollPhysics(),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 30),
                      const Text(
                        'Today Pick’s',
                        textAlign: TextAlign.left,
                        style: TextStyle(
                            color: Color.fromRGBO(0, 0, 0, 1),
                            fontFamily: 'Lato',
                            fontSize: 20,
                            letterSpacing:
                                0 /*percentages not used in flutter. defaulting to zero*/,
                            fontWeight: FontWeight.normal,
                            height: 1),
                      ),
                      SingleChildScrollView(
                        physics: BouncingScrollPhysics(),
                        scrollDirection: Axis.horizontal,
                        child: Row(
                          children: const [
                            ShopPicked(
                                img: 'assets/images/Rectangle89.png',
                                name: 'Watch',
                                price: '100'),
                            ShopPicked(
                                img: 'assets/images/Rectangle90.png',
                                name: 'Shirt',
                                price: '150'),
                            ShopPicked(
                                img: 'assets/images/Rectangle89.png',
                                name: 'Watch',
                                price: '100'),
                            ShopPicked(
                                img: 'assets/images/Rectangle90.png',
                                name: 'Shirt',
                                price: '150'),
                          ],
                        ),
                      ),
                      SizedBox(height: 45),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Watch',
                            textAlign: TextAlign.left,
                            style: TextStyle(
                                color: pink,
                                fontFamily: 'Lato',
                                fontSize: 20,
                                letterSpacing:
                                    0 /*percentages not used in flutter. defaulting to zero*/,
                                fontWeight: FontWeight.normal,
                                height: 1),
                          ),
                          Text(
                            'Shirt',
                            textAlign: TextAlign.left,
                            style: TextStyle(
                                color: black,
                                fontFamily: 'Lato',
                                fontSize: 20,
                                letterSpacing:
                                    0 /*percentages not used in flutter. defaulting to zero*/,
                                fontWeight: FontWeight.normal,
                                height: 1),
                          ),
                          Text(
                            'Jeans',
                            textAlign: TextAlign.left,
                            style: TextStyle(
                                color: black,
                                fontFamily: 'Lato',
                                fontSize: 20,
                                letterSpacing:
                                    0 /*percentages not used in flutter. defaulting to zero*/,
                                fontWeight: FontWeight.normal,
                                height: 1),
                          ),
                          Text(
                            'Earphones',
                            textAlign: TextAlign.left,
                            style: TextStyle(
                                color: black,
                                fontFamily: 'Lato',
                                fontSize: 20,
                                letterSpacing:
                                    0 /*percentages not used in flutter. defaulting to zero*/,
                                fontWeight: FontWeight.normal,
                                height: 1),
                          ),
                          Text(
                            'Mobiles',
                            textAlign: TextAlign.left,
                            style: TextStyle(
                                color: black,
                                fontFamily: 'Lato',
                                fontSize: 20,
                                letterSpacing:
                                    0 /*percentages not used in flutter. defaulting to zero*/,
                                fontWeight: FontWeight.normal,
                                height: 1),
                          ),
                        ],
                      ),
                      SizedBox(height: 25),
                      // Row(
                      //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      //   children: const [
                      //     ShopCategory(
                      //         img: 'assets/images/Rectangle91.png',
                      //         name: 'Dura Watch',
                      //         price: '24'),
                      //     ShopCategory(
                      //         img: 'assets/images/Rectangle92.png',
                      //         name: 'Rolex Watch',
                      //         price: '49'),
                      //     ShopCategory(
                      //         img: 'assets/images/Rectangle93.png',
                      //         name: 'Titan Watch',
                      //         price: '26'),
                      //   ],
                      // ),
                      // SizedBox(height: 15),
                      // Row(
                      //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      //   children: const [
                      //     ShopCategory(
                      //         img: 'assets/images/Rectangle94.png',
                      //         name: 'Dura Watch',
                      //         price: '24'),
                      //     ShopCategory(
                      //         img: 'assets/images/Rectangle95.png',
                      //         name: 'Rolex Watch',
                      //         price: '49'),
                      //     ShopCategory(
                      //         img: 'assets/images/Rectangle96.png',
                      //         name: 'Titan Watch',
                      //         price: '26'),
                      //   ],
                      // ),
                      // SizedBox(height: 15),
                      // Row(
                      //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      //   children: const [
                      //     ShopCategory(
                      //         img: 'assets/images/Rectangle91.png',
                      //         name: 'Dura Watch',
                      //         price: '24'),
                      //     ShopCategory(
                      //         img: 'assets/images/Rectangle92.png',
                      //         name: 'Rolex Watch',
                      //         price: '49'),
                      //     ShopCategory(
                      //         img: 'assets/images/Rectangle93.png',
                      //         name: 'Yash Watch',
                      //         price: '26'),
                      //   ],
                      // ),

                      Container(
                        height: 400,
                        child: FutureBuilder(
                            future: getData(),
                            builder: (ctx, AsyncSnapshot snaps) {
                              if (snaps.connectionState ==
                                  ConnectionState.waiting) {
                                return Center(
                                  child: CircularProgressIndicator(),
                                );
                              }
                              final _snap = snaps.data!;
                              print("Length : ${_snap.length}");
                              return _snap.length == 0
                                  ? Container(
                                      width: MediaQuery.of(context).size.width,
                                      padding: EdgeInsets.only(
                                        top:
                                            MediaQuery.of(context).size.height *
                                                .3,
                                      ),
                                      child: Column(
                                        children: [
                                          Text(
                                            "WE'RE SORRY",
                                          ),
                                          Center(
                                            child: Text(
                                              "There is Nothing here...",
                                              textAlign: TextAlign.center,
                                            ),
                                          ),
                                        ],
                                      ),
                                    )
                                  : GridView.builder(
                                      physics: BouncingScrollPhysics(),
                                      scrollDirection: Axis.vertical,
                                      gridDelegate:
                                          SliverGridDelegateWithFixedCrossAxisCount(
                                        childAspectRatio: 1 / 1.4,
                                        crossAxisCount: 3,
                                      ),
                                      itemCount: _snap.length,
                                      itemBuilder: (_, index) {
                                        return (resultData(_snap, index,
                                                    searchField)) ==
                                                false
                                            ? SizedBox(height: 0)
                                            : InkWell(
                                                onTap: () {
                                                  // Navigator.push(
                                                  //     context,
                                                  //     MaterialPageRoute(
                                                  //         builder: (context) =>
                                                  //             IndividualProduct(
                                                  //               array: _snap,
                                                  //               index: index,
                                                  //             )));
                                                },
                                                child: ShopCategory(
                                                    img: _snap[index]['Images']
                                                        [0],
                                                    name: _snap[index]
                                                        ['ItemName'],
                                                    price: _snap[index]
                                                        ['Price']),
                                              );
                                      },
                                    );
                            }),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
