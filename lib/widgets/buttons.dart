import 'package:flutter/material.dart';

class Buttons extends StatelessWidget {
  Buttons({super.key, required this.onButtonPress});

  final Function onButtonPress;

  final Color _btnColor = Color.fromARGB(255, 39, 35, 35);
  final Color _operatorColor = Colors.deepPurpleAccent;

  final List<String> buttons = [
    'AC',
    'CP',
    '%',
    '/',
    '7',
    '8',
    '9',
    'x',
    '4',
    '5',
    '6',
    '-',
    '1',
    '2',
    '3',
    '+',
    '.',
    '0',
    '⌫',
    '=',
  ];

  bool isOperator(String label) =>
      ['/', 'x', '-', '+', '=', '%', 'CP', 'AC'].contains(label);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(15.0),
      child: GridView.count(
        crossAxisCount: 4,
        mainAxisSpacing: 20,
        crossAxisSpacing: 15,
        childAspectRatio: 1,
        children: buttons.map((label) {
          return ElevatedButton(
            onPressed: () => onButtonPress(label),
            style: ElevatedButton.styleFrom(
              backgroundColor: isOperator(label) ? _operatorColor : _btnColor,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30),
              ),
              padding: EdgeInsets.zero,
            ),
            child: Text(
              label,
              style: const TextStyle(fontSize: 24, color: Colors.white),
            ),
          );
        }).toList(),
      ),
    );
  }
}
