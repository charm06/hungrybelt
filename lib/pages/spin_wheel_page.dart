import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_fortune_wheel/flutter_fortune_wheel.dart';
import 'package:hungrybelt/components/inputfield.dart';
import 'package:rxdart/rxdart.dart';

class SpinWheelPage extends StatefulWidget {
  const SpinWheelPage({super.key});

  @override
  State<SpinWheelPage> createState() => _SpinWheelPageState();
}

class _SpinWheelPageState extends State<SpinWheelPage> {
  List<String> items = [];
  final TextEditingController itemController = TextEditingController();
  final selected = BehaviorSubject<int>();

  @override
  void dispose() {
    selected.close();
    itemController.dispose();
    super.dispose();
  }

  // wheel
  void _spinWheel() {
    if (items.length > 1) {
      final randomIndex = Random().nextInt(items.length);
      selected.add(randomIndex);

      // Show the selected item in a dialog after spinning
      Future.delayed(const Duration(seconds: 5), () {
        _showSelectedItemDialog(items[randomIndex], randomIndex);
      });
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Add at least two items to spin')),
      );
    }
  }

  void _showSelectedItemDialog(String selectedItem, int index) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          contentPadding: const EdgeInsets.all(20.0), // Add padding for better appearance
          title:
          const Center(
            child: Text(
              'Selected Item',
              style: TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.bold,
                color: Color(0xFF0D1282), // Match the color scheme
              ),
            ),
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              /*const Divider(
                color: Color(0xFF0D1282), // Use the same blue shade for the divider
                thickness: 1,
              ),*/
              const SizedBox(height: 10),
              Center(
                child: Text(
                  selectedItem,
                  style: const TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF0D1282), // Match the color scheme
                  ),
                ),
              ),
              const SizedBox(height: 20)
            ],
          ),
          actions: [
            Center(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  TextButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    style: TextButton.styleFrom(
                      foregroundColor: const Color(0xFFF0DE36), // Yellow text
                      backgroundColor: const Color(0xFF0D1282), // Blue background
                    ),
                    child: const Text('Close'),
                  ),
                  const SizedBox(width: 10),
                  TextButton(
                    onPressed: () {
                      setState(() {
                        items.removeAt(index);
                      });
                      Navigator.of(context).pop();
                    },
                    style: TextButton.styleFrom(
                      foregroundColor: const Color(0xFFF0DE36), // Yellow text
                      backgroundColor: const Color(0xFF0D1282), // Blue background
                    ),
                    child: const Text('Remove Item'),
                  ),
                ],
              ),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: SizedBox(
          height: 200.0, 
          child: Image.asset('assets/images/uSpin_title.png'),
        ),
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  height: 300,
                  child: items.length > 1
                      ? FortuneWheel(
                    selected: selected.stream,
                    animateFirst: false,
                    items: [
                      for (var item in items)
                        FortuneItem(
                          child: Text(item),
                          style: FortuneItemStyle(
                            color: Colors.blue[700]!,
                          ),
                        )
                    ],
                  )
                      : const Center(child: Text("Add at least two items")),
                ),
                const SizedBox(height: 20.0),

                // spin button
                ElevatedButton(
                  onPressed: _spinWheel,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF0D1282),
                    fixedSize: const Size(120, 40),
                    elevation: 3,
                  ),
                  child: const Text(
                    'Spin',
                    style: TextStyle(
                      color: Color(0xFFF0DE36),
                      fontSize: 14,
                    ),
                  ),
                ),
                const SizedBox(height: 40.0),

                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Expanded(
                      child: InputField(
                        hintText: "Enter Item",
                        controller : itemController,
                      ),
                    ),

                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xFF0D1282),
                            elevation: 3,
                          ),
                          onPressed: () {
                            setState(() {
                              if (itemController.text.isNotEmpty) {
                                items.add(itemController.text);
                                itemController.clear();
                              }
                            });
                          },
                          child: const Text(
                            'Add Item',
                            style: TextStyle(
                              color: Color(0xFFF0DE36),
                              fontSize: 14,
                            ),
                          ),
                        ),
                        const SizedBox(height: 15.0),
                        // remove item button
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xFF0D1282),
                            elevation: 3,
                          ),
                          onPressed: () {
                            if (items.isNotEmpty) {
                              setState(() {
                                items.removeLast();
                              });
                            }
                          },
                          child: const Text(
                            'Remove Item',
                            style: TextStyle(
                              color: Color(0xFFF0DE36),
                              fontSize: 14,
                            ),
                          ),
                        ),
                      ],
                    )
                  ],
                ),
                const SizedBox(height: 20.0),
              ],
            ),
          ),
        ),
      ),
    );
  }
}