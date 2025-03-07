// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:doctor_website/models/article_response_model.dart';
import 'package:doctor_website/models/case.dart';
import 'package:doctor_website/models/clinic_response_model.dart';
import 'package:doctor_website/models/doctor.dart';
import 'package:doctor_website/models/doctor_about.dart';
import 'package:doctor_website/models/hero_item.dart';
import 'package:doctor_website/models/service_response_model.dart';
import 'package:doctor_website/models/social_contact.dart';
import 'package:doctor_website/models/video.dart';
import 'package:equatable/equatable.dart';

class ServerResponseModel extends Equatable {
  final List<ArticleResponseModel>? articles;
  final List<Case>? cases;
  final List<ServiceResponseModel>? services;
  final List<ClinicResponseModel>? clinics;
  final Doctor? doctor;
  final List<DoctorAbout>? doctorAbouts;
  final SocialContact? socialContacts;
  final List<Video>? videos;
  final List<HeroItem>? heroItems;

  const ServerResponseModel({
    required this.articles,
    required this.cases,
    required this.services,
    required this.clinics,
    required this.doctor,
    required this.doctorAbouts,
    required this.socialContacts,
    required this.videos,
    required this.heroItems,
  });

  @override
  List<Object?> get props {
    return [
      articles,
      cases,
      services,
      clinics,
      doctor,
      doctorAbouts,
      socialContacts,
      videos,
      heroItems,
    ];
  }
}
