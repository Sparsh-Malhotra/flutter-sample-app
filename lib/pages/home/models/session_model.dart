class SessionModel {
  int id;
  BhaagClassSectionModel bhaagClassSection;
  String date;
  String mode;

  SessionModel(
      {required this.id,
      required this.bhaagClassSection,
      required this.date,
      required this.mode});

  factory SessionModel.fromJson(Map<String, dynamic> json) {
    return SessionModel(
      id: json['id'],
      bhaagClassSection:
          BhaagClassSectionModel.fromJson(json['bhaag_class_section']),
      date: json['date'],
      mode: json['mode'],
    );
  }
}

class BhaagClassSectionModel {
  int id;
  BhaagClassModel bhaagClass;
  String section;

  BhaagClassSectionModel(
      {required this.id, required this.bhaagClass, required this.section});

  factory BhaagClassSectionModel.fromJson(Map<String, dynamic> json) {
    return BhaagClassSectionModel(
      id: json['id'],
      bhaagClass: BhaagClassModel.fromJson(json['bhaag_class']),
      section: json['section'],
    );
  }
}

class BhaagClassModel {
  int id;
  BhaagCategoryModel bhaagCategory;
  LocationModel location;

  BhaagClassModel(
      {required this.id, required this.bhaagCategory, required this.location});

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

  BhaagCategoryModel({required this.bhaag, required this.category});

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

  BhaagModel({required this.id, required this.name, required this.book});

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
