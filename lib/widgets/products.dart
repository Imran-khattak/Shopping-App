import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:like_button/like_button.dart';
import 'package:luxelane/animation/fade_animation.dart';
import 'package:luxelane/constants/theme.dart';
import 'package:luxelane/model/product_model.dart';
import 'package:luxelane/provider/cart_provider.dart';
import 'package:luxelane/provider/product_provider.dart';
import 'package:luxelane/views/product_details_screen.dart';
import 'package:luxelane/widgets/hero_widget.dart';
import 'package:luxelane/widgets/snackbar.dart';
import 'package:provider/provider.dart';

class Products extends StatefulWidget {
  final ProductModel product;

  Products({
    super.key,
    required this.product,
  });

  @override
  State<Products> createState() => _ProductsState();
}

class _ProductsState extends State<Products> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    final productProvider = Provider.of<ProductProvider>(context);

    return Padding(
      padding: const EdgeInsets.all(10),
      child: FadeAnimation(
        2,
        Container(
            height: size.height * 0.40,
            width: size.width * 0.55,
            decoration: BoxDecoration(
                color: Utils.maincolor,
                borderRadius: BorderRadius.circular(15),
                boxShadow: const [
                  BoxShadow(
                      color: Colors.black26,
                      blurRadius: 15,
                      spreadRadius: 1,
                      offset: Offset(4.0, 4.0)),
                  BoxShadow(
                      color: Colors.black26,
                      blurRadius: 15,
                      spreadRadius: 1,
                      offset: Offset(-4.0, -4.0))
                ]),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Stack(
                  children: [
                    Padding(
                      padding:
                          const EdgeInsets.only(left: 12, right: 12, top: 15),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(15),
                        child: GestureDetector(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => ProductDetailsScreen(
                                        product: widget.product)));
                          },
                          child: HeroWidget(
                            tag: 'product-image-${widget.product.id}',
                            child: Image.asset(
                              widget.product.image,
                              height: size.height * 0.25,
                              width: size.width * 0.50,
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                      ),
                    ),
                    Positioned(
                      top: 25,
                      right: 18,
                      child: widget.product.isAvailable
                          ? LikeButton(
                              isLiked: widget.product.isFavorite,
                              onTap: (bool isLiked) async {
                                productProvider.toggleFavorite(widget.product);
                                return !isLiked;
                              },
                              animationDuration:
                                  const Duration(milliseconds: 1000),
                              circleColor: const CircleColor(
                                  start: Color(0xFFFF5722),
                                  end: Color(0xFFF44336)),
                              bubblesColor: const BubblesColor(
                                dotPrimaryColor: Color(0xFFFFC107),
                                dotSecondaryColor: Color(0xFFFF9800),
                                dotThirdColor: Color(0xFFFF5722),
                                dotLastColor: Color(0xFFF44336),
                              ),
                              likeBuilder: (bool isLiked) {
                                return CircleAvatar(
                                  backgroundColor: Colors.red[400],
                                  radius: 16,
                                  child: Icon(
                                    isLiked
                                        ? Icons.favorite
                                        : Icons.favorite_border_rounded,
                                    color:
                                        isLiked ? Colors.white : Colors.white,
                                  ),
                                );
                              },
                            )
                          : const SizedBox(),
                    )
                  ],
                ),
                SizedBox(
                  height: size.height * 0.010,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 15),
                  child: Text(
                    widget.product.name,
                    style: GoogleFonts.poppins(
                        fontSize: size.width * 0.040,
                        color: Colors.white,
                        fontWeight: FontWeight.w500),
                  ),
                ),
                widget.product.isAvailable
                    ? Padding(
                        padding: const EdgeInsets.only(left: 13),
                        child: Row(
                          children: [
                            const CircleAvatar(
                              backgroundColor: Color(0xff03b680),
                              radius: 5,
                            ),
                            const SizedBox(
                              width: 3,
                            ),
                            Text(
                              "Availbale",
                              style: GoogleFonts.poppins(
                                fontSize: size.width * 0.030,
                                color: const Color(0xff03b680),
                                fontWeight: FontWeight.w500,
                              ),
                            )
                          ],
                        ),
                      )
                    : Padding(
                        padding: const EdgeInsets.only(left: 13),
                        child: Row(
                          children: [
                            const CircleAvatar(
                              backgroundColor: Colors.redAccent,
                              radius: 5,
                            ),
                            const SizedBox(
                              width: 3,
                            ),
                            Text(
                              "Out of stock",
                              style: GoogleFonts.poppins(
                                fontSize: size.width * 0.030,
                                color: Colors.redAccent,
                                fontWeight: FontWeight.w500,
                              ),
                            )
                          ],
                        ),
                      ),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "\$ ${widget.product.price}",
                        style: GoogleFonts.poppins(
                            color: Utils.pacificblue,
                            fontSize: size.width * 0.045,
                            fontWeight: FontWeight.w500),
                      ),
                      widget.product.isAvailable
                          ? GestureDetector(
                              onTap: () {
                                context
                                    .read<CartProvider>()
                                    .addToCart(widget.product);
                                showTopSnackBar(context);
                                // ScaffoldMessenger.of(context)
                                //     .showSnackBar(SnackBar(
                                //   backgroundColor: Utils.pacificblue,
                                //   content: Text(
                                //     'item added!',
                                //     style: TextStyle(
                                //       color: Colors.white,
                                //     ),
                                //   ),
                                // ));
                              },
                              child: const CircleAvatar(
                                backgroundColor: Colors.white,
                                radius: 16,
                                child: Icon(
                                  Icons.add,
                                  color: Colors.black,
                                ),
                              ),
                            )
                          : const SizedBox(),
                    ],
                  ),
                )
              ],
            )),
      ),
    );
  }
}
