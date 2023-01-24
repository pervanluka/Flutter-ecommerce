import 'package:ecommerce/apps/providers.dart';
import 'package:ecommerce/widgets/product_banner.dart';
import 'package:ecommerce/widgets/product_display.dart';
import 'package:ecommerce/widgets/user_top_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class UserHome extends ConsumerWidget {
  const UserHome({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, ref) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              UserTopBar(
                  leadingIconButton: IconButton(
                icon: const Icon(Icons.logout_outlined),
                onPressed: () {
                  ref.read(firebaseAuthProvider).signOut();
                },
              )),
              const SizedBox(
                height: 20,
              ),
              const ProductBanner(),
              const SizedBox(
                height: 20,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const [
                  Text(
                    "Products",
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  Text("View all of our products", style: TextStyle(fontSize: 12))
                ],
              ),
              const Flexible(child: ProductsDisplay())
            ],
          ),
        ),
      ),
    );
  }
}
