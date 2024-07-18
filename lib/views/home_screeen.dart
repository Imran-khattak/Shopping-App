import 'package:add_to_cart_animation/add_to_cart_animation.dart';
import 'package:add_to_cart_animation/add_to_cart_icon.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iconsax/iconsax.dart';
import 'package:luxelane/constants/theme.dart';
import 'package:luxelane/provider/cart_animation_provider.dart';
import 'package:luxelane/provider/cart_provider.dart';
import 'package:luxelane/provider/product_provider.dart';
import 'package:luxelane/views/cart_screen.dart';
import 'package:luxelane/views/product_details_screen.dart';
import 'package:luxelane/widgets/best_selling.dart';
import 'package:luxelane/widgets/products.dart';
import 'package:provider/provider.dart';

import 'all_product.dart';

class HomeScreeen extends StatefulWidget {
  const HomeScreeen({super.key});

  @override
  State<HomeScreeen> createState() => _HomeScreeenState();
}

class _HomeScreeenState extends State<HomeScreeen> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    final cartAnimationProvider = Provider.of<CartAnimationProvider>(context);
    print('build');
    return SafeArea(
      child: Scaffold(
        backgroundColor: Utils.maincolor,
        body: SingleChildScrollView(
          physics: ScrollPhysics(),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Image.asset(
                      'assets/menu.png',
                      height: 40,
                      width: 40,
                    ),
                    const CircleAvatar(
                      radius: 23,
                      foregroundColor: Colors.white,
                      child: CircleAvatar(
                        radius: 20,
                        foregroundImage: AssetImage(
                          'assets/profile.png',
                        ),
                      ),
                    )
                  ],
                ),
              ),
              SizedBox(
                height: size.height * 0.020,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      width: size.width * 0.80,
                      height: size.height * 0.070,
                      decoration: BoxDecoration(
                          color: Utils.maincolor,
                          borderRadius: BorderRadius.circular(15),
                          gradient: LinearGradient(
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight,
                              colors: [
                                Utils.maincolor,
                                Utils.maincolor,
                              ],
                              stops: [
                                0.1,
                                0.9
                              ]),
                          boxShadow: [
                            BoxShadow(
                                color: Colors.black26,
                                blurRadius: 5,
                                spreadRadius: 1,
                                offset: Offset(-5.0, -5.0)),
                            BoxShadow(
                                color: Colors.black26,
                                blurRadius: 5,
                                spreadRadius: 1,
                                offset: Offset(5.0, 5.0))
                          ]),
                      child: TextField(
                        style: TextStyle(color: Colors.white),
                        decoration: InputDecoration(
                            fillColor: Utils.maincolor,
                            filled: true,
                            prefixIcon: Icon(
                              CupertinoIcons.search,
                              color: Colors.white,
                            ),
                            hintText: 'search',
                            hintStyle: GoogleFonts.poppins(
                                letterSpacing: 0.5,
                                fontSize: size.width * 0.038,
                                color: Colors.white),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(15),
                              borderSide: BorderSide(color: Utils.maincolor),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(15),
                              borderSide: BorderSide(color: Utils.maincolor),
                            )),
                      ),
                    ),
                    Stack(
                      clipBehavior: Clip.none,
                      children: [
                        GestureDetector(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => CartScreen()));
                          },
                          child: Icon(
                            Icons.shopping_cart_outlined,
                            color: Colors.white,
                            size: size.width * 0.090,
                          ),
                        ),
                        Positioned(
                          top: -25,
                          bottom: 5,
                          right: -3,
                          child: context
                                  .watch<CartProvider>()
                                  .shoppingCart
                                  .isNotEmpty
                              ? CircleAvatar(
                                  backgroundColor: Utils.pacificblue,
                                  radius: 10,
                                  child: Text(
                                    context
                                        .watch<CartProvider>()
                                        .shoppingCart
                                        .length
                                        .toString(),
                                    style: GoogleFonts.poppins(
                                        fontSize: 10,
                                        fontWeight: FontWeight.w500,
                                        color: Colors.white),
                                  ),
                                )
                              : SizedBox(),
                        )
                      ],
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: size.height * 0.020,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Explore',
                      style: GoogleFonts.poppins(
                          fontSize: size.height * 0.030, color: Colors.white),
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => AllProduct()));
                      },
                      child: Text(
                        'See All',
                        style: GoogleFonts.poppins(
                            fontSize: size.width * 0.040, color: Colors.white),
                      ),
                    )
                  ],
                ),
              ),
              SizedBox(
                height: size.height * 0.020,
              ),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child:
                    Consumer<ProductProvider>(builder: (contex, value, child) {
                  return Row(
                    children: value.shirts
                        .map((product) => Products(
                              product: product,
                            ))
                        .toList(),
                  );
                }),
              ),
              SizedBox(
                height: size.height * 0.020,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Best Selling',
                      style: GoogleFonts.poppins(
                          fontSize: size.height * 0.030, color: Colors.white),
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => AllProduct()));
                      },
                      child: Text(
                        'See All',
                        style: GoogleFonts.poppins(
                            fontSize: size.width * 0.040, color: Colors.white),
                      ),
                    )
                  ],
                ),
              ),
              SizedBox(
                height: size.height * 0.020,
              ),
              GestureDetector(
                  onTap: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => AllProduct()));
                  },
                  child: BestSelling()),
            ],
          ),
        ),
      ),
    );
  }

  // void addToCartClick(GlobalKey widgetKey) async {
  //   if (runAddToCartAnimation != null) {
  //     await runAddToCartAnimation!(widgetKey);
  //     await cartKey.currentState!
  //         .runCartAnimation((++_cartQuantityItems).toString());
  //     setState(() {});
  //   }
  // }
}
