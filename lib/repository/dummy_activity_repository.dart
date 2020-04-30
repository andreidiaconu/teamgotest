import 'dart:math';

import 'package:teamgotest/model/activity.dart';
import 'package:teamgotest/model/conversation_message.dart';
import 'package:teamgotest/model/user.dart';
import 'package:teamgotest/repository/activity_repository.dart';

/// Simulates a server through an internal list
/// This would normally talk to an API with dio, retrofit, etc
class DummyActivityRepository extends ActivityRepository {
  List<Activity> _serverData;
  final int secondsOfDelay;

  DummyActivityRepository({this.secondsOfDelay = 1}) {
    final generator = _ActivityGenerator();
    _serverData = List();
    for (int i = 0; i < 50; i++) {
      _serverData.add(generator.next());
    }
  }

  @override
  Future<List<Activity>> getActivities() async {
    await Future.delayed(Duration(seconds: secondsOfDelay));
    return List.of(_serverData);
  }

  @override
  Future<void> createActivity(Activity activity) async {
    await Future.delayed(Duration(seconds: secondsOfDelay));
    _serverData.add(activity);
  }

  @override
  Future<void> updateActivity(Activity activity) async {
    await Future.delayed(Duration(seconds: secondsOfDelay));
    int index = _serverData.indexWhere((element) => element.id == activity.id);
    if (index != -1) {
      _serverData[index] = activity;
    } else {
      throw ArgumentError(
          "Server does not contain activity with id ${activity.id}");
    }
  }

  @override
  Future<void> deleteActivity(String activityId) async {
    await Future.delayed(Duration(seconds: secondsOfDelay));
    int index = _serverData.indexWhere((element) => element.id == activityId);
    if (index != -1) {
      _serverData.removeAt(index);
    } else {
      throw ArgumentError(
          "Server does not contain activity with id $activityId");
    }
  }
}

class _ActivityGenerator {
  Activity next() {
    List<User> invitedUsers = _users();
    List<User> attendingUsers = List.of(invitedUsers);
    attendingUsers.shuffle();
    attendingUsers =
        attendingUsers.sublist(0, Random().nextInt(attendingUsers.length));
    return Activity(
      id: _id(),
      title: _title(),
      description: _description(),
      locationName: _location(),
      author: _user(),
      startDate: _date(),
      invitedUsers: invitedUsers,
      attendingUsers: attendingUsers,
      lastMessages: _lastMessages(invitedUsers),
    );
  }

  String _id() {
    final dictionary = 'ABCDEFGHIJKLMNOPQRSTUVXZ0123456789';
    var result = '';
    for (int i = 0; i < 16; i++) {
      result += dictionary[Random().nextInt(dictionary.length)];
    }
    return result;
  }

  String _title() {
    int type = Random().nextInt(3);
    List<String> titles;
    List<String> names;
    if (type == 0) {
      names = [
        'ride a bike',
        'swimming',
        'jogging',
        'for a stadium lap',
        'on a beach jog',
        'do yoga'
      ];

      titles = [
        'Let\'s go 💪 ',
        'We need to go ',
        'Who wants to go ',
      ];
    } else if (type == 1) {
      names = [
        'Puzzles',
        'Central Perk',
        'MacLaren’s',
        'Moe’s Tavern',
        'Monk\'s Café'
            'Basement Taverna',
      ];

      titles = [
        'Grab a drink at ',
        'Coffe time ☕️ ',
        'Bday party 🎂 ',
        'Karaoke night at ',
      ];
    } else {
      names = [
        'Catan',
        'Monopoly',
        'God of War',
        'Scrabble',
        'Cluedo',
        'Jenga',
        'Cads Against Humanity',
      ];

      titles = [
        'Who wants to play ',
        'Who\'s up for ',
        'Nachos, drinks 🍸 and ',
        'Come over for ',
      ];
    }
    String title = titles[Random().nextInt(titles.length)];
    String name = names[Random().nextInt(names.length)];
    return title + name;
  }

  String _description() {
    List<String> descriptions = [
      'I miss you guys. We should get together.',
      'Can\'t wait to see everyone! 😍',
      'Join us. It\'s gonna be fun.',
      'I know we talked about this for quite some time now. I hope you\'ll be there.',
      'I might not make it myself, but I\'m sure this event won\'t go unnoticed.',
      'Is this how this app works? I\'m trying to set my status. Is this it?',
    ];
    return descriptions[Random().nextInt(descriptions.length)];
  }

  String _location() {
    List<String> locations = [
      "Downtown",
      "Town hall",
      "Mike's place",
      "Trif Mall",
      null
    ];
    return locations[Random().nextInt(locations.length)];
  }

  User _user() {
    List<User> users = _users();
    return users[Random().nextInt(users.length)];
  }

  List<User> _users() {
    List<User> users = [
      User(
        id: 'ADEDF5223DDF335GDW',
        name: 'Andrew',
        avatar:
            "https:\/\/tinyfac.es\/data\/avatars\/AEF44435-B547-4B84-A2AE-887DFAEE6DDF-200w.jpeg",
      ),
      User(
        id: 'DGYREWG7D8355FD2RG',
        name: 'Louis',
        avatar:
            "https:\/\/tinyfac.es\/data\/avatars\/B3CF5288-34B0-4A5E-9877-5965522529D6-200w.jpeg",
      ),
      User(
        id: 'FJDUIKF358F8DJ29IF',
        name: 'Joey',
        avatar:
            "https:\/\/tinyfac.es\/data\/avatars\/26CFEFB3-21C8-49FC-8C19-8E6A62B6D2E0-200w.jpeg",
      ),
      User(
        id: 'F38DDJFUEO8DJSD8FD',
        name: 'Sabrina',
        avatar:
            "https:\/\/tinyfac.es\/data\/avatars\/A7299C8E-CEFC-47D9-939A-3C8CA0EA4D13-200w.jpeg",
      ),
      User(
        id: 'FJDUIKF358F8DJ29IF',
        name: 'Martha',
        avatar:
            "https:\/\/tinyfac.es\/data\/avatars\/03F55412-DE8A-4F83-AAA6-D67EE5CE48DA-200w.jpeg",
      ),
      User(
        id: 'ER6Y2RF8GD4FHYU4FD',
        name: 'Mark',
        avatar:
            "https:\/\/tinyfac.es\/data\/avatars\/2DDDE973-40EC-4004-ABC0-73FD4CD6D042-200w.jpeg",
      ),
    ];
    users.shuffle();
    return users.sublist(0, Random().nextInt(users.length - 1) + 1);
  }

  DateTime _date() {
    return DateTime.now().add(Duration(days: Random().nextInt(6) + 1));
  }

  List<ConversationMessage> _lastMessages(List<User> users) {
    List<String> messages = [
      'Yes!',
      'If you know what I mean',
      'Now that is what I call a party!',
      'I know what you\'re thinking, but no, I did not type that - it was my cat 😂',
      '❤️❤️❤️',
      'I wish this thing had reactions, so I could give you a big heart ❤️',
      'It\'s funny how we never make sense in these conversations',
      'You tell me, brother! 🙄',
      '🤔 Are you 100% on that?',
      'FUN TIIIIMEEEEESSSS!!!',
    ];
    List<ConversationMessage> result = List();
    int messageCount = Random().nextInt(4) + 1;
    for (int i = 0; i < messageCount; i++) {
      result.add(
        ConversationMessage(
          author: users[Random().nextInt(users.length)],
          message: messages[Random().nextInt(messages.length)],
          time: DateTime.now()
              .subtract(Duration(minutes: Random().nextInt(10) + i * 10)),
        ),
      );
    }
    return result;
  }
}
