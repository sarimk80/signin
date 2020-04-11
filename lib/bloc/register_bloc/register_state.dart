import 'package:meta/meta.dart';
import 'package:signin/model/register.dart';


@immutable
abstract class RegisterState {}

class InitialRegisterState extends RegisterState {}

class LoadingRegisterState extends RegisterState {}

class LoadedRegisterState extends RegisterState {
  final Register response;

  LoadedRegisterState({@required this.response});
}

class ErrorRegisterState extends RegisterState {
  final String error;

  ErrorRegisterState({@required this.error});
}
