import 'package:meta/meta.dart';

@immutable
abstract class RegisterEvent {}

class Register extends RegisterEvent {
  final String email;
  final String password;

  Register({@required this.email, @required this.password});
}
