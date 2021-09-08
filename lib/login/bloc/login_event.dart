import 'package:equatable/equatable.dart';

abstract class LoginEvent extends Equatable {
  const LoginEvent();
}

class LoginEmailChanged extends LoginEvent {
  const LoginEmailChanged({required this.email});
  final String email;

  @override
  List<Object?> get props => [email];
}

class LoginPasswordChanged extends LoginEvent {
  const LoginPasswordChanged({required this.password});
  final String password;

  @override
  List<Object?> get props => [password];
}

class SignInWithEmailAndPassword extends LoginEvent {
  const SignInWithEmailAndPassword();

  @override
  List<Object?> get props => [];
}
