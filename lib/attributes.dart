import 'package:flutter/material.dart';
import 'modals/modal.dart';

TextEditingController idController = TextEditingController();
TextEditingController nameController = TextEditingController();
TextEditingController descriptionController = TextEditingController();
TextEditingController priceController = TextEditingController();
TextEditingController quantityController = TextEditingController();

final GlobalKey<FormState> productFormKey = GlobalKey<FormState>();

int? id;
String? name;
String? description;
int? price;
int? quantity;

late Product currentProduct;
bool productInCart = false;