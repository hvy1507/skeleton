import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:skeleton/constant/status.k.dart';
import 'package:skeleton/ui/view/login/login.state.dart';

class LoginCubit extends Cubit<LoginState> {
  LoginCubit() : super(const LoginState()) {
    _listen();
  }

  final TextEditingController email = TextEditingController();
  final TextEditingController password = TextEditingController();

  Future<void> _listen() async {
    email.addListener(() {
      emit(state.copyWith(
        phoneNumber: email.text,
      ));
    });
    password.addListener(() {
      emit(state.copyWith(
        password: password.text,
      ));
    });
  }

  Future<void> login() async {
    final FirebaseAuth auth = FirebaseAuth.instance;
    emit(state.copyWith(status: Status.loading));
    try {
      await auth.signInWithEmailAndPassword(
        email: email.text,
        password: password.text,
      );
      emit(state.copyWith(status: Status.loaded));
    } on FirebaseAuthException catch (_) {
      emit(state.copyWith(status: Status.error));
    }
  }
}
