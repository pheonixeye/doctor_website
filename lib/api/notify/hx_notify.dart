import 'package:doctor_website/api/common/common.dart';
import 'package:doctor_website/models/booking_notification.dart';
import 'package:pocketbase/pocketbase.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

abstract class NotificationsApi {
  const NotificationsApi();
  static final DataSourceHelper _helper = DataSourceHelper();

  Future<void> notifyBooking(BookingNotification bookingNotification);

  factory NotificationsApi.common(String doc_id) {
    return switch (_helper.dataSource) {
      DataSource.pb => HxNotifyPocketbase(doc_id: doc_id),
      DataSource.sb => HxNotifySupabase(doc_id: doc_id),
    };
  }
}

class HxNotifyPocketbase extends NotificationsApi {
  HxNotifyPocketbase({required this.doc_id});

  final String doc_id;

  final _client = DataSourceHelper.ds as PocketBase;

  @override
  Future<void> notifyBooking(BookingNotification bookingNotification) async {
    //TODO:
    await _client
        .collection('notifications')
        .create(body: bookingNotification.toJson());
  }
}

class HxNotifySupabase extends NotificationsApi {
  HxNotifySupabase({required this.doc_id});

  final String doc_id;

  final _client = DataSourceHelper.ds as SupabaseClient;

  @override
  Future<void> notifyBooking(BookingNotification bookingNotification) async {
    await _client
        .from('notifications')
        .insert(bookingNotification.toSupabaseJson());
  }
}
