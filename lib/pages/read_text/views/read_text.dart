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
                  RichText(
                    text: TextSpan(
                      style: TextStyle(
                        fontSize: textSize,
                        color: Colors.black,
                        height: 1.5,
                      ),
                      children: _highlightWords(widget.text),
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

  List<TextSpan> _highlightWords(String text) {
    List<TextSpan> spans = [];

    // Define the pattern for detecting <color>...</color>
    RegExp pattern = RegExp(r'<(\w+)>([^<]+)<\/\1>');

    // Find matches in the text
    Iterable<Match> matches = pattern.allMatches(text);

    int lastEnd = 0;

    for (Match match in matches) {
      // Add non-matching text
      spans.add(TextSpan(text: text.substring(lastEnd, match.start)));

      // Extract color and word from the match
      String color = match.group(1)!;
      String word = match.group(2)!;

      // Add matching text with specified background color
      if (color == 'desc') {
        spans.add(
          TextSpan(
            text: word,
            style: TextStyle(
              fontStyle:
                  _is_italic(color) ? FontStyle.italic : FontStyle.normal,
              fontSize: textSize - .25*textSize,
            ),
            )
          );
      } else {
        spans.add(TextSpan(
            text: word,
            style: TextStyle(
              backgroundColor: _getColor(color),
              fontWeight: _is_bold(color) ? FontWeight.bold : FontWeight.normal,
              fontStyle:
                  _is_italic(color) ? FontStyle.italic : FontStyle.normal,
            )));
      }

      lastEnd = match.end;
    }

    // Add remaining non-matching text
    spans.add(TextSpan(text: text.substring(lastEnd)));

    return spans;
  }

  Color _getColor(String colorName) {
    // Map color names to Color objects
    Map<String, Color> colorMap = {
      'r': Colors.red,
      'b': Color.fromARGB(255, 163, 213, 251),
      'bg': Colors.yellowAccent,
      'y': Colors.yellow,
      'g': Color.fromARGB(255, 192, 191, 191),
      'lgr': Color.fromARGB(255, 156, 246, 198),
      // Add more color mappings as needed
    };

    // Return the corresponding color or white if not found
    return colorMap[colorName.toLowerCase()] ?? Colors.white;
  }

  bool _is_bold(String word) {
    // Check if the word starts and ends with '**' for bold formatting
    // return word.startsWith('**') && word.endsWith('**');
    return word == 'bd';
  }

  bool _is_italic(String word) {
    // Check if the word starts and ends with '*' for italic formatting
    // return word.startsWith('*') && word.endsWith('*');
    return word == 'i';
  }
}
