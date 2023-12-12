class Attendee {
  Attendee(
      {required this.id,
      required this.name,
      this.alias,
      this.isPresent = false});

  String id;
  String name;
  String? alias;
  bool isPresent;
}
