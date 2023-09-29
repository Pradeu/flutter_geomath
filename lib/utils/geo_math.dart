import "dart:math" show pi, cos, sin, atan;

class GeoMath {
  static double _toRad([double deg = 180.0]) {
    double rad = deg * pi / 180;
    return rad;
  }

  static double _toDegree([double rad = 0.0]) {
    double deg = rad * 180 / pi;
    return deg;
  }

  static double toDeg([double degree = 0, double min = 0, double sec = 0]) {
    double deg = degree + min / 60 + sec / 3600;
    return deg;
  }

  static String toGMS([double deg = 0]) {
    int degree = deg.toInt();
    double min = ((deg - deg.toInt()) * 60);
    double sec = double.parse(((min - min.toInt()) * 60).toStringAsFixed(2));
    return "${degree.toString()}° ${min.toInt().toString()}′ ${sec.toString()}′′";
  }

  static String strGeoTask(
      [double x = 0.0,
      double y = 0.0,
      double d = 0.0,
      double degree = 0,
      double min = 0,
      double sec = 0]) {
    double deg = toDeg(degree, min, sec);
    double rad = _toRad(deg);
    double deltaX = d * cos(rad);
    double deltaY = d * sin(rad);
    double Xb = x + deltaX;
    double Yb = y + deltaY;
    return "Координаты точки B: по X = ${Xb.toStringAsFixed(2)}, по Y = ${Yb.toStringAsFixed(2)}";
  }

  static String revGeoTask(
      [double Xa = 0.0, double Ya = 0.0, double Xb = 0.0, double Yb = 0.0]) {
    double deltaX = Xb - Xa;
    double deltaY = Yb - Ya;
    double angle = 0.0;
    double r = atan((deltaY / deltaX).abs());
    if (deltaX >= 0 && deltaY >= 0) {
      angle = r;
    } else if (deltaX < 0 && deltaY >= 0) {
      angle = _toRad(180) - r;
    } else if (deltaX >= 0 && deltaY < 0) {
      angle = _toRad(360) - r;
    } else {
      angle = _toRad(180) + r;
    }
    double d = deltaX / cos(angle);
    String degree = toGMS(_toDegree(angle));
    return "Горизонтальное проложение А: ${d.toStringAsFixed(2)}, дирекционный угол А: ${degree}";
  }
}
