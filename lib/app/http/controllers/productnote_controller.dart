import 'package:paml_serve/app/models/productnote.dart';
import 'package:vania/vania.dart';
import 'package:intl/intl.dart';

class ProductnoteController extends Controller {

// POST
  Future<Response> store(Request request) async {
    try {
      final productnote = request.input();
      final dateFormatter = DateFormat('yyyy-MM-dd');
      productnote['note_date'] =
          dateFormatter.format(DateTime.parse(productnote['note_date']));
      await Productnote().query().insert(productnote);

      return Response.json({
        "message": 'Data Productnote berhasil ditambahkan.',
        "data": productnote,
      }, 201);
    } catch (e) {
      return Response.json({"message": 'Terjadi masalah'}, 500);
    }
  }

// GET
  Future<Response> show(Request request) async {
    try {
      final productnote = await Productnote().query().get();
      return Response.json({
        "message": 'Data Productnote',
        "data": productnote,
      }, 201);
    } catch (e) {
      return Response.json({'message': "Ada masalah"}, 500);
    }
  }

// PUT
  Future<Response> update(Request request, String id) async {
    try {
      final update = await request.input();
      final prod_id = update['prod_id'];
      final date = update['note_date'];
      final note_text = update['note_text'];

      final data = await Productnote().query()
      .where('note_id', '=', id)
      .update({
        "prod_id": prod_id,
        "note_date": date,
        "note_text": note_text
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
      await Productnote().query().where('note_id', '=', id).delete();

      return Response.json({"message": 'Data Productnote berhasil dihapus'});
    } catch (e) {
      return Response.json(
          {"message": 'Gagal menghapus data Productnote', "error": e.toString()});
    }
  }
}

final ProductnoteController productnoteController = ProductnoteController();

