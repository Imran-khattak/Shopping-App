import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:like_button/like_button.dart';
import 'package:luxelane/animation/fade_animation.dart';
import 'package:luxelane/constants/theme.dart';
import 'package:luxelane/model/product_model.dart';
import 'package:luxelane/provider/cart_provider.dart';
import 'package:luxelane/provider/product_provider.dart';
import 'package:luxelane/views/cart_screen.dart';
import 'package:luxelane/views/product_details_screen.dart';
import 'package:luxelane/widgets/hero_widget.dart';
import 'package:luxelane/widgets/snackbar.dart';
import 'package:provider/provider.dart';

class AllProduct extends StatefulWidget {
  const AllProduct({super.key});

  @override
  State<AllProduct> createState() => _AllProductState();
}

class _AllProductState extends State<AllProduct> {
  @override
  Widget build(BuildContext context) {
    final productProvider = Provider.of<ProductProvider>(context);
    final List<ProductModel> allproduct = [
      ...productProvider.shirts,
      ...productProvider.shoes,
      ...productProvider.pants,
    ];
    final List<ProductModel> favoriteProducts =
        allproduct.where((product) => product.isFavorite).toList();

    Size size = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
        backgroundColor: Utils.maincolor,
        appBar: AppBar(
          toolbarHeight: 70,
          automaticallyImplyLeading: false,
          backgroundColor: Utils.maincolor,
          title: Padding(
            padding:
                const EdgeInsets.only(left: 8, right: 8, top: 18, bottom: 10),
            child: Builder(builder: (context) {
              return Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GestureDetector(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: const Icon(
                      Icons.arrow_back,
                      size: 30,
                      color: Colors.white,
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
                                  builder: (context) => const CartScreen()));
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
                            : const SizedBox(),
                      )
                    ],
                  ),
                ],
              );
            }),
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.all(15),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      'Best Selling',
                      style: GoogleFonts.poppins(
                          color: Colors.white,
                          fontSize: size.width * 0.050,
                          fontWeight: FontWeight.w600,
                          letterSpacing: 0.5),
                    ),
                  ),
                ),
                GridView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 6,
                    mainAxisSpacing: 6,
                    childAspectRatio: 0.6,
                  ),
                  itemCount: allproduct.length,
                  itemBuilder: (contex, index) {
                    final product = allproduct[index];
                    return Padding(
                      padding: const EdgeInsets.all(8),
                      child: FadeAnimation(
                        1.2,
                        Container(
                            // height: size.height * 0.70,
                            // width: size.width * 0.55,
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
                                      padding: const EdgeInsets.only(
                                          left: 12, right: 12, top: 15),
                                      child: ClipRRect(
                                        borderRadius: BorderRadius.circular(15),
                                        child: GestureDetector(
                                          onTap: () {
                                            Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (context) =>
                                                        ProductDetailsScreen(
                                                            product: product)));
                                          },
                                          child: HeroWidget(
                                            tag: 'product-image-${product.id}',
                                            child: Image.asset(
                                              product.image,
                                              height: size.height * 0.20,
                                              width: double.infinity,
                                              fit: BoxFit.cover,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                    Positioned(
                                      top: 25,
                                      right: 18,
                                      child: product.isAvailable
                                          ? LikeButton(
                                              isLiked: product.isFavorite,
                                              onTap: (bool isLiked) async {
                                                productProvider
                                                    .toggleFavorite(product);
                                                return !isLiked;
                                              },
                                              animationDuration: const Duration(
                                                  milliseconds: 1000),
                                              circleColor: const CircleColor(
                                                  start: Color(0xFFFF5722),
                                                  end: Color(0xFFF44336)),
                                              bubblesColor: const BubblesColor(
                                                dotPrimaryColor:
                                                    Color(0xFFFFC107),
                                                dotSecondaryColor:
                                                    Color(0xFFFF9800),
                                                dotThirdColor:
                                                    Color(0xFFFF5722),
                                                dotLastColor: Color(0xFFF44336),
                                              ),
                                              likeBuilder: (bool isLiked) {
                                                return CircleAvatar(
                                                  backgroundColor:
                                                      Colors.red[400],
                                                  radius: 13,
                                                  child: Icon(
                                                    size: 17,
                                                    isLiked
                                                        ? Icons.favorite
                                                        : Icons
                                                            .favorite_border_rounded,
                                                    color: isLiked
                                                        ? Colors.white
                                                        : Colors.white,
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
                                    product.name,
                                    style: GoogleFonts.poppins(
                                        fontSize: size.width * 0.030,
                                        color: Colors.white,
                                        fontWeight: FontWeight.w500),
                                    overflow: TextOverflow.ellipsis,
                                    maxLines: 1,
                                  ),
                                ),
                                product.isAvailable
                                    ? Padding(
                                        padding:
                                            const EdgeInsets.only(left: 13),
                                        child: Row(
                                          children: [
                                            const CircleAvatar(
                                              backgroundColor:
                                                  Color(0xff03b680),
                                              radius: 3,
                                            ),
                                            const SizedBox(
                                              width: 3,
                                            ),
                                            Text(
                                              "Availbale",
                                              style: GoogleFonts.poppins(
                                                fontSize: size.width * 0.025,
                                                color: const Color(0xff03b680),
                                                fontWeight: FontWeight.w500,
                                              ),
                                            )
                                          ],
                                        ),
                                      )
                                    : Padding(
                                        padding:
                                            const EdgeInsets.only(left: 13),
                                        child: Row(
                                          children: [
                                            const CircleAvatar(
                                              backgroundColor: Colors.redAccent,
                                              radius: 3,
                                            ),
                                            const SizedBox(
                                              width: 3,
                                            ),
                                            Text(
                                              "Out of stock",
                                              style: GoogleFonts.poppins(
                                                fontSize: size.width * 0.025,
                                                color: Colors.redAccent,
                                                fontWeight: FontWeight.w500,
                                              ),
                                            )
                                          ],
                                        ),
                                      ),
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 14, vertical: 10),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        "\$ ${product.price}",
                                        style: GoogleFonts.poppins(
                                            color: Utils.pacificblue,
                                            fontSize: size.width * 0.035,
                                            fontWeight: FontWeight.w500),
                                      ),
                                      product.isAvailable
                                          ? GestureDetector(
                                              onTap: () {
                                                context
                                                    .read<CartProvider>()
                                                    .addToCart(product);
                                                showTopSnackBar(context);
                                              },
                                              child: const CircleAvatar(
                                                backgroundColor: Colors.white,
                                                radius: 13,
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
                  },
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
