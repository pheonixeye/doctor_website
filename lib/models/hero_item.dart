// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:equatable/equatable.dart';

class HeroItem extends Equatable {
  final String id;
  final String doc_id;
  final String image;
  final String title_en;
  final String title_ar;
  final String? subtitle_en;
  final String? subtitle_ar;
  final String? description_en;
  final String? description_ar;
  final int? t_font_mobile;
  final int? t_font_other;
  final int? s_font_mobile;
  final int? s_font_other;
  final int? d_font_mobile;
  final int? d_font_other;
  final String? t_align;
  final String? s_align;
  final String? d_align;

  const HeroItem({
    required this.id,
    required this.doc_id,
    required this.image,
    required this.title_en,
    required this.title_ar,
    required this.subtitle_en,
    required this.subtitle_ar,
    required this.description_en,
    required this.description_ar,
    required this.t_font_mobile,
    required this.t_font_other,
    required this.s_font_mobile,
    required this.s_font_other,
    required this.d_font_mobile,
    required this.d_font_other,
    required this.t_align,
    required this.s_align,
    required this.d_align,
  });

  HeroItem copyWith({
    String? id,
    String? doc_id,
    String? image,
    String? title_en,
    String? title_ar,
    String? subtitle_en,
    String? subtitle_ar,
    String? description_en,
    String? description_ar,
    int? t_font_mobile,
    int? t_font_other,
    int? s_font_mobile,
    int? s_font_other,
    int? d_font_mobile,
    int? d_font_other,
    String? t_align,
    String? s_align,
    String? d_align,
  }) {
    return HeroItem(
      id: id ?? this.id,
      doc_id: doc_id ?? this.doc_id,
      image: image ?? this.image,
      title_en: title_en ?? this.title_en,
      title_ar: title_ar ?? this.title_ar,
      subtitle_en: subtitle_en ?? this.subtitle_en,
      subtitle_ar: subtitle_ar ?? this.subtitle_ar,
      description_en: description_en ?? this.description_en,
      description_ar: description_ar ?? this.description_ar,
      t_font_mobile: t_font_mobile ?? this.t_font_mobile,
      t_font_other: t_font_other ?? this.t_font_other,
      s_font_mobile: s_font_mobile ?? this.s_font_mobile,
      s_font_other: s_font_other ?? this.s_font_other,
      d_font_mobile: d_font_mobile ?? this.d_font_mobile,
      d_font_other: d_font_other ?? this.d_font_other,
      t_align: t_align ?? this.t_align,
      s_align: s_align ?? this.s_align,
      d_align: d_align ?? this.d_align,
    );
  }

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'id': id,
      'doc_id': doc_id,
      'image': image,
      'title_en': title_en,
      'title_ar': title_ar,
      'subtitle_en': subtitle_en,
      'subtitle_ar': subtitle_ar,
      'description_en': description_en,
      'description_ar': description_ar,
      't_font_mobile': t_font_mobile,
      't_font_other': t_font_other,
      's_font_mobile': s_font_mobile,
      's_font_other': s_font_other,
      'd_font_mobile': d_font_mobile,
      'd_font_other': d_font_other,
      't_align': t_align,
      's_align': s_align,
      'd_align': d_align,
    };
  }

  HeroText get title => HeroText(
        text_en: title_en,
        text_ar: title_ar,
        align: t_align,
        font_mobile: t_font_mobile,
        font_other: t_font_other,
      );

  HeroText get subtitle => HeroText(
        text_en: subtitle_en,
        text_ar: subtitle_ar,
        align: s_align,
        font_mobile: s_font_mobile,
        font_other: s_font_other,
      );

  HeroText get description => HeroText(
        text_en: description_en,
        text_ar: description_ar,
        align: d_align,
        font_mobile: d_font_mobile,
        font_other: d_font_other,
      );

  factory HeroItem.fromJson(Map<String, dynamic> map) {
    return HeroItem(
      id: map['id'] as String,
      doc_id: map['doc_id'] as String,
      image: map['image'] as String,
      title_en: map['title_en'] as String,
      title_ar: map['title_ar'] as String,
      subtitle_en: map['subtitle_en'] as String?,
      subtitle_ar: map['subtitle_ar'] as String?,
      description_en: map['description_en'] as String?,
      description_ar: map['description_ar'] as String?,
      t_font_mobile: map['t_font_mobile'] as int?,
      t_font_other: map['t_font_other'] as int?,
      s_font_mobile: map['s_font_mobile'] as int?,
      s_font_other: map['s_font_other'] as int?,
      d_font_mobile: map['d_font_mobile'] as int?,
      d_font_other: map['d_font_other'] as int?,
      t_align: map['t_align'] as String?,
      s_align: map['s_align'] as String?,
      d_align: map['d_align'] as String?,
    );
  }

  @override
  bool get stringify => true;

  @override
  List<Object?> get props {
    return [
      id,
      doc_id,
      image,
      title_en,
      title_ar,
      subtitle_en,
      subtitle_ar,
      description_en,
      description_ar,
      t_font_mobile,
      t_font_other,
      s_font_mobile,
      s_font_other,
      d_font_mobile,
      d_font_other,
      t_align,
      s_align,
      d_align,
    ];
  }
}

class HeroText extends Equatable {
  final String? text_en;
  final String? text_ar;
  final String? align;
  final int? font_mobile;
  final int? font_other;

  const HeroText({
    required this.text_en,
    required this.text_ar,
    required this.align,
    required this.font_mobile,
    required this.font_other,
  });

  @override
  List<Object?> get props {
    return [
      text_en,
      text_ar,
      align,
      font_mobile,
      font_other,
    ];
  }
}
