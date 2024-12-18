import 'package:vania/vania.dart';
import 'package:mysql1/mysql1.dart';

class Order extends Model {
  Order() {
    MySqlConnection.connect;
    super.table('orders');
  }
}
