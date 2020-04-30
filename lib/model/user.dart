import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';

@immutable
class User extends Equatable{
  final String id;
  final String name;
  final String avatar;

  User({
    @required this.id,
    @required this.name,
    @required this.avatar,
  });

  @override
  List<Object> get props => [id, name, avatar];
}