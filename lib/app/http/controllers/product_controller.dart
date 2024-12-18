import 'package:paml_serve/app/models/product.dart';
import 'package:vania/vania.dart';

class ProductController extends Controller {
  // POST
  Future<Response> store(Request request) async {
    try {
      final product = request.input();
      await Product().query().insert(product);

      return Response.json({
        "message": 'Data product berhasil ditambahkan.',
        "data": product,
      }, 201);
    } catch (e) {
      return Response.json({"message": 'Terjadi masalah'}, 500);
    }
  }

// GET
  Future<Response> show(Request request) async {
    try {
      final product = await Product().query().get();
      return Response.json({
        "message": 'Data product',
        "data": product,
      }, 201);
    } catch (e) {
      return Response.json({'message': "Ada masalah"}, 500);
    }
  }

// PUT
  Future<Response> update(Request request, String id) async {
    try {
      final update = await request.input();
      final vend_id = update['vend_id'];
      final name = update['prod_name'];
      final price = update['prod_price'];
      final desc = update['prod_desc'];

      final data = await Product().query()
      .where('prod_id', '=', id)
      .update({
        "vend_id": vend_id,
        "prod_name": name,
        "prod_price": price,
        "prod_desc": desc,
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
  Future<Response> destroy(Request request, String id) async {
    try {
      await Product().query().where('prod_id', '=', id).delete();

      return Response.json({"message": 'Data product berhasil dihapus'});
    } catch (e) {
      return Response.json(
          {"message": 'Gagal menghapus data Product', "error": e.toString()});
    }
  }
}

final ProductController productController = ProductController();
