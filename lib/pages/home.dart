import 'package:firebase_ui_auth/firebase_ui_auth.dart';
import 'package:flutter/material.dart';
import '../widgets/weather_widget.dart'; // Import WeatherWidget from its file
import '../database/database.dart';
import '../models/clothes_model.dart';
import 'clothes_page.dart';
import 'generated_outfit_page.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: appBar(),
        body: SingleChildScrollView(
          // Add SingleChildScrollView here
          child: Center(
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: WeatherWidget(),
                ),
                Image.asset('assets/dash.png'),
                Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Align(
                        alignment: Alignment.centerLeft,
                        child: FloatingActionButton.extended(
                          onPressed: () => Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const OutfitPage())),
                          label: const Text('Generate Clothes'),
                          icon: const Icon(Icons.shuffle),
                        ),
                      ),
                      const SignOutButton(),
                    ]),
              ],
            ),
          ),
        ),
        bottomNavigationBar: BottomNavigationBar(
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: 'Home',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.add),
              label: 'Add',
            ),
            // sign out button
            BottomNavigationBarItem(
              icon: Icon(Icons.filter_tilt_shift_sharp),
              label: 'Clothes',
            ),
          ],
          selectedItemColor: const Color.fromARGB(255, 30, 187, 231),
          onTap: (int index) {
            if (index == 1) {
              showModal(context);
            } else if (index == 2) {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => const ClothesPage()));
            } else if (index == 0) {
              Navigator.pushNamed(context, '/');
            }
          },
        ));
  }

  AppBar appBar() {
    return AppBar(
      title: const Text('Welcome to DECK!'),
      centerTitle: true,
      titleTextStyle: const TextStyle(
        color: Colors.white,
        fontSize: 24,
        fontFamily: 'Itim',
      ),
      backgroundColor: const Color.fromARGB(255, 30, 187, 231),
      elevation: 0.0,
    );
  }

  void showModal(BuildContext context) {
    int? selectedValue = 1;
    List<String> clothTypes = ['Tops', 'Bottoms', 'Shoes', 'Outerwear'];
    List<int> warmthLevels = [1, 2, 3];
    List<String> colors = ['black', 'white', 'red', 'blue', 'green', 'yellow', 'pink', 'grey']; // Add more colors if needed
    String? selectedColor = colors.first;
    String? selectedType = clothTypes.first;
    String? name = '';

    showDialog<void>(
      context: context,
      builder: (BuildContext context) => AlertDialog(
        title: const Text('Add New Clothes'), // Optional title for clarity
        content: SingleChildScrollView(
          // Wrap the content with SingleChildScrollView
          child: Column(
            mainAxisSize:
                MainAxisSize.min, // Allow content to grow within constraints
            crossAxisAlignment: CrossAxisAlignment.start, // Align text to left

            children: <Widget>[
              const Text(
                  'Enter Clothing Name'), // Clear label for the input field
              TextFormField(
                decoration: const InputDecoration(
                  labelText: 'Name',
                ),
                onChanged: (newValue) => setState(() => name = newValue),
              ),
              const SizedBox(height: 12),

              const Text(
                  'Enter Clothing type'), // Clear label for the input field
              DropdownMenu<String>(
                initialSelection: selectedType,
                // set the height lower
                onSelected: (newValue) =>
                    setState(() => selectedType = newValue),
                dropdownMenuEntries: clothTypes
                    .map((type) => DropdownMenuEntry(value: type, label: type))
                    .toList(),
              ),

              // space it out
              const SizedBox(height: 12),
              const Text('Warmth level'),
              DropdownMenu<int>(
                initialSelection: selectedValue,
                onSelected: (newValue) =>
                    setState(() => selectedValue = newValue),
                dropdownMenuEntries: warmthLevels
                    .map((level) => DropdownMenuEntry(
                        value: level, label: level.toString()))
                    .toList(),
              ),
              
              const SizedBox(height: 12),
              const Text('Color'),
              DropdownMenu<String>(
                initialSelection: selectedColor,
                onSelected: (newValue) =>
                    setState(() => selectedColor = newValue),
                dropdownMenuEntries: colors
                    .map((color) => DropdownMenuEntry(
                        value: color, label: color))
                    .toList(),
              ),
            ],
          ),
        ),
        actions: <TextButton>[
          TextButton(
            onPressed: () {
              // Handle validation, input processing, and closing the modal as needed
              print(selectedValue);
              print(selectedType);
              print(name);
              String nonNullableName = name ?? "Clothes Name";
              int nonNullableSelectedValue = selectedValue ?? 1;
              Clothes clothes = Clothes(
                  name: nonNullableName,
                  color: selectedColor ?? 'black',
                  warmthLevel: nonNullableSelectedValue,
                  type: selectedType ?? 'Tops');
              SQLHelper.createItem(clothes);

              Navigator.pop(context);
            },
            child: const Text('Save'), // Clearer action text
          ),
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
        ],
      ),
    );
  }
}
