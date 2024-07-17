import 'package:flutter/material.dart';

class CustomWidget extends StatefulWidget {
  final String buttonText;
  final String weightText;
  final String mainText;
  final dynamic incrementableValue;
  final String? optionalText;
  final dynamic optionalNumber;
  final String? optionalTitle;
  final String? bobinaText;
  final dynamic optionalKgValue;

  CustomWidget({
    required this.buttonText,
    required this.weightText,
    required this.mainText,
    this.incrementableValue,
    this.optionalText,
    this.optionalNumber,
    this.optionalTitle,
    this.bobinaText,
    this.optionalKgValue,
  });

  @override
  _CustomWidgetState createState() => _CustomWidgetState();
}

class _CustomWidgetState extends State<CustomWidget> {
  dynamic displayValue;
  dynamic displayKgValue;

  @override
  void initState() {
    super.initState();
    displayValue = widget.incrementableValue ?? '--';
    displayKgValue = widget.optionalKgValue ?? '--'; // Initial value '--' changed to widget.optionalKgValue
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
    String displayValueString =
        displayValue != null ? displayValue.toString() : '--';
    String displayKgValueString =
        displayKgValue != null ? displayKgValue.toString() : '--'; // Updated to use displayKgValue instead of optionalKgValue directly

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
                  '$displayKgValueString kg', // Displaying displayKgValueString instead of widget.optionalKgValue
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
          Text(
            '${widget.mainText}: $displayValueString',
            style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.bold,
              color: Color.fromARGB(255, 11, 19, 68),
            ),
          ),
          SizedBox(height: 8),
          Text(
            widget.weightText,
            style: TextStyle(
              fontSize: 25,
              fontWeight: FontWeight.bold,
              color: Color.fromARGB(255, 11, 19, 68),
            ),
          ),
          SizedBox(height: 8),
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
                widget.optionalNumber > 0 ? Text(
                  widget.optionalNumber != null
                      ? '${widget.optionalNumber} kg'
                      : '--',
                  style: TextStyle(
                    fontSize: 23,
                    fontWeight: FontWeight.bold,
                    color: Color.fromARGB(255, 11, 19, 68),
                  ),
                ): Text(""),
              ],
            ),
          ],
        ],
      ),
    );
  }
}
