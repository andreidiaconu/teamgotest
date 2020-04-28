import 'package:flutter/foundation.dart';
import 'package:teamgotest/model/user.dart';

@immutable
class ConversationMessage {
  final User author;
  final String message;
  final DateTime time;

  ConversationMessage({
    @required this.author,
    @required this.message,
    @required this.time,
  });
}