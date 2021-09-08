import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:state_management_demo/login/bloc/login_event.dart';
import 'package:state_management_demo/login/bloc/login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  LoginBloc() : super(const LoginState(email: '', password: ''));

  @override
  Stream<LoginState> mapEventToState(LoginEvent event) async* {
    if (event is LoginEmailChanged) {
      yield* _mapLoginEmailChanged(event);
    } else if (event is LoginPasswordChanged) {
      yield* _mapLoginPasswordChanged(event);
    } else if (event is SignInWithEmailAndPassword) {
      yield* _mapSignInWithEmailAndPassword(event);
    }
  }

  Stream<LoginState> _mapLoginEmailChanged(LoginEmailChanged event) async* {
    final email = event.email;
    bool valid = _isValidForm(
      state.copyWith(
        email: email,
      ),
    );
    yield state.copyWith(
      email: email,
      isValidForm: valid,
    );
  }

  Stream<LoginState> _mapLoginPasswordChanged(
      LoginPasswordChanged event) async* {
    final password = event.password;
    bool valid = _isValidForm(
      state.copyWith(
        password: password,
      ),
    );
    yield state.copyWith(
      password: password,
      isValidForm: valid,
    );
  }

  Stream<LoginState> _mapSignInWithEmailAndPassword(
      SignInWithEmailAndPassword event) async* {
    yield state.copyWith(status: LoginStatus.loading);
    await Future.delayed(const Duration(seconds: 3));
    yield state.copyWith(status: LoginStatus.success);
  }

  bool _isValidForm(LoginState state) {
    return state.email.length > 0;
  }
}
