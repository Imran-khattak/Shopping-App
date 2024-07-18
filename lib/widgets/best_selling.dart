import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iconsax/iconsax.dart';
import 'package:luxelane/animation/fade_animation.dart';
import 'package:luxelane/constants/theme.dart';

class BestSelling extends StatefulWidget {
  const BestSelling({super.key});

  @override
  State<BestSelling> createState() => _BestSellingState();
}

class _BestSellingState extends State<BestSelling> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Padding(
      padding: EdgeInsets.all(15),
      child: FadeAnimation(
        1.2,
        Container(
            height: size.height * 0.12,
            width: size.width * 0.90,
            decoration: BoxDecoration(
                color: Utils.shadee,
                borderRadius: BorderRadius.circular(15),
                gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [Utils.shadee, Utils.shadee]),
                boxShadow: [
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
            child: Row(
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 15),
                  child: Container(
                    height: 80,
                    width: 80,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        boxShadow: [
                          BoxShadow(
                              color: Colors.black26,
                              blurRadius: 10,
                              spreadRadius: 1,
                              offset: Offset(4.0, 4.0)),
                          BoxShadow(
                              color: Colors.black26,
                              blurRadius: 10,
                              spreadRadius: 1,
                              offset: Offset(-4.0, -4.0))
                        ]),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: Image.asset(
                        'assets/nike.jpg',
                        height: 80,
                        width: 80,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 25, top: 15),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Shoes",
                            style: GoogleFonts.poppins(
                                fontSize: size.width * 0.045,
                                color: Colors.white,
                                fontWeight: FontWeight.w500),
                          ),
                          Row(
                            children: [
                              CircleAvatar(
                                backgroundColor: Color(0xff03b680),
                                radius: 5,
                              ),
                              SizedBox(
                                width: 5,
                              ),
                              Text(
                                "Availbale",
                                style: GoogleFonts.poppins(
                                  fontSize: size.width * 0.030,
                                  color: Color(0xff03b680),
                                  fontWeight: FontWeight.w500,
                                ),
                              )
                            ],
                          ),
                          SizedBox(
                            height: size.height * 0.005,
                          ),
                          Text(
                            "\$100.00",
                            style: GoogleFonts.poppins(
                                color: Utils.pacificblue,
                                fontSize: size.width * 0.030,
                                fontWeight: FontWeight.w500),
                          )
                        ],
                      ),
                    ),
                    SizedBox(
                      width: size.width * 0.30,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 20),
                      child: Container(
                        height: 40,
                        width: 40,
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(10),
                            boxShadow: [
                              BoxShadow(
                                  color: Colors.black26,
                                  blurRadius: 10,
                                  spreadRadius: 1,
                                  offset: Offset(4.0, 4.0)),
                              BoxShadow(
                                  color: Colors.black26,
                                  blurRadius: 10,
                                  spreadRadius: 1,
                                  offset: Offset(-4.0, -4.0))
                            ]),
                        child: Icon(
                          Icons.arrow_forward,
                          color: Colors.black,
                        ),
                      ),
                    )
                  ],
                ),
              ],
            )),
      ),
    );
  }
}
