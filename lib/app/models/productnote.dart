import 'package:mysql1/mysql1.dart';
import 'package:vania/vania.dart';

class Productnote extends Model {
  Productnote() {
    MySqlConnection.connect;
    super.table('productnotes');
  }
}
