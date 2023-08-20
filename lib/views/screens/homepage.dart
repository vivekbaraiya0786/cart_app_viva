import 'dart:async';

import 'package:cart_app_viva/modals/modal.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../attributes.dart';
import '../../helper/dbhelper.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late Future<List<Product>> getAllCategories;

  @override
  void initState() {
    super.initState();
    getAllCategories = DBHelper.dbHelper.fetchALlCategories();
  }

  void startTimers() {
    Timer(const Duration(seconds: 30), () {
      if (!productInCart) {
        setState(() {
          currentProduct.quantity = 0;
        });
        DBHelper.dbHelper.updateCategory(currentProduct);
      }
    });

    Timer(const Duration(seconds: 40), () {
      getAllCategories;
      productInCart = false;

    });
  }

  void addToCart() {
    setState(() {
      productInCart = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          title: const Text("Product"),
          centerTitle: true,
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Get.defaultDialog(
              title: "Product",
              middleText: "Product Add",
              radius: 30,
              content: Container(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Form(
                    key: productFormKey,
                    child: SingleChildScrollView(
                      child: Column(
                        children: [
                          TextFormField(
                            controller: idController,
                            decoration: const InputDecoration(
                              border: OutlineInputBorder(),
                              hintText: "Enter Product id",
                            ),
                            validator: (value) =>
                            (value!.isEmpty) ? "Enter product id" : null,
                            onSaved: (newValue) {
                              id = int.parse(newValue!);
                              print(id);
                            },
                          ),
                          SizedBox(
                            height: Get.width * 0.05,
                          ),
                          TextFormField(
                            controller: nameController,
                            decoration: const InputDecoration(
                              border: OutlineInputBorder(),
                              hintText: "Enter Product Name",
                            ),
                            validator: (value) => (value!.isEmpty)
                                ? "Enter product name first"
                                : null,
                            onSaved: (newValue) {
                              name = newValue;
                              print(name);
                            },
                          ),
                          SizedBox(
                            height: Get.width * 0.05,
                          ),
                          TextFormField(
                            controller: descriptionController,
                            decoration: const InputDecoration(
                              border: OutlineInputBorder(),
                              hintText: "Enter Product description",
                            ),
                            validator: (value) => (value!.isEmpty)
                                ? "Enter product description first"
                                : null,
                            onSaved: (newValue) {
                              description = newValue;
                              print(description);
                            },
                          ),
                          SizedBox(
                            height: Get.width * 0.05,
                          ),
                          TextFormField(
                            controller: priceController,
                            decoration: const InputDecoration(
                              border: OutlineInputBorder(),
                              hintText: "Enter Product price",
                            ),
                            validator: (value) => (value!.isEmpty)
                                ? "Enter product price "
                                : null,
                            onSaved: (newValue) {
                              price = int.parse(newValue!);
                              print(price);
                            },
                          ),
                          SizedBox(
                            height: Get.width * 0.05,
                          ),
                          TextFormField(
                            controller: quantityController,
                            decoration: const InputDecoration(
                              border: OutlineInputBorder(),
                              hintText: "Enter Product quantity",
                            ),
                            validator: (value) => (value!.isEmpty)
                                ? "Enter product quantity"
                                : null,
                            onSaved: (newValue) {
                              quantity = price = int.parse(newValue!);
                              print(quantity);
                            },
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              actions: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    OutlinedButton(
                      onPressed: () async {
                        Get.back();
                        if (productFormKey.currentState!.validate()) {
                          productFormKey.currentState!.save();

                          Product product = Product(
                              name: name!,
                              description: description!,
                              price: price!,
                              quantity: quantity!,
                              id: id!);

                          int res = await DBHelper.dbHelper
                              .insertCategory(data: product);
                          if (res >= 1) {
                            Get.snackbar(
                                "Successfully", "Successfully id $res insert",
                                backgroundColor: Colors.green);
                          } else {
                            Get.snackbar("Unsuccessfully",
                                "Unsuccessfully id $res insert",
                                backgroundColor: Colors.red);
                          }

                          nameController.clear();
                          descriptionController.clear();
                          priceController.clear();
                          quantityController.clear();

                          setState(() {
                            name = null;
                            description = null;
                            price = null;
                            quantity = null;
                          });
                        }
                      },
                      child: const Text("Add"),
                    ),
                    SizedBox(
                      width: Get.width * 0.02,
                    ),
                    OutlinedButton(
                      onPressed: () {
                        Get.back();
                      },
                      child: const Text("Cancel"),
                    ),
                  ],
                ),
              ],
            );
          },
          child: const Icon(Icons.add),
        ),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: FutureBuilder(
            future: getAllCategories,
            builder: (context, snapshot) {
              if (snapshot.hasError) {
                return Center(
                  child: Center(child: Text("ERROR ${snapshot.error}")),
                );
              } else if (snapshot.hasData) {
                List<Product>? data = snapshot.data;
                if (data == null || data.isEmpty) {
                  return const Center(
                    child: Text(
                      "No Data available",
                    ),
                  );
                } else {
                  return ListView.builder(
                    itemBuilder: (context, index) {
                      return Card(
                        child: ListTile(
                          leading: Text(data[index].id.toString(),
                              style: const TextStyle(
                                  fontSize: 20, fontWeight: FontWeight.bold)),
                          title: Text(
                            data[index].name,
                            style: TextStyle(
                              fontSize: 18,
                            ),
                          ),
                          subtitle: Text(
                            productInCart ? 'In Cart' : 'Out of Stock',
                            style: const TextStyle(
                              color: Colors.red,
                            ),
                          ),
                          trailing: Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              IconButton(
                                onPressed: () {
                                  Get.dialog(
                                    AlertDialog(
                                      title: const Center(
                                        child: Text(
                                          "Delete category",
                                        ),
                                      ),
                                      content: const Text(
                                          "Are you sure you want to delete this category?"),
                                      actions: [
                                        OutlinedButton(
                                          onPressed: () async {
                                            int res = await DBHelper.dbHelper
                                                .deleteCategory(
                                              id: data[index].id,
                                            );
                                            if (res == 1) {
                                              setState(() {
                                                getAllCategories = DBHelper
                                                    .dbHelper
                                                    .fetchALlCategories();
                                              });
                                              Get.back();
                                              Get.snackbar(
                                                "Successfully",
                                                "Successfully deleted",
                                                backgroundColor: Colors.green,
                                              );
                                            } else {
                                              Get.back();
                                              Get.snackbar(
                                                snackPosition:
                                                    SnackPosition.BOTTOM,
                                                "Unsuccessfully",
                                                "Failed to delete",
                                                backgroundColor: Colors.red,
                                              );
                                            }
                                          },
                                          child: const Text("Yes"),
                                        ),
                                        OutlinedButton(
                                          onPressed: () {
                                            Get.back();
                                          },
                                          child: const Text("No"),
                                        ),
                                      ],
                                    ),
                                    barrierDismissible: false,
                                  );
                                },
                                icon: const Icon(Icons.delete),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                    itemCount: data.length,
                  );
                }
              }
              return const Center(
                child: CircularProgressIndicator(),
              );
            },
          ),
        ),
      ),
    );
  }
}
