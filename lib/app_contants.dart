import 'package:flutter/foundation.dart';

const baseUrl = 'http://54.173.149.224:9000/pathshala';

enum Roles {
  guest('guest', 0, 'Guest'),
  student('student', 1, 'Student'),
  mentor('mentor', 2, 'Mentor'),
  admin('admin', 3, 'Admin'),
  volunteer('volunteer', 4, 'Volunteer'),
  member('member', 5, 'Member'),
  parent('parent', 6, 'Parent'),
  swadhyay('swadhyay', 7, 'Swadhyay');

  final String value;
  final int id;
  final String name;
  const Roles(this.value, this.id, this.name);

  @override
  String toString() => name;

  factory Roles.fromId(int? id) {
    switch (id) {
      case 1:
        return Roles.student;
      case 2:
        return Roles.mentor;
      case 3:
        return Roles.admin;
      case 4:
        return Roles.volunteer;
      case 5:
        return Roles.member;
      case 6:
        return Roles.parent;
      case 7:
        return Roles.swadhyay;
      default:
        return Roles.guest;
    }
  }
}

const bloodGroups = [
  'A+',
  'A-',
  'B+',
  'B-',
  'O+',
  'O-',
  'AB+',
  'AB-',
];

const genderOptions = [
  'Female',
  'Male',
  'Other',
];

const genderPlaceholderImages = {
  'Male': 'https://ik.imagekit.io/1sqz4p2iv/man.png?updatedAt=1702667862171',
  'Female':
      'https://ik.imagekit.io/1sqz4p2iv/woman.png?updatedAt=1702667862124',
  'Others':
      'https://ik.imagekit.io/1sqz4p2iv/Others.png?updatedAt=1702667862164',
  '': 'https://ik.imagekit.io/1sqz4p2iv/user.png?updatedAt=1702712126752',
};

const categoryOptions = [
  'Festival',
  'Historical',
  'Moral Values',
  'Story',
  'Topic',
];
