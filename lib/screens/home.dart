import 'package:calculator/calculation.dart';
import 'package:calculator/widgets/buttons.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  String input = "";
  String expression = "0";
  String result = "0";

  bool firstCalculation = false;

  void _onButtonPress(String label) {
    if (['/', 'x', '-', '+', '=', '%', '⌫', 'CP'].contains(label) &&
        expression == '0' &&
        result == '0') {
      return;
    }

    switch (label) {
      case '=':
        setState(() {
          print(expression);
          result = calculate(expression);

          if (result != '0') {
            firstCalculation = true;
          }
        });
        return;

      case 'CP':
        Clipboard.setData(ClipboardData(text: result));
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text('Copied to Clipboard')));
        return;

      case 'AC':
        setState(() {
          expression = '0';
          result = '0';
          firstCalculation = false;
        });
        return;

      case '⌫':
        if (expression != '0') {
          final newExpression = expression.length > 1
              ? expression.substring(0, expression.length - 1)
              : '0';

          setState(() {
            expression = newExpression;
          });
        }
        return;
    }

    bool isOperator(String s) => ['+', '-', 'x', '/', '%'].contains(s);
    String newExpression;

    if (expression == '0' && result == '0') {
      newExpression = label;
    } else if (result != '0') {
      if (isOperator(label)) {
        newExpression = result + label;
        firstCalculation = false;
      } else {
        newExpression = label;
      }

      setState(() {
        result = '0';
      });
    } else {
      newExpression = expression + label;
    }

    setState(() {
      expression = newExpression;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Column(
        children: [
          Expanded(
            flex: 3,
            child: Container(
              alignment: Alignment.bottomRight,
              padding: const EdgeInsets.all(20),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    expression,
                    style: const TextStyle(
                      color: Colors.white70,
                      fontSize: 24,
                      fontStyle: FontStyle.italic,
                    ),
                  ),
                  Text(
                    firstCalculation ? result : expression,
                    style: const TextStyle(color: Colors.white, fontSize: 60),
                  ),
                ],
              ),
            ),
          ),
          Expanded(flex: 5, child: Buttons(onButtonPress: _onButtonPress)),
        ],
      ),
    );
  }
}
