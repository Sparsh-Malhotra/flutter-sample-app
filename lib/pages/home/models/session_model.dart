import 'package:com.jainyouthnoida.pathshala/pages/home/models/user_details_model.dart';

class SessionModel {
  int id;
  DayMentorModel dayMentor;
  BhaagClassSectionModel bhaagClassSection;
  String date;
  String mode;
  String time;

  SessionModel({
    required this.id,
    required this.dayMentor,
    required this.bhaagClassSection,
    required this.date,
    required this.mode,
    required this.time,
  });

  factory SessionModel.fromJson(Map<String, dynamic> json) {
    return SessionModel(
      id: json['id'],
      dayMentor: DayMentorModel.fromJson(json['day_mentor']),
      bhaagClassSection:
          BhaagClassSectionModel.fromJson(json['bhaag_class_section']),
      date: json['date'],
      mode: json['mode'],
      time: json['time'],
    );
  }
}

class BhaagClassSectionModel {
  int id;
  BhaagClassModel bhaagClass;
  List<TeamModel> team;
  String section;

  BhaagClassSectionModel({
    required this.id,
    required this.bhaagClass,
    required this.team,
    required this.section,
  });

  factory BhaagClassSectionModel.fromJson(Map<String, dynamic> json) {
    final List<dynamic> teamArray = json['team'];

    return BhaagClassSectionModel(
      id: json['id'],
      bhaagClass: BhaagClassModel.fromJson(json['bhaag_class']),
      team: teamArray.map((team) => TeamModel.fromJson(team)).toList(),
      section: json['section'],
    );
  }
}

class BhaagClassModel {
  int id;
  BhaagCategoryModel bhaagCategory;
  LocationModel location;

  BhaagClassModel({
    required this.id,
    required this.bhaagCategory,
    required this.location,
  });

  factory BhaagClassModel.fromJson(Map<String, dynamic> json) {
    return BhaagClassModel(
      id: json['id'],
      bhaagCategory: BhaagCategoryModel.fromJson(json['bhaag_category']),
      location: LocationModel.fromJson(json['location']),
    );
  }
}

class BhaagCategoryModel {
  BhaagModel bhaag;
  String category;

  BhaagCategoryModel({
    required this.bhaag,
    required this.category,
  });

  factory BhaagCategoryModel.fromJson(Map<String, dynamic> json) {
    return BhaagCategoryModel(
      bhaag: BhaagModel.fromJson(json['bhaag']),
      category: json['category'],
    );
  }
}

class BhaagModel {
  int id;
  String name;
  String book;

  BhaagModel({
    required this.id,
    required this.name,
    required this.book,
  });

  factory BhaagModel.fromJson(Map<String, dynamic> json) {
    return BhaagModel(
      id: json['id'],
      name: json['name'],
      book: json['book'],
    );
  }
}

class LocationModel {
  String streetAddress;
  String city;
  String state;
  String country;

  LocationModel({
    required this.streetAddress,
    required this.city,
    required this.state,
    required this.country,
  });

  factory LocationModel.fromJson(Map<String, dynamic> json) {
    return LocationModel(
      streetAddress: json['street_address'],
      city: json['city'],
      state: json['state'],
      country: json['country'],
    );
  }
}

class DayMentorModel {
  int id;
  UserProfile profile;
  bool? isActive;

  DayMentorModel({
    required this.id,
    required this.profile,
    required this.isActive,
  });

  factory DayMentorModel.fromJson(Map<String, dynamic> json) {
    return DayMentorModel(
      id: json['id'],
      profile: UserProfile.fromJson(json['profile']),
      isActive: json['isActive'],
    );
  }
}

class TeamModel {
  int id;
  UserProfile profile;
  bool? isActive;

  TeamModel({
    required this.id,
    required this.profile,
    required this.isActive,
  });

  factory TeamModel.fromJson(Map<String, dynamic> json) {
    return TeamModel(
      id: json['id'],
      profile: UserProfile.fromJson(json['profile']),
      isActive: json['isActive'],
    );
  }
}

class MentorModel {
  String name;
  int id;

  MentorModel({required this.name, required this.id});
}
