import 'package:number_display/number_display.dart';

final display = createDisplay(
  length: 20,
  decimal: 0,
);

formatNumberValue(num value) {
  String valueStr = value.toStringAsFixed(3);
  print(double.parse(valueStr));
  return "${display(double.parse(valueStr))}.00";
}
