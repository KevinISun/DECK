import 'package:deck_project/models/clothes_model.dart';
import 'package:flutter/material.dart';

class ClothesWidget extends StatelessWidget {
  final Clothes clothes;
  final VoidCallback onTap;
  final VoidCallback onLongPress;
  const ClothesWidget({
    Key? key,
    required this.clothes,
    required this.onTap,
    required this.onLongPress,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onLongPress: onLongPress,
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 6),
        child: Card(
          elevation: 2,
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // insert an shirt icon
                const Icon(Icons.shopping_basket_sharp, size: 40),
                Text(
                  clothes.name,
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  clothes.color,
                  style: const TextStyle(
                    fontSize: 16,
                    color: Colors.grey,
                  ),
                ),
              ],
            ),
          )
        )
      ),
      
    );
  }
}

