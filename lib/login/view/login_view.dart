import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:state_management_demo/login/bloc/login_bloc.dart';
import 'package:state_management_demo/login/bloc/login_event.dart';
import 'package:state_management_demo/login/bloc/login_state.dart';

class LoginView extends StatelessWidget {
  const LoginView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("State management demo"),
      ),
      body: BlocConsumer<LoginBloc, LoginState>(
        listenWhen: (previous, current) => previous.status != current.status,
        listener: (BuildContext context, LoginState state) {
          if (state.status == LoginStatus.success) {
            ScaffoldMessenger.of(context)
              ..hideCurrentSnackBar()
              ..showSnackBar(
                SnackBar(
                  content: Text('Success!'),
                  behavior: SnackBarBehavior.floating,
                  duration: const Duration(seconds: 5),
                ),
              );
          }
        },
        buildWhen: (previous, current) => previous.status != current.status,
        builder: (BuildContext context, LoginState state) {
          if (state.status == LoginStatus.loading) {
            return Center(child: CircularProgressIndicator());
          }
          return _LoginForm();
        },
      ),
    );
  }
}

class _LoginForm extends StatelessWidget {
  const _LoginForm({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Center(
        child: ListView(
          children: [
            SizedBox(height: 20),
            _EmailTextField(),
            SizedBox(height: 20),
            _PasswordTextField(),
            SizedBox(height: 40),
            _LoginButton(),
          ],
        ),
      ),
    );
  }
}

class _EmailTextField extends StatelessWidget {
  const _EmailTextField({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LoginBloc, LoginState>(
      buildWhen: (previous, current) => previous.email != current.email,
      builder: (BuildContext context, LoginState state) {
        return TextField(
          onChanged: (newEmail) => context.read<LoginBloc>().add(
                LoginEmailChanged(email: newEmail),
              ),
          decoration: InputDecoration(
            hintText: 'Email',
          ),
        );
      },
    );
  }
}

class _PasswordTextField extends StatelessWidget {
  const _PasswordTextField({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LoginBloc, LoginState>(
      buildWhen: (previous, current) => previous.password != current.password,
      builder: (BuildContext context, LoginState state) {
        return TextField(
          onChanged: (newPassword) => context.read<LoginBloc>().add(
                LoginPasswordChanged(password: newPassword),
              ),
          decoration: InputDecoration(
            hintText: 'Password',
          ),
        );
      },
    );
  }
}

class _LoginButton extends StatelessWidget {
  const _LoginButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final active = context.select((LoginBloc bloc) => bloc.state.isValidForm);
    return ElevatedButton(
      onPressed: active
          ? () => context.read<LoginBloc>().add(SignInWithEmailAndPassword())
          : null,
      child: Text("Login"),
    );
  }
}
