String calculate(String expression) {
  List<String> tokens = tokenize(expression);
  List<String> postfix = infixToPostfix(tokens);
  String result = evaluatePostfix(postfix).toString();
  if (result.endsWith('.0')) {
    result = result.replaceAll('.0', '');
  }

  return result.toString();
}

// Tokenizer: splits numbers and operators
List<String> tokenize(String expression) {
  final pattern = RegExp(r'(\d+\.?\d*|\+|\-|\x|\/|%)');
  return pattern.allMatches(expression).map((m) => m.group(0)!).toList();
}

// Precedence rules
int precedence(String op) {
  if (op == '+' || op == '-') return 1;
  if (op == 'x' || op == '/' || op == '%') return 2;
  return 0;
}

// Convert infix to postfix (Shunting Yard algorithm)
List<String> infixToPostfix(List<String> tokens) {
  List<String> output = [];
  Stack<String> operators = Stack<String>();

  for (String token in tokens) {
    if (double.tryParse(token) != null) {
      output.add(token);
    } else {
      while (!operators.isEmpty &&
          precedence(operators.top) >= precedence(token)) {
        output.add(operators.pop());
      }
      operators.push(token);
    }
  }

  while (!operators.isEmpty) {
    output.add(operators.pop());
  }

  return output;
}

// Evaluate postfix expression
double evaluatePostfix(List<String> tokens) {
  Stack<double> stack = Stack<double>();

  for (String token in tokens) {
    if (double.tryParse(token) != null) {
      stack.push(double.parse(token));
    } else {
      double b = stack.pop();
      double a = stack.pop();

      switch (token) {
        case '+':
          stack.push(a + b);
          break;
        case '-':
          stack.push(a - b);
          break;
        case 'x':
          stack.push(a * b);
          break;
        case '/':
          if (b == 0) throw Exception('Division by zero');
          stack.push(a / b);
          break;
        case '%':
          stack.push(a % b);
          break;
      }
    }
  }

  return stack.pop();
}

// Stack class
class Stack<T> {
  final List<T> _list = [];

  void push(T value) => _list.add(value);

  T pop() => _list.removeLast();

  T get top => _list.last;

  bool get isEmpty => _list.isEmpty;
}
