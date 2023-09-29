import 'package:flutter/material.dart';
import 'deg_page.dart';
import 'gms_page.dart';
import 'direct_page.dart';
import 'round_page.dart';

void main() => runApp(const HomePage());

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _nameState();
}

class _nameState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            const SizedBox(height: 100),
            const Center(
              child: Text(
                'GeoCalc',
                style: TextStyle(
                  color: Colors.deepPurple,
                  fontSize: 50,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const SizedBox(height: 100),
            Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
              _getButton(context, const DegPage(), "Deg to GMS"),
              _getButton(context, const GMSPage(), "GMS to Deg")
            ]),
            const SizedBox(height: 50),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _getButton(
                    context, const DirectPage(), 'Прямая геодезическая задача'),
                _getButton(context, const RoundPage(),
                    "Обратная геодезическая задача"),
              ],
            )
          ],
        ),
      ),
    );
  }
}

Widget _getButton(BuildContext context, root, String text) {
  return ElevatedButton(
    onPressed: () {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => root),
      );
    },
    style: ButtonStyle(
      alignment: Alignment.center,
      fixedSize: const MaterialStatePropertyAll(Size(130, 100)),
      backgroundColor: MaterialStateProperty.all(Colors.deepPurple),
      shape: MaterialStateProperty.all(
        RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15.0),
        ),
      ),
    ),
    child: Text(text),
  );
}
