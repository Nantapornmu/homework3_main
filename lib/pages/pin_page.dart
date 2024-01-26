import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class TestPage extends StatefulWidget {
  const TestPage({super.key});

  @override
  State<TestPage> createState() => _TestPageState();
}

class _TestPageState extends State<TestPage> {
  // state variables
  TextEditingController pinController = TextEditingController();

  Widget buildItem({
    required IconData icon,
    required String label,
    Color color = Colors.black,
    double iconSize = 36.0, // Set a default size or adjust as needed
  }) {
    return InkWell(
      child: Container(
        width: 200.0,
        padding: const EdgeInsets.only(top: 40.0), // Adjust the top padding to create space
        child: Column(
          children: [
            SizedBox(height: 16.0), // Add some vertical space between "PIN LOGIN" and the icon
            icon == Icons.security_outlined
                ? Icon(icon, color: color, size: 48.0) // Increase the size for Icons.security_outlined
                : Icon(icon, color: color, size: iconSize),
            SizedBox(height: 10.0), // Add some vertical space between the icon and the text
            Text(
              label,
              style: GoogleFonts.palanquin(
                color: color,
                fontSize: 20.0,
              ),
            ),
          ],
        ),
      ),
    );
  }


  Widget buildPinInput() {
    return Container(
      width: 250.0,
      padding: EdgeInsets.symmetric(vertical: 40.0), // Adjust the vertical padding
      child: TextField(
        controller: pinController,
        textAlign: TextAlign.center,
        keyboardType: TextInputType.number,
        style: TextStyle(fontSize: 20.0),
        decoration: InputDecoration(
          border: InputBorder.none,
          hintText: "_ _ _ _ _ _",
        ),
      ),
    );
  }


  Widget buildNumericButton(int number) {
  String label = getNumericLabel(number);
  return Container(
    width: 60.0,
    height: 60.0,
    decoration: BoxDecoration(
      border: Border.all(color: Color.fromARGB(255, 190, 190, 190)),
      borderRadius: BorderRadius.zero,
    ),
    child: GestureDetector(
      onTap: () {
        if (pinController.text.length < 6) {
          pinController.text += number.toString();
        }
      },
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            number.toString(),
            style: TextStyle(fontSize: 20.0),
          ),
          SizedBox(height: 4.0), // Add spacing between number and label
          Text(
            label,
            style: TextStyle(fontSize: 12.0, fontWeight: FontWeight.bold),
          ),
        ],
      ),
    ),
  );
}

String getNumericLabel(int number) {
  switch (number) {
    case 1:
      return 'one';
    case 2:
      return 'two';
    case 3:
      return 'three';
    case 4:
      return 'four';
    case 5:
      return 'five';
    case 6:
      return 'six';
    case 7:
      return 'seven';
    case 8:
      return 'eight';
    case 9:
      return 'nine';
    case 0:
      return 'zero';
    default:
      return '';
  }
}


Widget buildNumericButtonsGrid() {
  List<Widget> rows = [];

  for (int i = 1; i <= 3; i++) {
    List<Widget> rowChildren = [];
    for (int j = 1; j <= 3; j++) {
      int number = (i - 1) * 3 + j;
      rowChildren.add(buildNumericButton(number));
    }
    rows.add(Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: rowChildren,
    ));

    // Add consistent spacing between rows
    if (i < 3) {
      rows.add(SizedBox(height: 20.0)); // Adjust the height as needed
    }
  }

  // Add Icons.close and 0
  rows.add(Padding(
    padding: EdgeInsets.symmetric(vertical: 20.0), // Adjust the vertical spacing as needed
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        buildActionIconButton(Icons.close),
        buildNumericButton(0),
        buildActionIconButton(Icons.backspace),
      ],
    ),
  ));

  return Container(
    width: 240.0, // Set a fixed width for the container
    child: Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: rows,
    ),
  );
}


  Widget buildActionIconButton(IconData icon) {
  return Container(
    width: 60.0,
    height: 40.0,
    decoration: BoxDecoration(
      border: icon == Icons.close || icon == Icons.backspace
          ? null
          : Border.all(color: Colors.black), // Remove border for Icons.close and Icons.backspace
      borderRadius: BorderRadius.circular(8.0),
    ),
    child: ElevatedButton(
      onPressed: () {
        // Handle button click for Icons.close or Icons.backspace
        if (icon == Icons.close) {
          // Clear the entered PIN
          pinController.text = '';
        } else if (icon == Icons.backspace) {
          // Remove the last entered digit
          if (pinController.text.isNotEmpty) {
            pinController.text = pinController.text.substring(0, pinController.text.length - 1);
          }
        } else {
          // Handle other actions here
        }
      },
      style: ElevatedButton.styleFrom(
        onPrimary: Colors.black, // Set text (icon) color to white
        elevation: 0, // Remove elevation
      ),
      child: Icon(icon, size: 18.0),
    ),
  );
}




  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          children: [
            buildItem(
                icon: Icons.security_outlined,
                label: "PIN LOGIN",
                color: Colors.black,
                iconSize: 36.0),
            SizedBox(height: 60.0),
            buildPinInput(),
            SizedBox(height: 60.0),
            buildNumericButtonsGrid(),
          ],
        ),
      ),
    );
  }
}
