import 'package:intl/intl.dart';

extension ExtensionsString on String {
  String converterDate() {
    var date = DateTime.parse(this);
    var dateFormat = DateFormat('dd/MM/yyyy').format(date);

    return dateFormat;
  }
}
