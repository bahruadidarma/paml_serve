import 'package:paml_serve/app/models/orderitem.dart';
import 'package:vania/vania.dart';

class OrderitemController extends Controller {
  // POST
  Future<Response> store(Request request) async {
    try {
      final orderitem = request.input();
      await Orderitem().query().insert(orderitem);

      return Response.json({
        "message": 'Data Orderitem berhasil ditambahkan.',
        "data": orderitem,
      }, 201);
    } catch (e) {
      return Response.json({"message": 'Terjadi masalah'}, 500);
    }
  }

// GET
  Future<Response> show(Request request) async {
    try {
      final orderitem = await Orderitem().query().get();
      return Response.json({
        "message": 'Data Orderitem',
        "data": orderitem,
      }, 201);
    } catch (e) {
      return Response.json({'message': "Ada masalah"}, 500);
    }
  }

// PUT
  Future<Response> update(Request request, int id) async {
    try {
      final update = await request.input();
      final order_num = update['order_num'];
      final prod_id = update['prod_id'];
      final quantity = update['quantity'];
      final size = update['size'];

      final data = await Orderitem().query()
      .where('order_item', '=', id)
      .update({
        "order_num": order_num,
        "prod_id": prod_id,
        "quantity": quantity,
        "size": size,
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
      await Orderitem().query().where('order_item', '=', id).delete();

      return Response.json({"message": 'Data Orderitem berhasil dihapus'});
    } catch (e) {
      return Response.json(
          {"message": 'Gagal menghapus data Orderitem', "error": e.toString()});
    }
  }
}

final OrderitemController orderitemController = OrderitemController();
