import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:luxelane/animation/fade_animation.dart';

import 'package:luxelane/constants/theme.dart';
import 'package:luxelane/provider/cart_provider.dart';
import 'package:luxelane/widgets/cart_item.dart';
import 'package:luxelane/widgets/payment_button.dart';
import 'package:provider/provider.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({super.key});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
        backgroundColor: Utils.maincolor,
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: SizedBox(
                child: SingleChildScrollView(
                  physics: ScrollPhysics(),
                  child: context.watch<CartProvider>().shoppingCart.isNotEmpty
                      ? Column(
                          children: [
                            Padding(
                              padding: EdgeInsets.only(
                                  left: 20,
                                  top: size.height * 0.050,
                                  right: 20,
                                  bottom: size.height * 0.030),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  GestureDetector(
                                    onTap: () {
                                      Navigator.pop(context);
                                    },
                                    child: Icon(
                                      Icons.arrow_back,
                                      color: Colors.white,
                                      size: 30,
                                    ),
                                  ),
                                  Text(
                                    'Cart',
                                    style: GoogleFonts.poppins(
                                        fontSize: size.width * 0.055,
                                        color: Colors.white,
                                        fontWeight: FontWeight.w500),
                                  ),
                                  Stack(
                                    clipBehavior: Clip.none,
                                    children: [
                                      Icon(
                                        Icons.shopping_cart_outlined,
                                        color: Colors.white,
                                        size: size.width * 0.080,
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
                                                backgroundColor:
                                                    Utils.pacificblue,
                                                radius: 10,
                                                child: Text(
                                                  context
                                                      .watch<CartProvider>()
                                                      .shoppingCart
                                                      .length
                                                      .toString(),
                                                  style: GoogleFonts.poppins(
                                                      fontSize: 10,
                                                      fontWeight:
                                                          FontWeight.w500,
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
                            Consumer<CartProvider>(
                                builder: (context, value, child) {
                              return FadeAnimation(
                                2,
                                Column(
                                  children: value.shoppingCart
                                      .map((cartItem) => CartItem(
                                            cartModel: cartItem,
                                          ))
                                      .toList(),
                                ),
                              );
                            }),
                          ],
                        )
                      : Center(
                          child: Padding(
                            padding: const EdgeInsets.all(15),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 10, vertical: 15),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      GestureDetector(
                                        onTap: () {
                                          Navigator.pop(context);
                                        },
                                        child: Icon(
                                          Icons.arrow_back,
                                          color: Colors.white,
                                          size: 30,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                SizedBox(
                                  height: size.height * 0.15,
                                ),
                                Icon(
                                  Icons.shopping_cart_outlined,
                                  color: Colors.grey,
                                  size: size.width * 0.20,
                                ),
                                SizedBox(
                                  height: size.height * 0.20,
                                ),
                                Text(
                                  "Your cart is empty!",
                                  style: GoogleFonts.poppins(
                                    //fontSize: size.width*0.
                                    fontSize: 20,
                                    color: Colors.grey,
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                ),
              ),
            ),
            // SizedBox(
            //   height: size.height * 0.010,
            // ),
            AnimatedSwitcher(
              duration: const Duration(milliseconds: 800),
              transitionBuilder: (Widget child, Animation<double> animation) {
                // Slide transition for vertical movement
                final slideTransition = SlideTransition(
                  position: Tween<Offset>(
                    begin: Offset(0.0, 1.0),
                    end: Offset(0.0, 0.0),
                  ).animate(animation),
                  child: child,
                );

                // Fade transition for opacity
                final fadeTransition = FadeTransition(
                  opacity: animation,
                  child: slideTransition,
                );

                return fadeTransition;
              },
              child: context.watch<CartProvider>().hasSelectedItems()
                  ? Container(
                      key: const ValueKey<bool>(true),
                      height: size.height * 0.30,
                      width: size.width,
                      decoration: BoxDecoration(
                        color: Utils.spread,
                        borderRadius: BorderRadius.circular(30),
                        boxShadow: [
                          BoxShadow(
                              color: Colors.black38,
                              blurRadius: 15,
                              spreadRadius: 1,
                              offset: Offset(4.0, 4.0)),
                          BoxShadow(
                              color: Colors.black38,
                              blurRadius: 15,
                              spreadRadius: 1,
                              offset: Offset(-4.0, -4.0))
                        ],
                        gradient: LinearGradient(
                          colors: [Utils.maincolor, Utils.pacificblue],
                          begin: Alignment.topRight,
                          end: Alignment.bottomLeft,
                        ),
                      ),
                      child: Padding(
                        padding: EdgeInsets.only(
                          left: size.height * 0.040,
                          right: size.height * 0.040,
                          top: size.height * 0.025,
                        ),
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  'Selected Items',
                                  style: GoogleFonts.poppins(
                                      fontSize: 16,
                                      color: Colors.white.withOpacity(0.8)),
                                ),
                                Text(
                                  "\$${context.watch<CartProvider>().selectedItemsTotal}",
                                  style: GoogleFonts.poppins(
                                      fontSize: 16, color: Utils.pacificblue),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: size.height * 0.010,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  'Shipping Fee',
                                  style: GoogleFonts.poppins(
                                      fontSize: 16,
                                      color: Colors.white.withOpacity(0.8)),
                                ),
                                Text(
                                  "\$${context.watch<CartProvider>().shippingCharge}",
                                  style: GoogleFonts.poppins(
                                      fontSize: 16, color: Utils.pacificblue),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: size.height * 0.015,
                            ),
                            Container(
                              height: size.height * 0.0018,
                              width: size.width,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  color: Colors.grey),
                            ),
                            SizedBox(
                              height: size.height * 0.020,
                            ),
                            Padding(
                              padding: EdgeInsets.symmetric(
                                  horizontal: size.width * 0.015),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    'Total Price',
                                    style: GoogleFonts.poppins(
                                        fontSize: 25,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white.withOpacity(0.8)),
                                  ),
                                  Text(
                                    "\$${context.watch<CartProvider>().totalCart}",
                                    style: GoogleFonts.poppins(
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold,
                                        color: Utils.pacificblue),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(
                              height: size.height * 0.020,
                            ),
                            // Container(
                            //   height: size.height * 0.060,
                            //   width: size.width * 0.55,
                            //   decoration: BoxDecoration(
                            //       borderRadius: BorderRadius.circular(25),
                            //       color: Utils.pacificblue),
                            //   child: Center(
                            //     child: Text(
                            //       "checkout",
                            //       style: GoogleFonts.poppins(
                            //           fontWeight: FontWeight.bold,
                            //           fontSize: 20,
                            //           color: Colors.white),
                            //     ),
                            //   ),
                            // ),
                            PaymentButton(),
                          ],
                        ),
                      ),
                    )
                  : SizedBox(
                      key: ValueKey<bool>(true),
                    ),
            )
          ],
        ),
      ),
    );
  }
}
