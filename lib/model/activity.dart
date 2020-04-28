import 'package:flutter/foundation.dart';
import 'package:teamgotest/model/conversation_message.dart';
import 'package:teamgotest/model/user.dart';

@immutable
class Activity {
  final String id;
  final String title;
  final String description;
  final User author;
  final String locationName;
  final DateTime startDate;
  final List<User> invitedUsers;
  final List<User> attendingUsers;
  final List<ConversationMessage> lastMessages;

  const Activity({
    @required this.id,
    @required this.title,
    @required this.description,
    @required this.locationName,
    @required this.author,
    @required this.startDate,
    @required this.invitedUsers,
    @required this.attendingUsers,
    @required this.lastMessages,
  });

  Activity copyWith({
    String id,
    String title,
    String description,
    User author,
    String locationName,
    DateTime startDate,
    List<User> invitedUsers,
    List<User> attendingUsers,
    List<ConversationMessage> lastMessages,
  }) {
    return new Activity(
      id: id ?? this.id,
      title: title ?? this.title,
      description: description ?? this.description,
      author: author ?? this.author,
      locationName: locationName ?? this.locationName,
      startDate: startDate ?? this.startDate,
      invitedUsers: invitedUsers ?? this.invitedUsers,
      attendingUsers: attendingUsers ?? this.attendingUsers,
      lastMessages: lastMessages ?? this.lastMessages,
    );
  }

  @override
  String toString() {
    return 'Activity{id: $id, title: $title, description: $description, '
        'author: $author, locationName: $locationName, startDate: $startDate, '
        'invitedUsers: $invitedUsers, attendingUsers: $attendingUsers, '
        'lastMessages: $lastMessages}';
  }
}
