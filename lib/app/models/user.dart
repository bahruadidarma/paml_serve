import 'package:vania/vania.dart';
import 'package:mysql1/mysql1.dart';

class User extends Model {
  User() {
    MySqlConnection.connect;
    super.table('users');
  }
}
