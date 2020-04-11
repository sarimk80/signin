import 'dart:async';
import 'dart:convert';
import 'package:bloc/bloc.dart';
import 'package:chopper/chopper.dart';
import 'package:signin/model/Login.dart';
import 'package:signin/service/ApiService.dart';
import 'bloc.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  @override
  LoginState get initialState => InitialLoginState();

  @override
  Stream<LoginState> mapEventToState(LoginEvent event) async* {
    if (event is Fetch) {
      Map<String, dynamic> body = {
        "email": "eve.holt@reqres.in",
        "password": "cityslicka"
      };

      yield LoadingLoginState();

      try {
        final Response response = await ApiService.create().getResult(body);

        final Login _login = Login.fromJson(response.body);

        yield LoadedLoginState(login: _login);
      } catch (e) {
        yield ErrorLoginState(error: e.toString());
      }
    }
  }
}
