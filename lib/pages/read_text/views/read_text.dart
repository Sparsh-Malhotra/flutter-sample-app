import 'package:flutter/material.dart';

class ReadTextScreen extends StatefulWidget {
  final String text;
  final String title;

  ReadTextScreen({required this.text, required this.title});

  @override
  _ReadTextScreenState createState() => _ReadTextScreenState();
}

class _ReadTextScreenState extends State<ReadTextScreen> {
  double textSize = 18.0; // Initial text size

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.title,
          style: TextStyle(
            color: Colors.black,
          ),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.all(14.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(
              child: ListView(
                children: [
                  Text(
                    widget.text,
                    style: TextStyle(
                      fontSize: textSize,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                      height: 1.5,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
            SizedBox(height: 20.0),
            Row(
              children: [
                ElevatedButton(
                  onPressed: () {
                    // Increase text size when the button is pressed
                    setState(() {
                      textSize += 1.0;
                    });
                  },
                  child: Text('Aa+'),
                ),
                SizedBox(width: 10.0),
                ElevatedButton(
                  onPressed: () {
                    // Decrease text size when the button is pressed
                    setState(() {
                      textSize = textSize > 1.0 ? textSize - 1.0 : textSize;
                    });
                  },
                  child: Text('Aa-'),
                ),
              ],
              mainAxisAlignment: MainAxisAlignment.end,
            ),
          ],
        ),
      ),
    );
  }
}