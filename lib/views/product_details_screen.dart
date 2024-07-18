import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:like_button/like_button.dart';
import 'package:luxelane/animation/fade_animation.dart';
import 'package:luxelane/constants/theme.dart';
import 'package:luxelane/model/product_model.dart';
import 'package:luxelane/provider/cart_provider.dart';
import 'package:luxelane/provider/product_provider.dart';
import 'package:luxelane/views/cart_screen.dart';
import 'package:luxelane/widgets/snackbar.dart';
import 'package:provider/provider.dart';

class ProductDetailsScreen extends StatefulWidget {
  final ProductModel product;
  const ProductDetailsScreen({super.key, required this.product});

  @override
  State<ProductDetailsScreen> createState() => _ProductDetailsScreenState();
}

class _ProductDetailsScreenState extends State<ProductDetailsScreen> {
  Color selectedColor = Colors.black;
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    final productProvider = Provider.of<ProductProvider>(context);
    return SafeArea(
      child: Scaffold(
        backgroundColor: Utils.maincolor,
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              clipBehavior: Clip.none,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(35),
                  ),
                  child: Image.asset(
                    widget.product.image,
                    height: size.height * 0.55,
                    width: size.width,
                    fit: BoxFit.cover,
                  ),
                ),
                Positioned(
                    top: size.height * 0.055,
                    right: size.width * 0.030,
                    left: size.width * 0.030,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        GestureDetector(
                          onTap: () {
                            Navigator.pop(context);
                          },
                          child: Icon(
                            Icons.arrow_back,
                            color: Colors.white,
                            size: size.height * 0.035,
                          ),
                        ),
                        Text(
                          'Product',
                          style: GoogleFonts.poppins(
                            color: Colors.white,
                            fontSize: size.width * 0.045,
                            fontWeight: FontWeight.w500,
                          ),
                        ),

                        // Icon(
                        //   Icons.shopping_cart_outlined,
                        //   size: size.height * 0.035,
                        //   color: Colors.white,
                        // ),
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
                                size: size.height * 0.035,
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
                    )),
                widget.product.isAvailable
                    ? Positioned(
                        bottom: -25,
                        right: size.width * 0.045,
                        child: FadeAnimation(
                          2,
                          Container(
                              height: 50,
                              width: 50,
                              decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: Utils.shadee,
                                  gradient: LinearGradient(
                                      begin: Alignment.topLeft,
                                      end: Alignment.bottomRight,
                                      colors: [Utils.shadee, Utils.shadee]),
                                  boxShadow: const [
                                    BoxShadow(
                                        color: Colors.black38,
                                        blurRadius: 10,
                                        spreadRadius: 1,
                                        offset: Offset(4.0, 4.0)),
                                    BoxShadow(
                                        color: Colors.black38,
                                        blurRadius: 10,
                                        spreadRadius: 1,
                                        offset: Offset(-4.0, -4.0))
                                  ]),
                              child: LikeButton(
                                  isLiked: widget.product.isFavorite,
                                  onTap: (bool isLiked) async {
                                    productProvider
                                        .toggleFavorite(widget.product);
                                    return !isLiked;
                                  },
                                  animationDuration:
                                      const Duration(milliseconds: 1000),
                                  circleColor: const CircleColor(
                                      start: Color(0xFFFF5722),
                                      end: Color(0xFFF44336)),
                                  bubblesColor: const BubblesColor(
                                    dotPrimaryColor: const Color(0xFFFFC107),
                                    dotSecondaryColor: const Color(0xFFFF9800),
                                    dotThirdColor: const Color(0xFFFF5722),
                                    dotLastColor: const Color(0xFFF44336),
                                  ),
                                  likeBuilder: (bool isLiked) {
                                    return Icon(
                                        isLiked
                                            ? Icons.favorite
                                            : Icons.favorite_border,
                                        size: 30,
                                        color: isLiked
                                            ? Colors.redAccent
                                            : Colors.redAccent);
                                  })),
                        ))
                    : SizedBox(),
              ],
            ),
            SizedBox(
              height: size.height * 0.030,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 20),
              child: FadeAnimation(
                2,
                Text(
                  "\$${widget.product.price}",
                  style: GoogleFonts.poppins(
                    color: Utils.pacificblue,
                    fontSize: size.width * 0.07,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 22, right: 30),
              child: FadeAnimation(
                2,
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      widget.product.name,
                      style: GoogleFonts.poppins(
                        color: Colors.white,
                        fontSize: size.width * 0.037,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    Row(
                      children: [
                        Icon(
                          Icons.star,
                          color: Utils.pacificblue,
                          size: size.height * 0.020,
                        ),
                        SizedBox(
                          width: 5,
                        ),
                        Icon(
                          Icons.star,
                          color: Utils.pacificblue,
                          size: size.height * 0.020,
                        ),
                        SizedBox(
                          width: 5,
                        ),
                        Icon(
                          Icons.star,
                          color: Utils.pacificblue,
                          size: size.height * 0.020,
                        ),
                        SizedBox(
                          width: 5,
                        ),
                        Icon(
                          Icons.star_border_outlined,
                          color: Utils.pacificblue,
                          size: size.height * 0.020,
                        ),
                        SizedBox(
                          width: 5,
                        ),
                        Icon(
                          Icons.star_outline_outlined,
                          color: Utils.pacificblue,
                          size: size.height * 0.020,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(
              height: size.height * 0.020,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 22),
              child: FadeAnimation(
                2,
                Text(
                  "Color options",
                  style: GoogleFonts.poppins(
                      color: Colors.white.withOpacity(0.8),
                      fontWeight: FontWeight.w500),
                ),
              ),
            ),
            SizedBox(
              height: size.height * 0.010,
            ),
            Padding(
                padding: const EdgeInsets.only(left: 22),
                child: FadeAnimation(
                  2,
                  Row(
                    children: [
                      SizedBox(
                        height: 30,
                        child: ListView.builder(
                            shrinkWrap: true,
                            physics: NeverScrollableScrollPhysics(),
                            scrollDirection: Axis.horizontal,
                            itemCount: widget.product.colors!.length,
                            itemBuilder: (context, index) {
                              Color color = widget.product.colors![index];

                              return GestureDetector(
                                onTap: () {
                                  setState(() {
                                    selectedColor = color;
                                  });
                                },
                                child: Container(
                                  margin: EdgeInsets.symmetric(horizontal: 5),
                                  width: 25,
                                  height: 25,
                                  decoration: BoxDecoration(
                                      color: color,
                                      shape: BoxShape.circle,
                                      border: Border.all(
                                        width: 2,
                                        color: selectedColor == color
                                            ? Utils.pacificblue
                                            : Colors.transparent,
                                      )),
                                ),
                              );
                            }),
                      )
                    ],
                  ),
                )),
            SizedBox(
              height: size.height * 0.020,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 22),
              child: FadeAnimation(
                2,
                Text(
                  "Description",
                  style: GoogleFonts.poppins(
                      color: Colors.white.withOpacity(0.8),
                      fontWeight: FontWeight.w500),
                ),
              ),
            ),
            SizedBox(
              height: size.height * 0.010,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 22, right: 10),
              child: FadeAnimation(
                2,
                Text(
                  textAlign: TextAlign.justify,
                  widget.product.desc,
                  style: GoogleFonts.poppins(
                    color: Colors.white.withOpacity(0.8),
                  ),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: size.height * 0.060),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(),
                  widget.product.isAvailable
                      ? FadeAnimation(
                          2,
                          GestureDetector(
                            onTap: () {
                              context
                                  .read<CartProvider>()
                                  .addToCart(widget.product);
                              showTopSnackBar(context);
                            },
                            child: Container(
                              height: size.height * 0.075,
                              width: size.width * 0.40,
                              decoration: BoxDecoration(
                                  color: Utils.pacificblue,
                                  borderRadius: BorderRadius.only(
                                      topLeft: Radius.circular(30),
                                      bottomRight: Radius.circular(30))),
                              child: Padding(
                                padding: const EdgeInsets.only(left: 15),
                                child: Row(
                                  children: [
                                    Icon(
                                      Icons.add,
                                      color: Colors.white,
                                    ),
                                    SizedBox(
                                      width: size.width * 0.010,
                                    ),
                                    Text(
                                      "Add to cart",
                                      style: GoogleFonts.poppins(
                                          color: Colors.white,
                                          fontSize: size.width * 0.040,
                                          fontWeight: FontWeight.w500),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        )
                      : SizedBox(),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
