import 'package:doctor_website/constant/constants.dart';
import 'package:pocketbase/pocketbase.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

enum DataSource {
  pb,
  sb;

  const DataSource();
}

class DataSourceHelper {
  //TODO: change dynamically
  final DataSource _dataSource = DataSource.sb;

  DataSource get dataSource => _dataSource;

  static dynamic _ds;

  static dynamic get ds => _ds;

  DataSourceHelper() {
    _ds ??= switch (_dataSource) {
      DataSource.pb =>
        PocketBase(const String.fromEnvironment(AppConstants.POCKETBASE_URL)),
      DataSource.sb => Supabase.instance.client,
    };
  }
}
