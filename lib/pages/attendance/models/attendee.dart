class Attendee {
  Attendee({
    required this.id,
    required this.name,
    this.alias,
    this.isPresent = false,
    required this.profileId,
  });

  String id;
  String name;
  String? alias;
  bool isPresent;
  String profileId;
}
