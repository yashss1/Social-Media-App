import 'package:flutter/material.dart';
import 'package:social_media/model/blog_comment_model.dart';

class Blogs extends StatefulWidget {
  const Blogs({Key? key}) : super(key: key);

  @override
  _BlogsState createState() => _BlogsState();
}

class _BlogsState extends State<Blogs> {
  @override
  Widget build(BuildContext context) {
    final deviceWidth = MediaQuery.of(context).size.width;
    final deviceHeight = MediaQuery.of(context).size.height;
    return SafeArea(
      child: Scaffold(
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
                          'Blogs',
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
              Expanded(
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 16),
                  child: SingleChildScrollView(
                    physics: BouncingScrollPhysics(),
                    child: Column(
                      children: [
                        Container(
                          width: deviceWidth,
                          decoration: BoxDecoration(
                            borderRadius: const BorderRadius.only(
                              topLeft: Radius.circular(10),
                              topRight: Radius.circular(10),
                              bottomLeft: Radius.circular(10),
                              bottomRight: Radius.circular(10),
                            ),
                            border: Border.all(
                              color: const Color.fromRGBO(0, 0, 0, 1),
                              width: 1,
                            ),
                          ),
                          child: Column(
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Container(
                                      margin: const EdgeInsets.only(
                                          left: 20,
                                          right: 50,
                                          top: 15,
                                          bottom: 15),
                                      width: 52,
                                      height: 52,
                                      decoration: const BoxDecoration(
                                        color: Color.fromRGBO(100, 94, 94, 1),
                                        image: DecorationImage(
                                            image: AssetImage(
                                                'assets/images/Ellipse13.png'),
                                            fit: BoxFit.fitWidth),
                                        borderRadius: BorderRadius.all(
                                            Radius.elliptical(52, 52)),
                                      )),
                                  const Text(
                                    'Something new in your mind',
                                    textAlign: TextAlign.left,
                                    style: TextStyle(
                                        color: Color.fromRGBO(
                                            0, 0, 0, 0.4699999988079071),
                                        fontFamily: 'Lato',
                                        fontSize: 16,
                                        letterSpacing:
                                            0 /*percentages not used in flutter. defaulting to zero*/,
                                        fontWeight: FontWeight.normal,
                                        height: 1),
                                  )
                                ],
                              ),
                              SizedBox(height: 25),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: const [
                                  Text(
                                    '😃',
                                    style: TextStyle(fontSize: 25),
                                  ),
                                  SizedBox(width: 5),
                                  Text(
                                    '😍',
                                    style: TextStyle(fontSize: 25),
                                  ),
                                  SizedBox(width: 5),
                                  Text(
                                    '😡',
                                    style: TextStyle(fontSize: 25),
                                  ),
                                  SizedBox(width: 5),
                                  Text(
                                    '👍',
                                    style: TextStyle(fontSize: 25),
                                  ),
                                  SizedBox(width: 5),
                                  Text(
                                    '👎',
                                    style: TextStyle(fontSize: 25),
                                  ),
                                ],
                              ),
                              SizedBox(height: 20),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Container(
                                width: 107,
                                height: 40,
                                decoration: const BoxDecoration(
                                  borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(20),
                                    topRight: Radius.circular(20),
                                    bottomLeft: Radius.circular(20),
                                    bottomRight: Radius.circular(20),
                                  ),
                                  color: Color.fromRGBO(
                                      255, 79, 90, 0.800000011920929),
                                ),
                                child: const Align(
                                  alignment: Alignment.center,
                                  child: Text(
                                    'Publish',
                                    textAlign: TextAlign.left,
                                    style: TextStyle(
                                        color: Color.fromRGBO(255, 255, 255, 1),
                                        fontFamily: 'Lato',
                                        fontSize: 20,
                                        letterSpacing:
                                            0 /*percentages not used in flutter. defaulting to zero*/,
                                        fontWeight: FontWeight.normal,
                                        height: 1),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        BlogComment(
                            dp: 'assets/images/Ellipse111.png',
                            commen:
                                'My mum just visited us today, the kids are on the moon',
                            id: '@dannygloves',
                            name: 'Danny Gloves'),
                        SizedBox(height: 20),
                        BlogComment(
                            dp: 'assets/images/Ellipse111.png',
                            commen:
                                'Lorem ipsum dolor sit amet, consectetur adipiscing elit. At tincidunt volutpat eget luctus. Ornare ipsum fermentum nunc purus et ac elementum mauris. Leo sapien feugiat vel vitae, cursus vel. Gravida nulla arcu suspendisse bibendum. Volutpat lorem arcu vulputate ipsum auctor nibh ultrices. Nisi purus bibendum magna lectus aliquam tellus aliquet. Amet eget nascetur augue accumsan et. Elementum volutpat, ac purus nibh tortor. Eget sed augue habitasse felis nunc sit. Faucibus et facilisis non volutpat et. Eget sit ipsum ullamcorper commodo rhoncus ut.',
                            id: '@royjessy',
                            name: 'Jessy Roy'),
                        SizedBox(height: 20),
                        BlogComment(
                            dp: 'assets/images/Ellipse111.png',
                            commen:
                                'My mum just visited us today, the kids are on the moon',
                            id: '@dannygloves',
                            name: 'Danny Gloves'),
                        SizedBox(height: 20),
                        BlogComment(
                            dp: 'assets/images/Ellipse111.png',
                            commen:
                                'Lorem ipsum dolor sit amet, consectetur adipiscing elit. At tincidunt volutpat eget luctus. Ornare ipsum fermentum nunc purus et ac elementum mauris. Leo sapien feugiat vel vitae, cursus vel. Gravida nulla arcu suspendisse bibendum. Volutpat lorem arcu vulputate ipsum auctor nibh ultrices. Nisi purus bibendum magna lectus aliquam tellus aliquet. Amet eget nascetur augue accumsan et. Elementum volutpat, ac purus nibh tortor. Eget sed augue habitasse felis nunc sit. Faucibus et facilisis non volutpat et. Eget sit ipsum ullamcorper commodo rhoncus ut.',
                            id: '@royjessy',
                            name: 'Jessy Roy'),
                        SizedBox(height: 20),
                      ],
                    ),
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
