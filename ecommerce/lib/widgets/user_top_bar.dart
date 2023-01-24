import 'package:ecommerce/apps/pages/user/user_bag.dart';
import 'package:flutter/material.dart';

class UserTopBar extends StatelessWidget {
  final IconButton leadingIconButton;
  const UserTopBar({Key? key, required this.leadingIconButton})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        leadingIconButton,
        const Spacer(),
        IconButton(onPressed: () {}, icon: const Icon(Icons.menu)),
        IconButton(
            onPressed: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => const UserBag()));
            },
            icon: const Icon(Icons.shopping_bag))
      ],
    );
  }
}
