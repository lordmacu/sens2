import 'package:flutter/material.dart';
import 'package:sens2/apps/apliplast/views/impresion/widget/switch_widget.dart';

class CaptureWidget extends StatefulWidget {
  final String buttonText;
  final String weightText;
  final String mainText;
  final dynamic incrementableValue;
  final String? optionalText;
  final dynamic optionalNumber;
  final String? optionalTitle;
  final String? bobinaText;
  final dynamic optionalKgValue;
  final bool showSwitchTitle;
  final bool showButton;

  const CaptureWidget({super.key, 
    required this.buttonText,
    required this.weightText,
    required this.mainText,
    this.incrementableValue,
    this.optionalText,
    this.optionalNumber,
    this.optionalTitle,
    this.bobinaText,
    this.optionalKgValue,
    this.showSwitchTitle = false,
    this.showButton = true,
  });

  @override
  _CaptureWidgetState createState() => _CaptureWidgetState();
}

class _CaptureWidgetState extends State<CaptureWidget> {
  dynamic displayValue;
  dynamic displayKgValue;

  @override
  void initState() {
    super.initState();
    displayValue = widget.incrementableValue ?? '--';
    displayKgValue = widget.optionalKgValue ?? '--';
  }

  void _incrementValue() {
    if (displayValue is int) {
      setState(() {
        displayValue++;
      });
    }
  }


  @override
  Widget build(BuildContext context) {
    String displayValueString = displayValue != null ? displayValue.toString() : '--';
    String displayKgValueString = displayKgValue != null ? displayKgValue.toString() : '--';

    return Container(
      margin: const EdgeInsets.only(top: 16),
      padding: const EdgeInsets.only(top: 16, bottom: 16),
      width: double.infinity,
      color: Colors.grey.withOpacity(0.2),
      child: Column(
        children: [
          if (widget.optionalTitle != null) ...[
            const SizedBox(height: 8),
            Text(
              widget.optionalTitle!,
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Color.fromARGB(255, 11, 19, 68),
              ),
            ),
          ],
          if (widget.bobinaText != null && widget.optionalKgValue != null) ...[
            const SizedBox(height: 8),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  widget.bobinaText!,
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Color.fromARGB(255, 11, 19, 68),
                  ),
                ),
                const SizedBox(width: 8),
                Text(
                  '$displayKgValueString kg',
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Color.fromARGB(255, 11, 19, 68),
                  ),
                ),
              ],
            ),
          ],
          const SizedBox(height: 8),
          if (widget.incrementableValue != null) ...[
            Text(
              '${widget.mainText}: $displayValueString',
              style: const TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: Color.fromARGB(255, 11, 19, 68),
              ),
            ),
            const SizedBox(height: 8),
          ],
          Text(
            widget.weightText,
            style: const TextStyle(
              fontSize: 25,
              fontWeight: FontWeight.bold,
              color: Color.fromARGB(255, 11, 19, 68),
            ),
          ),
          const SizedBox(height: 8),
          if (widget.showButton) ...[
            Container(
              width: 200,
              padding: const EdgeInsets.symmetric(vertical: 10.0),
              child: TextButton(
                onPressed: _incrementValue,
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all<Color>(
                    const Color.fromARGB(255, 14, 12, 87),
                  ),
                  padding: MaterialStateProperty.all<EdgeInsetsGeometry>(
                    const EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
                  ),
                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20.0),
                    ),
                  ),
                ),
                child: Text(
                  widget.buttonText,
                  style: const TextStyle(color: Colors.white),
                ),
              ),
            ),
          ],
          if (widget.showSwitchTitle) ...[
            const Center(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Mostrar en impresion?',
                    style: TextStyle(
                      color: Color.fromARGB(255, 65, 65, 65),
                      fontSize: 17,
                    ),
                  ),
                  SizedBox(width: 10),
                  SwitchState(),
                ],
              ),
            ),
          ],
          if (widget.optionalText != null && widget.optionalNumber != null) ...[
            const SizedBox(height: 8),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  widget.optionalText!,
                  style: const TextStyle(
                    fontSize: 23,
                    fontWeight: FontWeight.bold,
                    color: Color.fromARGB(255, 11, 19, 68),
                  ),
                ),
                const SizedBox(width: 8),
                widget.optionalNumber > 0
                    ? Text(
                        widget.optionalNumber != null ? '${widget.optionalNumber} kg' : '--',
                        style: const TextStyle(
                          fontSize: 23,
                          fontWeight: FontWeight.bold,
                          color: Color.fromARGB(255, 11, 19, 68),
                        ),
                      )
                    : const Text(""),
              ],
            ),
          ],
        ],
      ),
    );
  }
}
