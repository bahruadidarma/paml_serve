import 'package:paml_serve/app/models/customer.dart';
import 'package:vania/vania.dart';

class CustomerController extends Controller {
  Future<Response> index() async {
    return Response.json({'message': 'Customer Data'});
  }

// POST
  Future<Response> store(Request request) async {
    try {
      final customer = request.input();
      await User().query().insert(customer);

      return Response.json({
        "message": 'Data Customer berhasil ditambahkan.',
        "data": customer,
      }, 201);
    } catch (e) {
      return Response.json(
        {"message": 'Terjadi masalah'}, 500);
    }
  }

// GET
  Future<Response> show(Request request) async {
    try {
      final customer = await User().query().get();
      return Response.json({
        "message": 'Data Customer',
        "data": customer,
      }, 201);
    } catch (e) {
      return Response.json({'message': "Ada masalah"
    }, 500);
  }
}

// PUT
  Future<Response> update(Request request, String id) async {
  try {
    final update = await request.input();
    final name = update['cust_name'];
    final address = update['cust_address'];
    final city = update['cust_city'];
    final state = update['cust_state'];
    final zip = update['cust_zip'];
    final country = update['cust_country'];
    final telp = update['cust_telp'];

    final data = await User().query()
        .where('cust_id', '=', id)
        .update({
          "cust_name": name,
          "cust_address": address,
          "cust_city": city,
          "cust_state": state,
          "cust_zip": zip,
          "cust_country": country,
          "cust_telp": telp,
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
      await User().query().where('cust_id', '=', id).delete();

      return Response.json({"message": 'Data Customer berhasil dihapus'});
    } catch (e) {
      return Response.json({
        "message": 'Gagal menghapus data Costumer',
        "error": e.toString()
      }
      );
    }
  }
}

final CustomerController customerController = CustomerController();
