import 'package:doctor_website/api/common/common.dart';
import 'package:doctor_website/models/server_response_model.dart';
import 'package:pocketbase/pocketbase.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

abstract class HxMain {
  const HxMain();

  static final DataSourceHelper _helper = DataSourceHelper();

  Future<ServerResponseModel?> fetchModelById();

  factory HxMain.common(String doc_id) {
    return switch (_helper.dataSource) {
      DataSource.pb => HxMainPocketbase(doc_id: doc_id),
      DataSource.sb => HxMainSupabase(doc_id: doc_id),
    };
  }
}

class HxMainPocketbase implements HxMain {
  HxMainPocketbase({required this.doc_id});

  final String doc_id;

  static const String _expand = '';

  final _client = DataSourceHelper.ds as PocketBase;

  @override
  Future<ServerResponseModel?> fetchModelById() async {
    await _client.collection('doctors').getOne(
          doc_id,
          expand: _expand,
        );

    return null;
  }
}

class HxMainSupabase implements HxMain {
  HxMainSupabase({required this.doc_id});

  final String doc_id;

  final _client = DataSourceHelper.ds as SupabaseClient;

  static const String rpc = 'get_doc_data';

  @override
  Future<ServerResponseModel?> fetchModelById() async {
    print('HxMainSupabase().fetchModelById($doc_id)');
    final _result = await _client.rpc(
      rpc,
      params: {
        'doc_id': doc_id,
      },
    );

    print(_result);

    return null;
  }
}
