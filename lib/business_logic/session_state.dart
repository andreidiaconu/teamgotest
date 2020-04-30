import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:teamgotest/model/user.dart';

class SessionState extends Equatable {
  final User currentUser;

  const SessionState({@required this.currentUser});

  @override
  List<Object> get props => [currentUser];
}
