import 'package:flutter/material.dart';

class CalculatorScreen extends StatefulWidget {
  const CalculatorScreen({super.key});

  @override
  State<CalculatorScreen> createState() => _CalculatorScreenState();
}

class _CalculatorScreenState extends State<CalculatorScreen> {
  String _currentInput = '0';
  String _previousInput = '';
  String _operator = '';
  final List<String> _history = [];
  bool _isNewCalculation = false;

  void _onButtonPressed(String buttonText) {
    setState(() {
      if (buttonText == 'AC') {
        _currentInput = '0';
        _previousInput = '';
        _operator = '';
        _isNewCalculation = false;
      } else if (buttonText == 'C') {
        if (_isNewCalculation) {
          _currentInput = '0';
          _isNewCalculation = false;
        } else if (_currentInput.length > 1) {
          _currentInput = _currentInput.substring(0, _currentInput.length - 1);
        } else {
          _currentInput = '0';
        }
      } else if (buttonText == '=') {
        _calculateResult();
      } else if (['+', '-', 'x', '/'].contains(buttonText)) {
        if (_operator.isNotEmpty &&
            _currentInput.isNotEmpty &&
            !_isNewCalculation) {
          _calculateResult();
        }
        _operator = buttonText;
        _previousInput = _currentInput;
        _currentInput = '0';
        _isNewCalculation = false;
      } else if (buttonText == '%') {
        double num = double.tryParse(_currentInput) ?? 0.0;
        _currentInput = (num / 100).toString();
        _isNewCalculation = true;
      } else {
        // It's a number or dot
        if (_isNewCalculation) {
          _currentInput = buttonText == '.' ? '0.' : buttonText;
          _isNewCalculation = false;
        } else {
          if (_currentInput == '0' && buttonText != '.') {
            _currentInput = buttonText;
          } else {
            // Prevent multiple dots
            if (buttonText == '.' && _currentInput.contains('.')) return;
            _currentInput += buttonText;
          }
        }
      }
    });
  }

  void _calculateResult() {
    if (_previousInput.isEmpty || _currentInput.isEmpty || _operator.isEmpty)
      return;

    double num1 = double.tryParse(_previousInput) ?? 0.0;
    double num2 = double.tryParse(_currentInput) ?? 0.0;
    double result = 0.0;

    switch (_operator) {
      case '+':
        result = num1 + num2;
        break;
      case '-':
        result = num1 - num2;
        break;
      case 'x':
        result = num1 * num2;
        break;
      case '/':
        if (num2 != 0) {
          result = num1 / num2;
        } else {
          _currentInput = 'Error';
          _operator = '';
          _previousInput = '';
          _isNewCalculation = true;
          return;
        }
        break;
    }

    String formattedResult =
        result.toStringAsFixed(result.truncateToDouble() == result ? 0 : 4);
    if (formattedResult.contains('.') && formattedResult.endsWith('0')) {
      // Trim trailing zeros after decimal
      formattedResult = formattedResult.replaceAll(RegExp(r'0*$'), '');
      if (formattedResult.endsWith('.')) {
        formattedResult =
            formattedResult.substring(0, formattedResult.length - 1);
      }
    }

    String historyEntry =
        '$_previousInput $_operator $_currentInput = $formattedResult';

    _history.insert(0, historyEntry);
    _currentInput = formattedResult;
    _operator = '';
    _previousInput = '';
    _isNewCalculation = true;
  }

  Widget _buildButton(String text, {Color? textColor, Color? bgColor}) {
    final colorScheme = Theme.of(context).colorScheme;
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.all(4.0),
        child: InkWell(
          onTap: () => _onButtonPressed(text),
          customBorder: const CircleBorder(),
          child: Container(
            height: 80,
            decoration: BoxDecoration(
              color: bgColor ?? colorScheme.secondary,
              shape: BoxShape.circle,
            ),
            alignment: Alignment.center,
            child: Text(
              text,
              style: TextStyle(
                fontSize: 32,
                fontWeight: FontWeight.w400,
                color: textColor ?? Colors.white,
              ),
            ),
          ),
        ),
      ),
    );
  }

  void _showHistoryModal() {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.grey[900],
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) {
        return Container(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              Text('Historial',
                  style: Theme.of(context).textTheme.displayMedium?.copyWith(fontSize: 24, color: Colors.white)),
              const Divider(color: Colors.white24),
              Expanded(
                child: _history.isEmpty
                    ? const Center(
                        child: Text('No hay historial', style: TextStyle(color: Colors.white54, fontSize: 18)))
                    : ListView.builder(
                        itemCount: _history.length,
                        itemBuilder: (context, index) {
                          return ListTile(
                            title: Text(
                              _history[index],
                              textAlign: TextAlign.right,
                              style: const TextStyle(color: Colors.white, fontSize: 24),
                            ),
                            onTap: () {
                              setState(() {
                                final resultStr = _history[index].split('=').last.trim();
                                _currentInput = resultStr;
                                _operator = '';
                                _previousInput = '';
                                _isNewCalculation = true;
                              });
                              Navigator.pop(context); // Close modal
                            },
                          );
                        },
                      ),
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    return Scaffold(
        backgroundColor: Colors.black,
        body: Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: const AssetImage('assets/images/anime.jpg'),
                fit: BoxFit.cover,
                colorFilter: ColorFilter.mode(
                  Colors.black.withOpacity(0.6),
                  BlendMode.darken,
                ),
              ),
            ),
            child: SafeArea(
                child: Center(
              child: ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 400),
                child: Column(
                  children: [
                    // Previous Input / Operator Display
                    Expanded(
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 24, vertical: 12),
                        alignment: Alignment.bottomRight,
                        child: Text(
                          _previousInput.isNotEmpty
                              ? '$_previousInput $_operator'
                              : '',
                          style: textTheme.displayMedium?.copyWith(
                            color: Colors.white54,
                            fontSize: 32,
                          ),
                        ),
                      ),
                    ),

                    // Current Input Display
                    Container(
                      padding: const EdgeInsets.only(
                          left: 24, right: 24, bottom: 8),
                      alignment: Alignment.bottomRight,
                      child: Text(
                        _currentInput,
                        style: textTheme.displayLarge,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),

                    // Tools Row (History Button)
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 24, vertical: 8),
                      alignment: Alignment.centerLeft,
                      child: IconButton(
                        icon: const Icon(Icons.history,
                            color: Colors.white, size: 28),
                        onPressed: _showHistoryModal,
                        tooltip: 'Abrir Historial',
                      ),
                    ),

                    // Keypad
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 16, vertical: 8),
                      child: Column(
                        children: [
                          Row(
                            children: [
                              _buildButton('AC',
                                  textColor: const Color(0xFFED4B4B)),
                              _buildButton('C',
                                  textColor: const Color(0xFFED4B4B)),
                              _buildButton('%', textColor: colorScheme.primary),
                              _buildButton('/', textColor: colorScheme.primary),
                            ],
                          ),
                          Row(
                            children: [
                              _buildButton('7'),
                              _buildButton('8'),
                              _buildButton('9'),
                              _buildButton('x', textColor: colorScheme.primary),
                            ],
                          ),
                          Row(
                            children: [
                              _buildButton('4'),
                              _buildButton('5'),
                              _buildButton('6'),
                              _buildButton('-', textColor: colorScheme.primary),
                            ],
                          ),
                          Row(
                            children: [
                              _buildButton('1'),
                              _buildButton('2'),
                              _buildButton('3'),
                              _buildButton('+', textColor: colorScheme.primary),
                            ],
                          ),
                          Row(
                            children: [
                              _buildButton(
                                  '0'), // Standard size for 0 to match Samsung aesthetics
                              _buildButton('.'),
                              Expanded(
                                flex:
                                    2, // Take up two spaces if we want a pill shape, or just pad it
                                child: Padding(
                                  padding: const EdgeInsets.all(4.0),
                                  child: InkWell(
                                    onTap: () => _onButtonPressed('='),
                                    borderRadius: BorderRadius.circular(40),
                                    child: Container(
                                      height: 80,
                                      decoration: BoxDecoration(
                                        color: colorScheme.primary,
                                        borderRadius: BorderRadius.circular(40),
                                      ),
                                      alignment: Alignment.center,
                                      child: const Text(
                                        '=',
                                        style: TextStyle(
                                          fontSize: 32,
                                          fontWeight: FontWeight.w400,
                                          color: Colors.black,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ))));
  }
}
