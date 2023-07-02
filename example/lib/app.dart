import 'package:flutter/material.dart';
import 'package:flutter_core/flutter_core.dart';
import 'package:flutter_netwok_module/flutter_netwok_module.dart';

class AppScreen extends StatelessWidget {
  const AppScreen({super.key});

  @override
  Widget build(BuildContext context) {
    setupNetwork();
    return const Placeholder();
  }

  setupNetwork() async {
    NetworkClient client = NetworkClient.fromConfig(MyNetworkConfig(
        baseURL: BaseURL(
          baseURL: "url",
        ),
        adapters: []));
    var res = await client.request<User>(SamplePath(
        parser: SampleEntityParser(),
        bodyParams: {"email": "sdf", "password": "sdf"}));
    res.fold((l) => print(l.message), (r) => print(r.object));
  }
}

class MyNetworkConfig extends NetworkConfiguration {
  MyNetworkConfig({required super.baseURL, super.adapters});
}

class SamplePath extends RequestApi {
  SamplePath({required super.parser, super.bodyParams});

  @override
  String get endPath => "employee/auth/login";
  @override
  // TODO: implement method
  HTTPMethod get method => HTTPMethod.post;
}

class SampleEntity extends Entity {
  String objectId = "20";

  @override
  Map<String, dynamic> toJson() {
    // TODO: implement toJson
    throw UnimplementedError();
  }
}

class SampleEntityParser extends EntityParser<SampleEntity> {
  @override
  SampleEntity parseObject(Map<String, dynamic> json) {
    return SampleEntity();
  }
}

class User extends Entity {
  final int id;
  String? firstName;
  String? lastName;

  User({
    required this.id,
    this.firstName,
    this.lastName,
  });

  factory User.fromJson(Map<String, dynamic> map) {
    final userJson = map["data"] as Map<String, dynamic>;

    return User(
      id: userJson["id"] as int,
      firstName: userJson["firstName"] as String?,
      lastName: userJson["lastName"] as String?,
    );
  }

  @override
  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    return json;
  }
}
