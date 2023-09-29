import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../utils/geo_math.dart';

void main() => runApp(const RoundPage());

class RoundPage extends StatefulWidget {
  const RoundPage({super.key});

  @override
  State<RoundPage> createState() => _nameState();
}

class _nameState extends State<RoundPage> {
  final TextEditingController _textcontroller1 = TextEditingController();
  final TextEditingController _textcontroller2 = TextEditingController();
  final TextEditingController _textcontroller3 = TextEditingController();
  final TextEditingController _textcontroller4 = TextEditingController();

  double variable_name = 0.0;

  String res = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.only(top: 15),
            child: Column(
              children: [
                Container(
                  margin: const EdgeInsets.only(bottom: 15),
                  child: const Text(
                    "Обратная геодезическая задача",
                    textAlign: TextAlign.center,
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                  ),
                ),
                const Text("Значения точки A:", textAlign: TextAlign.center),
                Container(
                    margin: const EdgeInsets.fromLTRB(20, 10, 20, 10),
                    child: _getTextField(context, _textcontroller1,
                        variable_name, "Введите координату X:")),
                Container(
                    margin: const EdgeInsets.fromLTRB(20, 10, 20, 10),
                    child: _getTextField(context, _textcontroller2,
                        variable_name, "Введите координату Y:")),
                const Text('Значения точки B:'),
                Container(
                    margin: const EdgeInsets.fromLTRB(20, 10, 20, 10),
                    child: _getTextField(context, _textcontroller3,
                        variable_name, "Введите координату X")),
                Container(
                    margin: const EdgeInsets.fromLTRB(20, 10, 20, 10),
                    child: TextField(
                      textInputAction: TextInputAction.done,
                      controller: _textcontroller4,
                      onSubmitted: (value) {
                        try {
                          variable_name = double.parse(_textcontroller4.text);
                          setState(() {
                            double Xa = _getData(context, _textcontroller1);
                            double Ya = _getData(context, _textcontroller2);
                            double Xb = _getData(context, _textcontroller3);
                            double Yb = _getData(context, _textcontroller4);
                            res = GeoMath.revGeoTask(Xa, Ya, Xb, Yb).toString();
                          });
                        } catch (e) {
                          print("Возникла ошибка $e");
                        }
                      },
                      decoration: const InputDecoration(
                          labelText: "Введите координату Y:",
                          border: OutlineInputBorder()),
                      keyboardType:
                          const TextInputType.numberWithOptions(decimal: true),
                    )),
                Container(
                    margin: const EdgeInsets.fromLTRB(20, 0, 20, 0),
                    child: TextButton(
                      child: const Text("Решить задачу"),
                      onPressed: () {
                        try {
                          setState(() {
                            double Xa = _getData(context, _textcontroller1);
                            double Ya = _getData(context, _textcontroller2);
                            double Xb = _getData(context, _textcontroller3);
                            double Yb = _getData(context, _textcontroller4);
                            res = GeoMath.revGeoTask(Xa, Ya, Xb, Yb);
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
                    style: const TextStyle(fontSize: 18),
                    onTap: () {
                      _textcontroller1.clear();
                      _textcontroller2.clear();
                      _textcontroller3.clear();
                      _textcontroller4.clear();
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
