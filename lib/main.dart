import 'package:flutter/material.dart';
import 'product_data.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_avif/flutter_avif.dart';
import 'description.dart';
import 'add_to_cart.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: PerfumeShopPage(),
    );
  }
}

Widget buildProductCard(
  BuildContext context,
  Map<String, String> item,
  int index,
) {
  final String imagePath = item['imagePath'] ?? '';
  final bool isNetworkImage =
      imagePath.startsWith('http://') || imagePath.startsWith('https://');
  final bool isAvif = imagePath.toLowerCase().endsWith('.avif');

  final bool isEven = index % 2 == 0;
  final Color cardBackgroundColor = isEven
      ? const Color(0xFFBC8F8F)
      : Colors.white;
  final Color primaryTextColor = isEven
      ? Colors.white
      : const Color(0xFF3A1121);
  final Color secondaryTextColor = isEven
      ? Colors.white70
      : const Color(0xFF8B7373);

  return GestureDetector(
    onTap: () {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => DescriptionPage(
            title: item['title'] ?? 'Product',
            price: item['price'] ?? '',
            imagePath: imagePath,
            about: item['about'] ?? '',
          ),
        ),
      );
    },
    child: Container(
      // width: cardWidth,
      margin: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
      child: Card(
        elevation: 0, // Flat visual aesthetic matching your image
        color: cardBackgroundColor, // Dynamic background injection
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(24),
        ), // Smooth round edges
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // 3. Main Title Block
              Text(
                item['title'] ?? '',
                textAlign: TextAlign.center,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: GoogleFonts.ebGaramond(
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 1.0,
                  color: primaryTextColor,
                ),
              ),

              // 4. Centered Image
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 12.0),
                  child: () {
                    // Shared configuration maps identical styling traits to all engines
                    const double imgSize = 140.0;
                    const BoxFit imgFit = BoxFit.contain;

                    if (isNetworkImage) {
                      return Image.network(
                        imagePath,
                        width: imgSize,
                        height: imgSize,
                        fit: imgFit,
                        errorBuilder: (c, e, s) =>
                            const Icon(Icons.image, size: 50),
                      );
                    } else if (isAvif) {
                      return AvifImage.asset(
                        imagePath,
                        width: imgSize,
                        height: imgSize,
                        fit: imgFit,
                        errorBuilder: (c, e, s) =>
                            const Icon(Icons.image, size: 50),
                      );
                    } else {
                      return Image.asset(
                        imagePath,
                        width: imgSize,
                        height: imgSize,
                        fit: imgFit,
                        errorBuilder: (c, e, s) =>
                            const Icon(Icons.image, size: 50),
                      );
                    }
                  }(),
                ),
              ),

              // 5. about
              Text(
                item['description'] ?? '',
                textAlign: TextAlign.center,
                maxLines: 1,
                style: TextStyle(
                  fontSize: 11,
                  fontWeight: FontWeight.w400,
                  color: secondaryTextColor,
                ),
              ),

              const SizedBox(height: 4),

              // 6. Price Display Tag
              Text(
                item['price'] ?? '',
                style: GoogleFonts.ebGaramond(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: primaryTextColor,
                ),
              ),
            ],
          ),
        ),
      ),
    ),
  );
}

class PerfumeShopPage extends StatefulWidget {
  const PerfumeShopPage({super.key});

  @override
  State<PerfumeShopPage> createState() => _PerfumeShopPageState();
}

class _PerfumeShopPageState extends State<PerfumeShopPage> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  String selectedCategory = "All";

  String searchQuery = "";

  final List<String> categories = [
    "All",
    "J'ADORE",
    "DIOR",
    "SHALIMAR",
    "CHANEL",
    "VICTORIA SECRET",
  ];

  @override
  Widget build(BuildContext context) {
    final filteredProducts = allProducts.where((product) {
      final bool matchesCategory =
          selectedCategory == 'All' || product['category'] == selectedCategory;
      final bool matchesSearch = (product['title'] ?? '')
          .toLowerCase()
          .contains(searchQuery.toLowerCase());
      return matchesCategory && matchesSearch;
    }).toList();
    final newArrival = allProducts.where((p) => p['arrival'] == 'new').toList();

    return Scaffold(
      // backgroundColor: Colors.transparent,
      key: _scaffoldKey,
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        leading: IconButton(
          icon: const Icon(Icons.menu),
          onPressed: () {
            _scaffoldKey.currentState?.openDrawer();
          },
        ),
      ),

      body: Stack(
        children: [
          Container(
            width: double.infinity,
            // height: double.infinity,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [Color(0xFFFBF4F4), Color(0xFFF4DFDF)],
              ),
            ),
          ),
          SafeArea(
            child: SingleChildScrollView(
              // physics: const BouncingScrollPhysics(),
              padding: const EdgeInsets.only(bottom: 120.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const SizedBox(height: kToolbarHeight + 20),
                  Padding(
                    padding: EdgeInsets.fromLTRB(24.0, 16.0, 24.0, 8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Featured",
                          style: GoogleFonts.ebGaramond(
                            fontSize: 22,
                            fontWeight: FontWeight.w400,
                            color: const Color(0xFFBC8F8F),
                          ),
                        ),
                        const SizedBox(
                          height: 2,
                        ), // Small gap between the two texts
                        Text(
                          "Categories",
                          style: GoogleFonts.ebGaramond(
                            fontSize: 32,
                            fontWeight: FontWeight.bold,
                            color: const Color(0xFF3A1121),
                          ),
                        ),
                      ],
                    ),
                  ),
                  //for the chip
                  Container(
                    // color: Colors.white,
                    padding: EdgeInsets.symmetric(
                      vertical: 12.0,
                      horizontal: 8.0,
                    ),
                    child: SingleChildScrollView(
                      scrollDirection: Axis.horizontal,

                      child: Row(
                        children: categories.map((category) {
                          final bool isSelected = selectedCategory == category;
                          return Padding(
                            padding: EdgeInsets.symmetric(horizontal: 6.0),
                            child: ChoiceChip(
                              label: Text(category),
                              showCheckmark: false,
                              labelPadding: EdgeInsets.symmetric(
                                horizontal: 5.0,
                                vertical: 0.0,
                              ),
                              selected: isSelected,
                              visualDensity: VisualDensity(
                                horizontal: 0.0,
                                vertical: -4.0,
                              ),
                              backgroundColor: const Color.fromARGB(
                                255,
                                249,
                                231,
                                237,
                              ),
                              selectedColor: Color.fromARGB(255, 249, 231, 237),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(40),
                                side: BorderSide(
                                  color: isSelected
                                      ? Color(0xFF3A1121)
                                      : Colors.grey.shade300,
                                  width: isSelected ? 1.2 : 1.0,
                                ),
                              ),
                              // backgroundColor: Colors.pink[50],
                              labelStyle: TextStyle(
                                // color: isSelected ? Colors.white : Color(0xFF3A1121),
                                fontWeight: isSelected
                                    ? FontWeight.bold
                                    : FontWeight.normal,
                              ),
                              onSelected: (bool newVal) {
                                if (newVal) {
                                  setState(() {
                                    selectedCategory = category;
                                  });
                                }
                              },
                            ),
                          );
                        }).toList(),
                      ),
                    ),
                  ),

                  SizedBox(height: 12),
                  SizedBox(
                    height: 270,
                    width: 65,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      padding: EdgeInsets.symmetric(horizontal: 16.0),
                      itemCount: filteredProducts.length,
                      itemBuilder: (context, index) {
                        return buildProductCard(
                          context,
                          filteredProducts[index],
                          index,
                        );
                      },
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(20.0, 24.0, 24.0, 12.0),
                    child: Text(
                      "New Arrivals",
                      style: GoogleFonts.ebGaramond(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: const Color(0xFF3A1121),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 220,
                    width: 65,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      padding: EdgeInsets.symmetric(horizontal: 16.0),
                      itemCount: newArrival.length,
                      itemBuilder: (context, index) {
                        return buildProductCard(
                          context,
                          newArrival[index],
                          index,
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
          Positioned(
            left: 24,
            right: 24,
            bottom: 16,
            child: SafeArea(
              child: Container(
                height: 64,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(35),
                  boxShadow: [
                    BoxShadow(
                      color: const Color(0xFF3A1121).withOpacity(0.15),
                      blurRadius: 20,
                      offset: const Offset(0, 10),
                    ),
                  ],
                ),
                padding: EdgeInsets.symmetric(horizontal: 16.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      width: MediaQuery.of(context).size.width * 0.45,
                      height: 40,
                      decoration: BoxDecoration(
                        color: const Color(0xFFF5ECEC),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      padding: const EdgeInsets.symmetric(horizontal: 12.0),
                      child: Row(
                        children: [
                          Icon(
                            Icons.search,
                            size: 18,
                            color: Color(0xFF3A1121),
                          ),
                          SizedBox(width: 8),
                          Expanded(
                            child: TextField(
                              onChanged: (value) {
                                setState(() {
                                  searchQuery = value;
                                });
                              },
                              style: TextStyle(
                                color: Color(0xFF3A1121),
                                fontSize: 14,
                              ),
                              decoration: InputDecoration(
                                hintText: "Search",
                                hintStyle: TextStyle(fontSize: 14),
                                border: InputBorder
                                    .none, // Removes default bottom underlines
                                isDense:
                                    true, // Shrinks default vertical height paddings inside box canvas bounds
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Row(
                      children: [
                        IconButton(
                          icon: const Icon(
                            Icons.add_shopping_cart_outlined,
                            color: Color(0xFF3A1121),
                          ),
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => AddToCartPage(),
                              ),
                            );
                          },
                        ),
                        const SizedBox(width: 8),
                        IconButton(
                          icon: const Icon(
                            Icons.person_outline,
                            color: Color(0xFF3A1121),
                          ),
                          onPressed: () {},
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
