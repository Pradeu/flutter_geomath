import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../utils/geo_math.dart';

void main() => runApp(const GMSPage());

class GMSPage extends StatefulWidget {
  const GMSPage({super.key});

  @override
  State<GMSPage> createState() => _nameState();
}

class _nameState extends State<GMSPage> {
  final TextEditingController _textcontroller1 = TextEditingController();
  final TextEditingController _textcontroller2 = TextEditingController();
  final TextEditingController _textcontroller3 = TextEditingController();

  double variable_name = 0.0;

  String res = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.only(top: 35),
            child: Column(
              children: [
                Container(
                  margin: const EdgeInsets.only(bottom: 15),
                  child: const Text(
                    'ГГММСС в градусы',
                    textAlign: TextAlign.center,
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                  ),
                ),
                Container(
                    margin: const EdgeInsets.all(20),
                    child: _getTextField(context, _textcontroller1,
                        variable_name, "Введите градусы:")),
                Container(
                    margin: const EdgeInsets.all(20),
                    child: _getTextField(context, _textcontroller2,
                        variable_name, "Введите минуты:")),
                Container(
                    margin: const EdgeInsets.all(20),
                    child: _getTextField(context, _textcontroller3,
                        variable_name, "Введите секунды:")),
                Container(
                    margin: const EdgeInsets.all(20),
                    child: TextButton(
                      child: Text("Рассчитать градусы"),
                      onPressed: () {
                        try {
                          setState(() {
                            double degree = _getData(context, _textcontroller1);
                            double min = _getData(context, _textcontroller2);
                            double sec = _getData(context, _textcontroller3);
                            res = GeoMath.toDeg(degree, min, sec)
                                .toStringAsFixed(2);
                          });
                        } catch (e) {
                          print("Возникла ошибка $e");
                        }
                      },
                    )),
                SelectableText(
                  res,
                  style: TextStyle(fontSize: 25),
                  onTap: () {
                    _textcontroller1.clear();
                    _textcontroller2.clear();
                    _textcontroller3.clear();
                    Clipboard.setData(ClipboardData(text: res)).then(
                      (_) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text(
                              "Текст скопирован!",
                              textAlign: TextAlign.center,
                            ),
                          ),
                        );
                      },
                    );
                  },
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

Widget _getTextField(
    BuildContext context, controller, variable_name, String label_text) {
  return TextField(
    textInputAction: TextInputAction.next,
    controller: controller,
    onSubmitted: (value) {
      try {
        variable_name = double.parse(controller.text);
      } catch (e) {
        print("Возникла ошибка $e");
      }
    },
    decoration: InputDecoration(
        labelText: label_text, border: const OutlineInputBorder()),
    keyboardType: const TextInputType.numberWithOptions(decimal: true),
  );
}

double _getData(BuildContext context, controller) {
  return double.parse(controller.text);
}
