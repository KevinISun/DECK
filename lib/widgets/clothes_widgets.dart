import 'package:deck_project/models/clothes_model.dart';
import 'package:flutter/material.dart';

class ClothesWidget extends StatelessWidget {
  final Clothes clothes;
  final VoidCallback onTap;
  final VoidCallback onLongPress;
  final VoidCallback onButtonPressed;
  const ClothesWidget({
    Key? key,
    required this.clothes,
    required this.onTap,
    required this.onLongPress,
    required this.onButtonPressed,
  }) : super(key: key);

  String _getClothesIcon(Clothes clothes) {
    switch(clothes.type) {
      case "Tops":
        return 'assets/tshirt.png';
      case "Bottoms":
        return 'assets/pants.png';
      case "Outerwear":
        return 'assets/outerwear.png';
      case "Shoes":
        return 'assets/shoes.png';
    }
    return 'assets/tshirt.png';
  }
  Color _getBackgroundColor(Clothes clothes){
    // return colors
    switch(clothes.color){
      case "red":
        return Colors.red;
      case "blue":
        return Colors.blue;
      case "green":
        return Colors.green;
      case "yellow":
        return Colors.yellow;
      case "black":
        return Colors.black;
      case "white":
        return Colors.white;
      case "grey":
        return Colors.grey;
      case "orange":
        return Colors.orange;
      case "purple":
        return Colors.purple;
      case "pink":
        return Colors.pink;
      default:
        return Colors.white;
    }
      
  }

  @override
  Widget build(BuildContext context) {
   
    return InkWell(
      onLongPress: onLongPress,
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 6),
        child: Card(
          elevation: 2,
          color: _getBackgroundColor(clothes),
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded( // Expand the image
                  child: Image.asset(
                    _getClothesIcon(clothes),
                    height: 150,
                    width: 150,
                  ),
                ),
                SizedBox(width: 16),
                Expanded( // Expand the column containing text
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        clothes.name,
                        style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Color.fromARGB(255, 68, 70, 71),
                         
                        ),
                      ),
                      Text(
                        clothes.warmthLevel.toString(),
                        style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 10),
                      ElevatedButton(
                        onPressed: () {
                          onButtonPressed();
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color.fromARGB(255, 243, 135, 127),
                        ),
                        child: const Text('Delete'),
                      ),
                      Text(
                        clothes.color,
                        style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ],
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