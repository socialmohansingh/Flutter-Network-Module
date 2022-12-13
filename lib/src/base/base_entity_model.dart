abstract class Entity {}

abstract class EntityParser<T extends Entity> {
  T parseObject(Map<String, dynamic> json);
}
