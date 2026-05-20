import 'package:flutter/material.dart';
import 'package:flutter_avif/flutter_avif.dart';
import 'package:google_fonts/google_fonts.dart';
import 'product_data.dart';

Widget buildCartCards(
  BuildContext context, {
  required String title,
  required String price,
  required String imagePath,
  required VoidCallback onDelete,
}) {
  final bool isAvif = imagePath.toLowerCase().endsWith('.avif');

  return Card(
    margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
    color: Colors.white,
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
    child: Padding(
      padding: EdgeInsets.all(12),
      child: Row(
        children: [
          Container(
            width: 80,
            height: 80,
            decoration: BoxDecoration(
              color: Color(0xFFF5ECEC),
              borderRadius: BorderRadius.circular(12),
            ),
            padding: EdgeInsets.all(8),
            child: () {
              if (isAvif) {
                return AvifImage.asset(imagePath, fit: BoxFit.contain);
              } else {
                return Image.asset(imagePath, fit: BoxFit.contain);
              }
            }(),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: GoogleFonts.ebGaramond(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF3A1121),
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  price,
                  style: GoogleFonts.ebGaramond(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF3A1121),
                  ),
                ),
              ],
            ),
          ),
          IconButton(
            icon: const Icon(Icons.delete_outline, color: Color(0xFFBC8F8F)),
            onPressed: onDelete,
          ),
        ],
      ),
    ),
  );
}

class AddToCartPage extends StatefulWidget {
  const AddToCartPage({super.key}); // No parameters needed anymore!

  @override
  State<AddToCartPage> createState() => _AddToCartPage();
}

class _AddToCartPage extends State<AddToCartPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Drawer(
        // color: const Color(0xFFFBF4F4),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            DrawerHeader(
              decoration: const BoxDecoration(color: Color(0xFFBC8F8F)),
              child: Center(
                child: Text(
                  "Home",
                  style: GoogleFonts.ebGaramond(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                    letterSpacing: 2.0,
                  ),
                ),
              ),
            ),
            ListTile(
              leading: const Icon(
                Icons.home_outlined,
                color: Color(0xFF3A1121),
              ),
              title: Text(
                "Shop Catalog",
                style: GoogleFonts.ebGaramond(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              onTap: () => Navigator.pop(context), // Closes drawer tray safely
            ),
            ListTile(
              leading: const Icon(
                Icons.shopping_bag_outlined,
                color: Color(0xFF3A1121),
              ),
              title: Text(
                "My Basket",
                style: GoogleFonts.ebGaramond(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              onTap: () {
                Navigator.pop(context); // Close drawer first
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (c) => const AddToCartPage()),
                );
              },
            ),
          ],
        ),
      ),
      appBar: AppBar(
        //   backgroundColor: const Color.fromARGB(255, 237, 228, 228),
        leading: IconButton(
          icon: const Icon(Icons.menu),
          onPressed: () {
            Scaffold.of(context).openDrawer();
          },
        ),
        iconTheme: IconThemeData(color: Color(0xFF3A1121)),
        title: Text(
          "My Basket",
          style: GoogleFonts.ebGaramond(
            color: Color(0xFF3A1121),
            fontWeight: FontWeight.bold,
            fontSize: 24,
          ),
        ),
      ),
      body: Stack(
        children: [
          Container(
            width: double.infinity,
            height: double.infinity,
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [Color(0xFFFBF4F4), Color(0xFFF4DFDF)],
              ),
            ),
          ),
          SafeArea(
            child: globalUserCart.isEmpty
                ? Center(
                    child: Text(
                      "Your basket is empty",
                      style: GoogleFonts.ebGaramond(
                        fontSize: 20,
                        color: const Color(0xFF3A1121),
                      ),
                    ),
                  )
                : ListView.builder(
                    padding: const EdgeInsets.only(top: 16.0, bottom: 100.0),
                    itemCount: globalUserCart.length,
                    itemBuilder: (context, index) {
                      final item = globalUserCart[index];

                      return buildCartCards(
                        context,
                        title: item["title"] ?? "Product",
                        price: item["price"] ?? "",
                        imagePath: item["imagePath"] ?? "",
                        onDelete: () {
                          // Removes the item from memory and refreshes the page interface instantly
                          setState(() {
                            globalUserCart.removeAt(index);
                          });
                        },
                      );
                    },
                  ),
          ),
        ],
      ),
    );
  }
}
