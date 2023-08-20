// void startTimers() {
//   Timer(const Duration(seconds: 30), () {
//     if (!productInCart) {
//       setState(() {
//         currentProduct.quantity = 0;
//       });
//       DBHelper.dbHelper.updateCategory(currentProduct);
//     }
//   });

//   Timer(const Duration(seconds: 40), () {
//     getAllCategories;
//     productInCart = false;
//   });
// }

// void addToCart() {
//   setState(() {
//     productInCart = true;
//     Get.defaultDialog(
//       title: "Product",
//       middleText: "Product Add",
//       radius: 30,
//       content: Container(
//         child: Padding(
//           padding: const EdgeInsets.all(8.0),
//           child: Form(
//             key: productFormKey,
//             child: SingleChildScrollView(
//               child: Column(
//                 children: [
//                   TextFormField(
//                     controller: idController,
//                     decoration: const InputDecoration(
//                       border: OutlineInputBorder(),
//                       hintText: "Enter Product id",
//                     ),
//                     validator: (value) => (value!.isEmpty)
//                         ? "Enter product id"
//                         : null,
//                     onSaved: (newValue) {
//                       id = int.parse(newValue!);
//                       print(id);
//                     },
//                   ),
//                   SizedBox(
//                     height: Get.width * 0.05,
//                   ),
//                   TextFormField(
//                     controller: nameController,
//                     decoration: const InputDecoration(
//                       border: OutlineInputBorder(),
//                       hintText: "Enter Product Name",
//                     ),
//                     validator: (value) => (value!.isEmpty)
//                         ? "Enter product name first"
//                         : null,
//                     onSaved: (newValue) {
//                       name = newValue;
//                       print(name);
//                     },
//                   ),
//                   SizedBox(
//                     height: Get.width * 0.05,
//                   ),
//                   TextFormField(
//                     controller: descriptionController,
//                     decoration: const InputDecoration(
//                       border: OutlineInputBorder(),
//                       hintText: "Enter Product description",
//                     ),
//                     validator: (value) => (value!.isEmpty)
//                         ? "Enter product description first"
//                         : null,
//                     onSaved: (newValue) {
//                       description = newValue;
//                       print(description);
//                     },
//                   ),
//                   SizedBox(
//                     height: Get.width * 0.05,
//                   ),
//                   TextFormField(
//                     controller: priceController,
//                     decoration: const InputDecoration(
//                       border: OutlineInputBorder(),
//                       hintText: "Enter Product price",
//                     ),
//                     validator: (value) => (value!.isEmpty)
//                         ? "Enter product price "
//                         : null,
//                     onSaved: (newValue) {
//                       price = int.parse(newValue!);
//                       print(price);
//                     },
//                   ),
//                   SizedBox(
//                     height: Get.width * 0.05,
//                   ),
//                   TextFormField(
//                     controller: quantityController,
//                     decoration: const InputDecoration(
//                       border: OutlineInputBorder(),
//                       hintText: "Enter Product quantity",
//                     ),
//                     validator: (value) => (value!.isEmpty)
//                         ? "Enter product quantity"
//                         : null,
//                     onSaved: (newValue) {
//                       quantity = price = int.parse(newValue!);
//                       print(quantity);
//                     },
//                   ),
//                 ],
//               ),
//             ),
//           ),
//         ),
//       ),
//       actions: [
//         Row(
//           mainAxisAlignment: MainAxisAlignment.end,
//           children: [
//             OutlinedButton(
//               onPressed: () async {
//                 Get.back();
//                 if(productFormKey.currentState!.validate()){
//                   productFormKey.currentState!.save();
//
//                   Product product = Product(name: name!,description: description!,price: price!,quantity: quantity!,id:id!);
//
//                   int res =
//                   await DBHelper.dbHelper.insertCategory(data: product);
//                   if (res >= 1) {
//                     Get.snackbar("Successfully", "Successfully id $res insert",
//                         backgroundColor: Colors.green);
//                   } else {
//                     Get.snackbar(
//                         "Unsuccessfully", "Unsuccessfully id $res insert",
//                         backgroundColor: Colors.red);
//                   }
//
//                   nameController.clear();
//                   descriptionController.clear();
//                   priceController.clear();
//                   quantityController.clear();
//
//                   setState(() {
//                     name = null;
//                     description = null;
//                     price = null;
//                     quantity = null;
//                   });
//                 }
//               },
//               child: const Text("Add"),
//             ),
//             SizedBox(
//               width: Get.width * 0.02,
//             ),
//             OutlinedButton(
//               onPressed: () {
//                 Get.back();
//               },
//               child: const Text("Cancel"),
//             ),
//           ],
//         ),
//       ],
//     );
//   });
// }









