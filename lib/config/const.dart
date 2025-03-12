// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:equatable/equatable.dart';

// ignore_for_file: constant_identifier_names, non_constant_identifier_names
final class Initials {
  static const String i_ = 'ha';
}

enum DoctorsContracted {
  khaledNabil('kn'),
  hossamElAwady('ha');

  final String initials;

  const DoctorsContracted(this.initials);
}

class DoctorStaticData extends Equatable {
  final String initials;
  late final String avatar = 'assets/images/$initials.png';
  final String call;
  final String whatsapp;
  final String facebook;
  final String youtube;
  final String aboutEn;
  final String aboutAr;

  DoctorStaticData({
    required this.initials,
    required this.call,
    required this.whatsapp,
    required this.facebook,
    required this.youtube,
    required this.aboutEn,
    required this.aboutAr,
  });

  @override
  List<Object> get props {
    return [
      initials,
      call,
      whatsapp,
      facebook,
      youtube,
      aboutEn,
      aboutAr,
    ];
  }

  static List<DoctorStaticData> doctorData = [
    DoctorStaticData(
      initials: DoctorsContracted.hossamElAwady.initials,
      call: '01555495005',
      whatsapp: '01555495005',
      facebook: 'https://facebook.com',
      youtube: 'https://youtube.com',
      aboutEn: '''
* Professor of Urology - Ain Shams University
* Endo-Urology Consultant
* M.D. In Urology
* Nephroscopy (PCNL) and Flexible Ureteroscopy (RIRS)
* Specialized in Uro-Oncology and Prostate Cancer
* Performed on Cases with Recurrent Urethral Strictures, Congenital Pediatric Urological Malformations and Hypospadius
* Consulting Cases if Infertility, Erectile Dysfunction and Premature Ejaculation
* Member of the Egyptian Association of Urologists      
''',
      aboutAr: '''
* استاذ جراحة المسالك البولية بكلية الطب جامعة عين شمس 
* استشاري جراحة و مناظير الكلي و المسالك البولية 
* دكتوراة جراحة المسالك البولية 
* استخراج حصوات الكلي و الحالب بالمنظار المرن و الليزر
* متخصص في جراحات اورام الجهاز البولي و اورام البروستاتا
* جراحات مجري البول و العيوب الخلقية للاطفال و اصلاح الاحليل البولي السفلي
* امراض الذكورة و علاج العقم و العجز الجنسي
* عضو الجمعية المصرية لجراحة المسالك البولية
''',
    ),
  ];

  factory DoctorStaticData.current() {
    return doctorData.firstWhere((e) => e.initials == Initials.i_);
  }
}
