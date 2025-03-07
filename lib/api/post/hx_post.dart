// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:doctor_website/api/common/common.dart';
import 'package:doctor_website/models/booking.dart';
import 'package:pocketbase/pocketbase.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

const String collection = 'bookings';

abstract class BookingApi {
  const BookingApi();
  static final DataSourceHelper _helper = DataSourceHelper();

  Future<void> createBooking(Booking booking);

  factory BookingApi.common() {
    return switch (_helper.dataSource) {
      DataSource.pb => HxPostPocketbase(),
      DataSource.sb => HxPostSupabase(),
    };
  }
}

///book appointment query
class HxPostPocketbase extends BookingApi {
  HxPostPocketbase();

  final _client = DataSourceHelper.ds as PocketBase;

  @override
  Future<void> createBooking(Booking booking) async {
    await _client.collection(collection).create(body: booking.toJson());
  }
}

class HxPostSupabase extends BookingApi {
  HxPostSupabase();

  final _client = DataSourceHelper.ds as SupabaseClient;

  @override
  Future<void> createBooking(Booking booking) async {
    await _client.from(collection).insert(booking.toSupabaseJson());
  }
}
