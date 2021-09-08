import 'package:flutter_test/flutter_test.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:state_management_demo/login/bloc/login_bloc.dart';
import 'package:state_management_demo/login/bloc/login_event.dart';
import 'package:state_management_demo/login/bloc/login_state.dart';

void main() {
  group('LoginTest', () {
    blocTest(
      'emits success',
      build: () => LoginBloc(),
      act: (LoginBloc bloc) => bloc.add(const SignInWithEmailAndPassword()),
      expect: () => [
        LoginState(
          email: '',
          password: '',
          status: LoginStatus.loading,
        ),
        LoginState(
          email: '',
          password: '',
          status: LoginStatus.success,
        ),
      ],
    );
  });
}
