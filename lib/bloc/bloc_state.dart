import 'package:equatable/equatable.dart';

abstract class UserState extends Equatable {
  @override
  List<Object?> get props => [];
}

class UsersInitial extends UserState {}

class UsersLoaded extends UserState {
  final List<dynamic> users;

  UsersLoaded({required this.users});

  @override
  List<Object?> get props => [users];
}

class UsersError extends UserState {
  final String message;

  UsersError({required this.message});

  @override
  List<Object?> get props => [message];
}
