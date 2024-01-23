import 'package:flutter/material.dart';

void main() {
  runApp(CalculatorApp());
}

class CalculatorApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Calculator(),
    );
  }
}

class Calculator extends StatefulWidget {
  @override
  _CalculatorState createState() => _CalculatorState();
}

class _CalculatorState extends State<Calculator> {
  String _output = '0';
  String _currentInput = '';
  String _expression = '';
  String _operation = '';
  bool _isOperatorClicked = false;

  void _onNumberClick(String buttonText) {
    setState(() {
      if (_isOperatorClicked) {
        _currentInput = '';
        _isOperatorClicked = false;
      }

      if (_currentInput.length < 12) {
        if (buttonText == '.') {
          if (!_currentInput.contains('.')) {
            _currentInput += buttonText;
          }
        } else {
          _currentInput += buttonText;
        }

        _expression += buttonText;
      }
    });
  }

  void _onOperationClick(String buttonText) {
    setState(() {
      if (_currentInput.isNotEmpty) {
        if (_operation.isNotEmpty) {
          _calculateResult();
        } else {
          _output = _expression;
        }
      }

      _operation = buttonText;
      _isOperatorClicked = true;
      _expression += buttonText;
    });
  }

  void _onEqualClick() {
    setState(() {
      _calculateResult();
      _expression += '= $_output';
      _currentInput = _output;
      _operation = '';
    });
  }

  void _onClearClick() {
    setState(() {
      _currentInput = '';
      _output = '0';
      _expression = '';
      _operation = '';
    });
  }

  void _calculateResult() {
    double inputValue = double.parse(_currentInput);

    switch (_operation) {
      case '+':
        _output =
            (double.parse(_output.isNotEmpty ? _output : '0') + inputValue)
                .toString();
        break;
      case '-':
        _output =
            (double.parse(_output.isNotEmpty ? _output : '0') - inputValue)
                .toString();
        break;
      case '×':
        _output =
            (double.parse(_output.isNotEmpty ? _output : '1.0') * inputValue)
                .toString();
        break;
      case '÷':
        if (inputValue != 0) {
          _output =
              (double.parse(_output.isNotEmpty ? _output : '0.0') / inputValue)
                  .toString();
        } else {
          _output = 'Error';
          return;
        }
        break;
    }
    if (_output.contains('.') &&
        double.parse(_output) == double.parse(_output.split('.')[0])) {
      _output = _output.split('.')[0];
    }
  }

  Widget _buildButton(String buttonText, {Color? bgColor, Color? textColor}) {
    return Expanded(
      child: Container(
        margin: EdgeInsets.all(8.0),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16.0),
          color: bgColor ?? Colors.grey[300],
        ),
        child: ElevatedButton(
          onPressed: () {
            if (buttonText == 'C') {
              _onClearClick();
            } else if (buttonText == '=') {
              _onEqualClick();
            } else if ('0123456789.'.contains(buttonText)) {
              _onNumberClick(buttonText);
            } else {
              _onOperationClick(buttonText);
            }
          },
          child: Text(
            buttonText,
            style: TextStyle(
              fontSize: 24.0,
              fontWeight: FontWeight.bold,
              color: textColor ?? Colors.black,
            ),
          ),
          style: ElevatedButton.styleFrom(
            primary: Colors.transparent,
            padding: EdgeInsets.all(20.0),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16.0),
              side: BorderSide(color: Colors.black26),
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: null,
        elevation: 0,
        backgroundColor: Colors.grey[900], // Set app bar background color
        flexibleSpace: Container(
          alignment: Alignment.center,
          padding: EdgeInsets.only(top: 50.0),
          child: Text(
            'Calculator',
            style: TextStyle(
              fontSize: 36.0,
              fontWeight: FontWeight.bold,
              color: Colors.white,
              letterSpacing: 2.0,
            ),
          ),
        ),
      ),
      backgroundColor: Colors.grey[900],
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.all(16.0),
              alignment: Alignment.bottomRight,
              child: Text(
                _expression.isEmpty ? '0' : _expression,
                style: TextStyle(
                    fontSize: 20.0,
                    fontWeight: FontWeight.bold,
                    color: Colors.white),
              ),
            ),
            Container(
              padding: EdgeInsets.all(16.0),
              alignment: Alignment.bottomRight,
              child: Text(
                _output.isEmpty ? '0' : _output,
                style: TextStyle(
                    fontSize: 48.0,
                    fontWeight: FontWeight.bold,
                    color: Colors.white),
              ),
            ),
            Column(
              children: [
                Row(
                  children: [
                    _buildButton('7', bgColor: Colors.grey[200]),
                    _buildButton('8', bgColor: Colors.grey[200]),
                    _buildButton('9', bgColor: Colors.grey[200]),
                    _buildButton('÷',
                        bgColor: Colors.orange, textColor: Colors.white),
                  ],
                ),
                Row(
                  children: [
                    _buildButton('4', bgColor: Colors.grey[200]),
                    _buildButton('5', bgColor: Colors.grey[200]),
                    _buildButton('6', bgColor: Colors.grey[200]),
                    _buildButton('×',
                        bgColor: Colors.orange, textColor: Colors.white),
                  ],
                ),
                Row(
                  children: [
                    _buildButton('1', bgColor: Colors.grey[200]),
                    _buildButton('2', bgColor: Colors.grey[200]),
                    _buildButton('3', bgColor: Colors.grey[200]),
                    _buildButton('-',
                        bgColor: Colors.orange, textColor: Colors.white),
                  ],
                ),
                Row(
                  children: [
                    _buildButton('0', bgColor: Colors.grey[200]),
                    _buildButton('.', bgColor: Colors.grey[400]),
                    _buildButton('C',
                        bgColor: Colors.red, textColor: Colors.white),
                    _buildButton('+',
                        bgColor: Colors.orange, textColor: Colors.white),
                  ],
                ),
                Row(
                  children: [
                    _buildButton('=',
                        bgColor: Colors.blue, textColor: Colors.white),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
