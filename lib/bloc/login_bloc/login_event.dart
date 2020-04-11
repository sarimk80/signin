import 'package:meta/meta.dart';

@immutable
abstract class LoginEvent {}

class Fetch extends LoginEvent {
  final String email;
  final String password;

  Fetch({@required this.email, @required this.password});
}
