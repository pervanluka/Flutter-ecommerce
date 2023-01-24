// ignore_for_file: avoid_print

import 'dart:io';

import 'package:ecommerce/apps/providers.dart';
import 'package:ecommerce/models/product_model.dart';
import 'package:ecommerce/utils/snackbars.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';

final addImageProvider = StateProvider<XFile?>((_) => null);

class AdminAddProductPage extends ConsumerStatefulWidget {
  const AdminAddProductPage({Key? key}) : super(key: key);

  @override
  ConsumerState<AdminAddProductPage> createState() =>
      _AdminAddProductPageState();
}

class _AdminAddProductPageState extends ConsumerState<AdminAddProductPage> {
  TextEditingController titleTextEditingController = TextEditingController();
  TextEditingController descriptionEditingController = TextEditingController();
  TextEditingController priceEditingController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    _addProduct() async {
      final storage = ref.watch(databaseProvider);
      final fileStorage = ref.watch(storageProvider); // reference file storage
      final imageFile =
          ref.watch(addImageProvider.state).state; // reference the image file

      if (storage == null || fileStorage == null || imageFile == null) {
        print("Error storage,fileStorage or imageFile is null");
        return;
      }

      final imageUrl = await fileStorage.uploadFile(imageFile.path);

      await storage.addProduct(Product(
          name: titleTextEditingController.text,
          description: descriptionEditingController.text,
          price: double.parse(priceEditingController.text),
          imageUrl: imageUrl));

      // ignore: use_build_context_synchronously
      openIconSnackBar(context, "Product added successfully",
          const Icon(Icons.check, color: Colors.green));
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text("Add Product"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(15),
        child: Column(
          children: [
            CustomInputFieldFb1(
              inputController: titleTextEditingController,
              hintText: "Product Name",
              labelText: "Product Name",
            ),
            const SizedBox(
              height: 15,
            ),
            CustomInputFieldFb1(
              inputController: descriptionEditingController,
              hintText: "Product Description",
              labelText: "Product Description",
            ),
            const SizedBox(
              height: 15,
            ),
            CustomInputFieldFb1(
              inputController: priceEditingController,
              hintText: "Price",
              labelText: "Price",
            ),
            const SizedBox(
              height: 15,
            ),
            Consumer(builder: (context, watch, child) {
              final image = ref.watch(addImageProvider);
              return image == null
                  ? const Text("No image selected")
                  : Image.file(
                      File(image.path),
                      height: 200,
                    );
            }),
            ElevatedButton(
                onPressed: () async {
                  final image = await ImagePicker()
                      .pickImage(source: ImageSource.gallery);
                  if (image != null) {
                    ref.watch(addImageProvider.state).state = image;
                  }
                },
                child: const Text("Upload Image")),
            ElevatedButton(
                onPressed: (() {
                  _addProduct();
                  Navigator.pop(context);
                }),
                child: const Text("Add Product"))
          ],
        ),
      ),
    );
  }
}

class CustomInputFieldFb1 extends StatelessWidget {
  final TextEditingController inputController;
  final String hintText;
  final Color primaryColor;
  final String labelText;

  const CustomInputFieldFb1(
      {Key? key,
      required this.inputController,
      required this.hintText,
      required this.labelText,
      this.primaryColor = Colors.indigo})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      decoration: BoxDecoration(boxShadow: [
        BoxShadow(
            offset: const Offset(12, 26),
            blurRadius: 50,
            spreadRadius: 0,
            color: Colors.grey.withOpacity(.1)),
      ]),
      child: TextField(
        controller: inputController,
        onChanged: (value) {
          //Do something wi
        },
        autofocus: true,
        keyboardType: TextInputType.emailAddress,
        style: const TextStyle(fontSize: 16, color: Colors.black),
        decoration: InputDecoration(
          labelText: labelText,
          floatingLabelBehavior: FloatingLabelBehavior.always,
          filled: true,
          hintText: hintText,
          hintStyle: TextStyle(color: Colors.grey.withOpacity(.75)),
          fillColor: Colors.transparent,
          contentPadding:
              const EdgeInsets.symmetric(vertical: 0.0, horizontal: 0.0),
          border: UnderlineInputBorder(
            borderSide:
                BorderSide(color: primaryColor.withOpacity(.1), width: 2.0),
          ),
          focusedBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: primaryColor, width: 2.0),
          ),
          errorBorder: const UnderlineInputBorder(
            borderSide: BorderSide(color: Colors.red, width: 2.0),
          ),
          enabledBorder: UnderlineInputBorder(
            borderSide:
                BorderSide(color: primaryColor.withOpacity(.1), width: 2.0),
          ),
        ),
      ),
    );
  }
}
