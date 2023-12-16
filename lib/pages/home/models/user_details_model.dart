class UserDetailsModel {
  final int id;
  final String username;
  final String email;
  final UserProfile profile;

  UserDetailsModel({
    required this.id,
    required this.username,
    required this.email,
    required this.profile,
  });

  factory UserDetailsModel.fromJson(Map<String, dynamic> json) {
    return UserDetailsModel(
      id: json['id'] ?? 0,
      username: json['username'] ?? '',
      email: json['email'] ?? '',
      profile: UserProfile.fromJson(json['profile'] ?? {}),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'username': username,
      'email': email,
      'profile': profile.toJson(),
    };
  }
}

class UserProfile {
  final int id;
  final String firstName;
  final String middleName;
  final String lastName;
  final String dob;
  final String phone;
  final String alias;
  final String email;
  final String bloodGroup;
  final dynamic profilePicture;
  final String gender;
  final List<int> groups;

  UserProfile({
    required this.id,
    required this.firstName,
    required this.middleName,
    required this.lastName,
    required this.dob,
    required this.phone,
    required this.alias,
    required this.email,
    required this.bloodGroup,
    required this.profilePicture,
    required this.gender,
    required this.groups,
  });

  factory UserProfile.fromJson(Map<String, dynamic> json) {
    return UserProfile(
      id: json['id'] ?? 0,
      firstName: json['first_name'] ?? '',
      middleName: json['middle_name'] ?? '',
      lastName: json['last_name'] ?? '',
      dob: json['dob'] ?? '',
      phone: json['phone'] ?? '',
      alias: json['alias'] ?? '',
      email: json['email'] ?? '',
      bloodGroup: json['blood_group'] ?? '',
      gender: json['gender'] ?? '',
      profilePicture: json['profile_picture'] ?? '',
      groups: (List<int>.from(json['groups'] ?? [])),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'first_name': firstName,
      'middle_name': middleName,
      'last_name': lastName,
      'dob': dob,
      'phone': phone,
      'alias': alias,
      'email': email,
      'blood_group': bloodGroup,
      'gender': gender,
      'profile_picture': profilePicture,
      'groups': groups,
    };
  }
}
