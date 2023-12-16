enum Roles {
  guest('guest', 0, 'Guest'),
  admin('admin', 1, 'Admin'),
  student('student', 2, 'Student'),
  mentor('mentor', 3, 'Mentor'),
  coMentor('coMentor', 4, 'Co-Mentor'),
  volunteer('volunteer', 5, 'Volunteer'),
  parent('parent', 6, 'Parent');

  final String value;
  final int id;
  final String name;
  const Roles(this.value, this.id, this.name);

  @override
  String toString() => name;

  factory Roles.fromId(int? id) {
    switch (id) {
      case 1:
        return Roles.admin;
      case 2:
        return Roles.student;
      case 3:
        return Roles.mentor;
      case 4:
        return Roles.coMentor;
      case 5:
        return Roles.volunteer;
      case 6:
        return Roles.parent;
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
