import 'package:paml_serve/app/models/vendor.dart';
import 'package:vania/vania.dart';

class VendorController extends Controller {
// POST
  Future<Response> store(Request request) async {
    try {
      final vendor = request.input();
      await Vendor().query().insert(vendor);

      return Response.json({
        "message": 'Data vendor berhasil ditambahkan.',
        "data": vendor,
      }, 201);
    } catch (e) {
      return Response.json({"message": 'Terjadi masalah'}, 500);
    }
  }

// GET
  Future<Response> show(Request request) async {
    try {
      final vendor = await Vendor().query().get();
      return Response.json({
        "message": 'Data vendor',
        "data": vendor,
      }, 201);
    } catch (e) {
      return Response.json({'message': "Ada masalah"}, 500);
    }
  }

// PUT
  Future<Response> update(Request request, String id) async {
    try {
      final update = await request.input();
      final name = update['vend_name'];
      final address = update['vend_address'];
      final kota = update['vend_kota'];
      final state = update['vend_state'];
      final zip = update['vend_zip'];
      final country = update['vend_country'];

      final data = await Vendor().query()
      .where('vend_id', '=', id)
      .update({
        "vend_name": name,
        "vend_address": address,
        "vend_kota": kota,
        "vend_state": state,
        "vend_zip": zip,
        "vend_country": country,
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
      await Vendor().query().where('vend_id', '=', id).delete();

      return Response.json({"message": 'Data vendor berhasil dihapus'});
    } catch (e) {
      return Response.json(
          {"message": 'Gagal menghapus data Vendor', "error": e.toString()});
    }
  }
}

final VendorController vendorController = VendorController();
