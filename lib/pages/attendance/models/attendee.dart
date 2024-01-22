class Attendee {
  Attendee({
    required this.id,
    required this.name,
    this.alias,
    this.isPresent = false,
    required this.profileId,
    required this.attendance,
  });

  String id;
  String name;
  String? alias;
  bool isPresent;
  String profileId;
  double attendance;
}
