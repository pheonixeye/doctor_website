import 'package:doctor_website/models/booking.dart';
import 'package:doctor_website/models/server_response_model.dart';
import 'package:equatable/equatable.dart';
import 'package:intl/intl.dart';

class BookingNotification extends Equatable {
  final String id;
  final String doc_id;
  final String title;
  final String body;

  const BookingNotification({
    required this.id,
    required this.doc_id,
    required this.title,
    required this.body,
  });

  BookingNotification copyWith({
    String? id,
    String? doc_id,
    String? title,
    String? body,
  }) {
    return BookingNotification(
      id: id ?? this.id,
      doc_id: doc_id ?? this.doc_id,
      title: title ?? this.title,
      body: body ?? this.body,
    );
  }

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'id': id,
      'doc_id': doc_id,
      'title': title,
      'body': body,
    };
  }

  Map<String, dynamic> toSupabaseJson() {
    return toJson()..remove('id');
  }

  factory BookingNotification.fromJson(Map<String, dynamic> map) {
    return BookingNotification(
      id: map['id'] as String,
      doc_id: map['doc_id'] as String,
      title: map['title'] as String,
      body: map['body'] as String,
    );
  }

  factory BookingNotification.fromServerResponseModel(
    ServerResponseModel model,
    Booking booking,
  ) {
    final _clinic = model.clinics!
        .firstWhere((clinic) => clinic.clinic.id == booking.clinic_id);
    final _weekday = model.clinics!
        .firstWhere((clinic) => clinic.clinic.id == booking.clinic_id)
        .schedule
        .firstWhere((sch) => sch.id == booking.schedule_id);
    final _date = booking.date;
    final _name = booking.name;
    final _phone = booking.phone;
    return BookingNotification(
      id: '',
      doc_id: booking.doc_id,
      title: 'حجز جديد',
      body: '''
${_clinic.clinic.name_ar},
$_name,
$_phone,
${_weekday.weekday_ar}
${DateFormat('dd / MM / yyyy', 'ar').format(DateTime.parse(_date!))}
 ''',
    );
  }

  @override
  bool get stringify => true;

  @override
  List<Object> get props => [id, doc_id, title, body];
}
