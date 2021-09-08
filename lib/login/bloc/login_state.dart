import 'package:equatable/equatable.dart';

enum LoginStatus { initial, loading, success }

class LoginState extends Equatable {
  const LoginState({
    required this.email,
    required this.password,
    this.isValidForm = false,
    this.status = LoginStatus.initial,
  });

  final String email;
  final String password;
  final bool isValidForm;
  final LoginStatus status;

  LoginState copyWith({
    String? email,
    String? password,
    bool? isValidForm,
    LoginStatus? status,
  }) {
    return LoginState(
      email: email ?? this.email,
      password: password ?? this.password,
      isValidForm: isValidForm ?? this.isValidForm,
      status: status ?? this.status,
    );
  }

  @override
  List<Object?> get props => [
        email,
        password,
        isValidForm,
        status,
      ];
}
