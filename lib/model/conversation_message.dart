import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:teamgotest/model/user.dart';

@immutable
class ConversationMessage extends Equatable{
  final User author;
  final String message;
  final DateTime time;

  ConversationMessage({
    @required this.author,
    @required this.message,
    @required this.time,
  });

  @override
  List<Object> get props => [author, message, time];
}