import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:chopper/chopper.dart';
import 'package:signin/model/register.dart' as req;
import 'package:signin/service/ApiService.dart';
import './bloc.dart';

class RegisterBloc extends Bloc<RegisterEvent, RegisterState> {
  @override
  RegisterState get initialState => InitialRegisterState();

  @override
  Stream<RegisterState> mapEventToState(RegisterEvent event) async* {
    if (event is Register) {
      yield LoadingRegisterState();

      Map<String, dynamic> body = {
        "email": event.email,
        "password": event.password
      };

      try {
        final Response response = await ApiService.create().registerUser(body);

        final req.Register register = req.Register.fromJson(response.body);
        yield LoadedRegisterState(response: register);
      } catch (e) {
        yield ErrorRegisterState(error: e.toString());
      }
    }
  }
}
