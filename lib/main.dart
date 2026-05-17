import 'package:flutter/material.dart';
import 'package:flutter_avif/flutter_avif.dart';
import 'package:google_fonts/google_fonts.dart';

void main() {
  runApp(const HomePage());
}

//Making a reusable card function for the home page
Widget buildCenteredCard({required String title, required String imagePath}) {
  return Container(
    color: Color(0xFFBC8F8F),
    width: 700,
    child: Card(
      margin: EdgeInsets.only(top: 0.0),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(65),
          bottomRight: Radius.circular(65),
        ),
      ),
      child: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            SizedBox(height: 50),
            Text(
              title,
              style: GoogleFonts.ebGaramond(
                fontSize: 28,
                fontWeight: FontWeight.w700,
                letterSpacing: 1.0,
                color: Color(0xFF3A1121),
              ),
              textAlign: TextAlign.center,
            ),

            AvifImage.asset(
              imagePath,
              width: 360,
              height: 360,
              fit: BoxFit.contain,
            ),
            SizedBox(height: 5),
          ],
        ),
      ),
    ),
  );
}

Widget buildDescriptionCard({
  required String title,
  required String description,
  required String price,
}) {
  return Card(
    // offset: const Offset(0, -45.0),
    margin: EdgeInsets.zero,
    color: Color(0xFFBC8F8F),
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.only(
        bottomLeft: Radius.circular(65),
        bottomRight: Radius.circular(65),
      ),
    ),
    child: Padding(
      padding: EdgeInsets.fromLTRB(24.0, 20.0, 24.0, 24.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            title,
            textAlign: TextAlign.center,
            style: GoogleFonts.ebGaramond(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          const SizedBox(height: 12),
          Text(
            description,
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 14, color: Colors.white, height: 1.4),
          ),
          SizedBox(height: 5),
          Text(
            price,
            textAlign: TextAlign.center,
            style: GoogleFonts.ebGaramond(
              fontSize: 22,
              fontWeight: FontWeight.w800,
              color: Colors.white, // Dark wine color contrast for price
            ),
          ),
        ],
      ),
    ),
  );
}

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        // backgroundColor: Colors.white,
        appBar: AppBar(
          //   backgroundColor: const Color.fromARGB(255, 237, 228, 228),
          leading: IconButton(icon: const Icon(Icons.menu), onPressed: () {}),
        ),
        body: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              buildCenteredCard(
                title: "AQUA UNIVERSALIS",
                imagePath: "assets/images/shalimar2.avif",
              ),
              Container(
                width: 200,
                height: 1,
                color: Color(0xFFBC8F8F), // Adds the background color directly
              ),
              buildDescriptionCard(
                title: "AQUA UNIVERSALIS",
                description:
                    "Luxury that lingers.Be unconventionally free with this flowery-vanilla eau de parfum.In the heart of the fragrance. ",
                price: '£ 70.00',
              ),
              Ink(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(65),
                    bottomRight: Radius.circular(65),
                    topLeft: Radius.zero,
                    topRight: Radius.zero,
                  ),
                ),
                child: InkWell(
                  onTap: () {
                    //Navigate to the next page
                  },
                  child: Padding(
                    padding: EdgeInsets.symmetric(
                      vertical: 16.0,
                      horizontal: 24.0,
                    ),

                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Icon(Icons.add_shopping_cart, color: Color(0xFF3A1121)),

                        SizedBox(width: 20),
                        Text(
                          "Add to basket",
                          style: GoogleFonts.ebGaramond(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
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
