import 'package:doctor_website/api/common/common.dart';

///main doctor query with all expands
class HxMain {
  const HxMain({required this.doc_id});

  final String doc_id;

  static const String _expand = '';

  Future<ServerResponseModel> fetchModelById() async {
    //TODO: query
    final result = await PocketbaseHelper.pb.collection('doctors').getOne(
          doc_id,
          expand: _expand,
        );

    return ServerResponseModel.fromRecordModel(result);
  }
}
