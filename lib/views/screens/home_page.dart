import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../helper/dbhelper.dart';
import '../../models/product_models.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late Future<void> _initFuture;
  late Timer _stockOutTimer;
  late Timer _resetQuantityTimer;

  @override
  void initState() {
    super.initState();
    _initFuture = initAndFetchData();
    startTimers();
  }

  @override
  void dispose() {
    _stockOutTimer.cancel();
    _resetQuantityTimer.cancel();
    super.dispose();
  }

  Future<void> initAndFetchData() async {
    await DBHelper.dbHelper.initDB();
    await DBHelper.dbHelper.loadString(path: "assets/json/product_data.json");
    await DBHelper.dbHelper.insertBulkRecord();
    await DBHelper.dbHelper.fetchData();
  }

  void startTimers() {

    _stockOutTimer = Timer.periodic(const Duration(seconds: 30), (timer) {
      DBHelper.dbHelper.stockManage();
      setState(() {});
    });

    _resetQuantityTimer = Timer.periodic(const Duration(seconds: 40), (timer) {
      DBHelper.dbHelper.resetQuantity();
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: const Icon(Icons.menu),
        actions: [
          IconButton(onPressed: () {}, icon: const Icon(Icons.shopping_cart_outlined)),
        ],
        title: Text(
          "Product-App",
          style: GoogleFonts.poppins(),
        ),
        centerTitle: true,
        backgroundColor: Colors.red.shade600,
        foregroundColor: Colors.white,
      ),
      body: FutureBuilder(
        future: _initFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return const Center(child: Text('Error loading data'));
          } else {
            return ProductListView();
          }
        },
      ),
    );
  }
}

class ProductListView extends StatefulWidget {

   ProductListView({super.key});

  @override
  State<ProductListView> createState() => _ProductListViewState();
}

class _ProductListViewState extends State<ProductListView> {
  final DBHelper dbHelper = DBHelper.dbHelper;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        left: Get.width * 0.05,
        right: Get.width * 0.05,
        top: Get.height * 0.03,
      ),
      child: GridView.builder(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 20,
          mainAxisSpacing: 20,
          mainAxisExtent: 350,
        ),
        itemCount: dbHelper.productList.length,
        itemBuilder: (context, index) {
          Product product = dbHelper.productList[index];
          return Column(
            children: [
              Expanded(
                flex: 2,
                child: Container(
                  height: Get.height * 0.2,
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(Get.width * 0.02),
                    image: DecorationImage(
                      fit: BoxFit.fill,
                      image: MemoryImage(
                        base64Decode(product.image!),
                      ),
                    ),
                  ),
                  child:   (index == dbHelper.randomNumber)
                      ? Align(
                    alignment: Alignment.topRight,
                    child: Text(
                      "Stock Out in ${dbHelper.countDown}s",
                      style: GoogleFonts.poppins(
                        color: Colors.black,
                        fontWeight: FontWeight.w700,
                        fontSize: Get.width * 0.04,
                      ),
                    ),
                  )
                      : Container(),
                ),
              ),
              Expanded(
                child: Column(
                  children: [
                    Text(
                      "${product.name}",
                    ),
                    Text(
                      "Quantity: ${product.quantity} pcs.",
                    ),
                    SizedBox(
                      height: Get.height * 0.01,
                    ),
                    if (product.quantity != 0)
                      InkWell(
                        onTap: () {
                          if (dbHelper.randomNumber == index &&
                              dbHelper.countDown >= 20) {
                            dbHelper.isAddToCart = true;
                          }
                          dbHelper.addToCart(product: product);
                        },
                        borderRadius: BorderRadius.circular(Get.width * 0.02),
                        child: Container(
                          alignment: Alignment.center,
                          padding: EdgeInsets.symmetric(
                            horizontal: Get.width * 0.05,
                            vertical: Get.height * 0.02,
                          ),
                          decoration: BoxDecoration(
                            color: Colors.red.shade400,
                            borderRadius: BorderRadius.circular(Get.width * 0.02),
                          ),
                          child: const Text(
                            "Add To Cart",
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                      ),
                  ],
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
