import 'dart:core';


class ProfileDomain {
  final String? id;
  final String userName;
  final String firstName;
  final String lastName;
  final String bio;
  final String profilePicture;


  ProfileDomain({
    this.id,
    required this.userName,
    required this.firstName,
    required this.lastName,
    required this.profilePicture,
    required this.bio,
  });
}