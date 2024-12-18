import 'package:paml_serve/app/models/order.dart';
import 'package:vania/vania.dart';
import 'package:intl/intl.dart';

class OrderController extends Controller {
  // POST
  Future<Response> store(Request request) async {
    try {
      final order = request.input();
      final dateFormatter = DateFormat('yyyy-MM-dd');
      order['order_date'] =
          dateFormatter.format(DateTime.parse(order['order_date']));
      await Order().query().insert(order);

      return Response.json({
        "message": 'Data order berhasil ditambahkan.',
        "data": order,
      }, 201);
    } catch (e) {
      return Response.json({"message": 'Terjadi masalah'}, 500);
    }
  }

// GET
  Future<Response> show(Request request) async {
    try {
      final order = await Order().query().get();
      return Response.json({
        "message": 'Data order',
        "data": order,
      }, 201);
    } catch (e) {
      return Response.json({'message': "Ada masalah"}, 500);
    }
  }

// PUT
  Future<Response> update(Request request, int id) async {
    try {
      final update = await request.input();
      final date = update['order_date'];
      final cust_id = update['cust_id'];

      final data = await Order().query()
      .where('order_num', '=', id)
      .update({
        "order_date": date,
        "cust_id": cust_id,
      });

      if (data > 0) {
        return Response.json({
          "message": 'Data berhasil di-update',
          "data": update,
        }, 200);
      } else {
        return Response.json({"message": "Data tidak ditemukan"}, 404);
      }
    } catch (e) {
      return Response.json({
        "message": 'Terjadi masalah',
        "error": e.toString(),
      }, 500);
    }
  }

// DELETE
  Future<Response> destroy(Request request, int id) async {
    try {
      await Order().query().where('order_num', '=', id).delete();

      return Response.json({"message": 'Data order berhasil dihapus'});
    } catch (e) {
      return Response.json(
          {"message": 'Gagal menghapus data Order', "error": e.toString()});
    }
  }
}

final OrderController orderController = OrderController();
