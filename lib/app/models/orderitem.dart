import 'package:vania/vania.dart';
import 'package:mysql1/mysql1.dart';

class Orderitem extends Model {
  Orderitem() {
    MySqlConnection.connect;
    super.table('orderitems');
  }
}
