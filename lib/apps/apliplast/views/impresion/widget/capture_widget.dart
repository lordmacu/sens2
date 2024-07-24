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

  CaptureWidget({
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

  void _incrementKgValue() {
    if (displayKgValue is int) {
      setState(() {
        displayKgValue++;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    String displayValueString = displayValue != null ? displayValue.toString() : '--';
    String displayKgValueString = displayKgValue != null ? displayKgValue.toString() : '--';

    return Container(
      margin: EdgeInsets.only(top: 16),
      padding: EdgeInsets.only(top: 16, bottom: 16),
      width: double.infinity,
      color: Colors.grey.withOpacity(0.2),
      child: Column(
        children: [
          if (widget.optionalTitle != null) ...[
            SizedBox(height: 8),
            Text(
              widget.optionalTitle!,
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Color.fromARGB(255, 11, 19, 68),
              ),
            ),
          ],
          if (widget.bobinaText != null && widget.optionalKgValue != null) ...[
            SizedBox(height: 8),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  widget.bobinaText!,
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Color.fromARGB(255, 11, 19, 68),
                  ),
                ),
                SizedBox(width: 8),
                Text(
                  '$displayKgValueString kg',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Color.fromARGB(255, 11, 19, 68),
                  ),
                ),
              ],
            ),
          ],
          SizedBox(height: 8),
          if (widget.incrementableValue != null) ...[
            Text(
              '${widget.mainText}: $displayValueString',
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: Color.fromARGB(255, 11, 19, 68),
              ),
            ),
            SizedBox(height: 8),
          ],
          Text(
            widget.weightText,
            style: TextStyle(
              fontSize: 25,
              fontWeight: FontWeight.bold,
              color: Color.fromARGB(255, 11, 19, 68),
            ),
          ),
          SizedBox(height: 8),
          if (widget.showButton) ...[
            Container(
              width: 200,
              padding: EdgeInsets.symmetric(vertical: 10.0),
              child: TextButton(
                onPressed: _incrementValue,
                child: Text(
                  widget.buttonText,
                  style: TextStyle(color: Colors.white),
                ),
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all<Color>(
                    Color.fromARGB(255, 14, 12, 87),
                  ),
                  padding: MaterialStateProperty.all<EdgeInsetsGeometry>(
                    EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
                  ),
                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20.0),
                    ),
                  ),
                ),
              ),
            ),
          ],
          if (widget.showSwitchTitle) ...[
            Center(
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
            SizedBox(height: 8),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  widget.optionalText!,
                  style: TextStyle(
                    fontSize: 23,
                    fontWeight: FontWeight.bold,
                    color: Color.fromARGB(255, 11, 19, 68),
                  ),
                ),
                SizedBox(width: 8),
                widget.optionalNumber > 0
                    ? Text(
                        widget.optionalNumber != null ? '${widget.optionalNumber} kg' : '--',
                        style: TextStyle(
                          fontSize: 23,
                          fontWeight: FontWeight.bold,
                          color: Color.fromARGB(255, 11, 19, 68),
                        ),
                      )
                    : Text(""),
              ],
            ),
          ],
        ],
      ),
    );
  }
}
