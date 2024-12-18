import 'package:vania/vania.dart';
import 'package:mysql1/mysql1.dart';

class Vendor extends Model {
  Vendor() {
    MySqlConnection.connect;
    super.table('vendors');
  }
}
