import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../utils/geo_math.dart';

void main() => runApp(const DirectPage());

class DirectPage extends StatefulWidget {
  const DirectPage({super.key});

  @override
  State<DirectPage> createState() => _nameState();
}

class _nameState extends State<DirectPage> {
  final TextEditingController _textcontroller1 = TextEditingController();
  final TextEditingController _textcontroller2 = TextEditingController();
  final TextEditingController _textcontroller3 = TextEditingController();
  final TextEditingController _textcontroller4 = TextEditingController();
  final TextEditingController _textcontroller5 = TextEditingController();
  final TextEditingController _textcontroller6 = TextEditingController();

  double variable_name = 0.0;

  String res = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.only(top: 10),
            child: Column(
              children: [
                Container(
                  margin: const EdgeInsets.only(bottom: 15),
                  child: const Text(
                    "Прямая геодезическая задача",
                    textAlign: TextAlign.center,
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                  ),
                ),
                const Text("Значения точки A:", textAlign: TextAlign.center),
                Container(
                  margin: const EdgeInsets.fromLTRB(20, 10, 20, 10),
                  child: _getTextField(context, _textcontroller1, variable_name,
                      "Введите координату x:"),
                ),
                Container(
                  margin: const EdgeInsets.fromLTRB(20, 10, 20, 10),
                  child: _getTextField(context, _textcontroller2, variable_name,
                      "Введите координату y:"),
                ),
                Container(
                  margin: const EdgeInsets.fromLTRB(20, 10, 20, 10),
                  child: _getTextField(context, _textcontroller3, variable_name,
                      "Введите горизонтальное проложение линии"),
                ),
                const Text("Значения дирекционного угла AB:",
                    textAlign: TextAlign.center),
                Container(
                    margin: const EdgeInsets.fromLTRB(20, 10, 20, 10),
                    child: _getTextField(context, _textcontroller4,
                        variable_name, "Введите градусы:")),
                Container(
                  margin: const EdgeInsets.fromLTRB(20, 10, 20, 10),
                  child: _getTextField(context, _textcontroller5, variable_name,
                      "Введите минуты:"),
                ),
                Container(
                    margin: const EdgeInsets.fromLTRB(20, 10, 20, 10),
                    child: TextField(
                      textInputAction: TextInputAction.done,
                      controller: _textcontroller6,
                      onSubmitted: (value) {
                        try {
                          variable_name = double.parse(_textcontroller6.text);
                          setState(() {
                            double x = _getData(context, _textcontroller1);
                            double y = _getData(context, _textcontroller2);
                            double d = _getData(context, _textcontroller3);
                            double degree = _getData(context, _textcontroller4);
                            double min = _getData(context, _textcontroller5);
                            double sec = _getData(context, _textcontroller6);
                            res = GeoMath.strGeoTask(x, y, d, degree, min, sec);
                          });
                        } catch (e) {
                          print("Возникла ошибка $e");
                        }
                      },
                      decoration: const InputDecoration(
                          labelText: "Введите секунды",
                          border: OutlineInputBorder()),
                      keyboardType:
                          const TextInputType.numberWithOptions(decimal: true),
                    )),
                Container(
                    margin: const EdgeInsets.fromLTRB(20, 0, 20, 0),
                    child: TextButton(
                      child: const Text("Рассчитать координаты точки B"),
                      onPressed: () {
                        try {
                          setState(() {
                            double x = _getData(context, _textcontroller1);
                            double y = _getData(context, _textcontroller2);
                            double d = _getData(context, _textcontroller3);
                            double degree = _getData(context, _textcontroller4);
                            double min = _getData(context, _textcontroller5);
                            double sec = _getData(context, _textcontroller6);
                            res = GeoMath.strGeoTask(x, y, d, degree, min, sec);
                          });
                        } catch (e) {
                          print("Возникла ошибка $e");
                        }
                      },
                    )),
                Padding(
                  padding: EdgeInsets.fromLTRB(20, 0, 20, 0),
                  child: SelectableText(
                    res,
                    textAlign: TextAlign.center,
                    style: const TextStyle(fontSize: 25),
                    onTap: () {
                      _textcontroller1.clear();
                      _textcontroller2.clear();
                      _textcontroller3.clear();
                      _textcontroller4.clear();
                      _textcontroller5.clear();
                      _textcontroller6.clear();
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
                  ),
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
