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

  // String _getClothesIcon(Clothes clothes) {
  //   switch(clothes.type) {
  //     case "Tops":
  //       return 'assets/tshirt.png';
  //     case "Bottoms":
  //       return 'assets/pants.png';
  //     case "Outerwear":
  //       return 'assets/outerwear.png';
  //     case "Shoes":
  //       return 'assets/shoes.png';
  //   }
  //   return 'assets/tshirt.png';
  // }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onLongPress: onLongPress,
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 6),
        child: Card(
          elevation: 2,
          color: const Color.fromARGB(255, 30, 187, 231), // Set the color to blue
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                // insert a shirt icon
                const Icon(Icons.shopping_basket_sharp, size: 60),
                Text(
                  clothes.name,
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 10),
                Align(
                  alignment: Alignment.bottomLeft,
                  child: Text(
                    clothes.color,
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

