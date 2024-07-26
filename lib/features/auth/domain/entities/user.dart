// ignore_for_file: must_be_immutable

import 'package:equatable/equatable.dart';

class User extends Equatable implements Comparable<User> {
  final String? userId;
  final String? registeredEmail;
  final String? name;

  const User({this.userId, this.registeredEmail,  this.name});

  @override
  List<Object?> get props => [
        userId,
        registeredEmail,
        name,
      ];

  @override
  int compareTo(User other) {
    return registeredEmail!.compareTo(other.registeredEmail!);
  }
}
