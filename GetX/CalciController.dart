// ignore: file_names
import 'package:get/get.dart';

class CalculatorController extends GetxController {
  var display = '0'.obs; // Observable to update UI

  String _firstOperand = '';
  String _secondOperand = '';
  String _operator = '';

  void addDigit(String digit) {
    if (_operator.isEmpty) {
      _firstOperand += digit;
    } else {
      _secondOperand += digit;
    }
    _updateDisplay();
  }

  void setOperator(String operator) {
    if (_firstOperand.isNotEmpty) {
      _operator = operator;
      _updateDisplay();
    }
  }

  void _updateDisplay() {
    if (_operator.isEmpty) {
      display.value = _firstOperand;
    } else if (_secondOperand.isEmpty) {
      display.value = '$_firstOperand$_operator';
    } else {
      display.value = '$_firstOperand$_operator$_secondOperand';
    }
  }

  void calculate() {
    double num1 = double.tryParse(_firstOperand) ?? 0;
    double num2 = double.tryParse(_secondOperand) ?? 0;

    switch (_operator) {
      case '+':
        display.value = (num1 + num2).toString();
        break;
      case '-':
        display.value = (num1 - num2).toString();
        break;
      case '*':
        display.value = (num1 * num2).toString();
        break;
      case '%':
        display.value = (num1 % num2).toString();
        print('hi');
        break;
      case '/':
        display.value = (num2 != 0 ? (num1 / num2).toString() : 'Error');
        break;
      default:
        display.value = 'Error';
        break;
    }
    _firstOperand = display.value;
    _secondOperand = '';
    _operator = '';
    _updateDisplay();
    // clear();
  }

  List<String> btn = [
    'AC',
    'C',
    '%',
    '/',
    '7',
    '8',
    '9',
    '*',
    '4',
    '5',
    '6',
    '-',
    '1',
    '2',
    '3',
    '+'
  ];

  void clear() {
    if (_secondOperand.isNotEmpty) {
      if (_secondOperand.isEmpty) {
        _secondOperand = '0';
      } else {
        _secondOperand = _secondOperand.substring(0, _secondOperand.length - 1);
      }
    } else if (_operator.isNotEmpty) {
      _operator = "";
    } else {
      if (_firstOperand.isEmpty) {
        _firstOperand = '0';
      } else {
        _firstOperand = _firstOperand.substring(0, _firstOperand.length - 1);
      }
    }
    _updateDisplay();
  }

  void reset() {
    display.value = '0';
    _firstOperand = '';
    _secondOperand = '';
    _operator = '';
  }
}
