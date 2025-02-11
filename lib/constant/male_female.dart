// ignore_for_file: constant_identifier_names

class MF {
  final String en;
  final String ar;

  MF({
    required this.en,
    required this.ar,
  });

  static List<MF> MFL = [
    MF(en: 'male', ar: 'الرجال'),
    MF(en: 'female', ar: 'السيدات'),
  ];
}
