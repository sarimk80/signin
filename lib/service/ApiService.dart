import 'package:chopper/chopper.dart';
import 'package:signin/model/Login.dart';

part 'ApiService.chopper.dart';

@ChopperApi()
abstract class ApiService extends ChopperService {
  @Post(path: "/login")
  Future<Response> getResult(@Body() Map<String, dynamic> body);

  @Post(path: "/register")
  Future<Response> registerUser(@Body() Map<String, dynamic> body);

  static ApiService create() {
    final client = ChopperClient(
        baseUrl: "https://reqres.in/api",
        services: [_$ApiService()],
        converter: JsonConverter(),
        errorConverter: JsonConverter());
    return _$ApiService(client);
  }
}
