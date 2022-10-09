import 'package:equatable/equatable.dart';

abstract class Entity extends Equatable {
  Entity fromJson(Map<String, dynamic> json);
}

abstract class EntityObjectParser<T extends Entity> {
  T parseObject(Map<String, dynamic> json);
}

abstract class EntityListParser<T extends Entity> {
  List<T> parseList(Map<String, dynamic> json);
}
