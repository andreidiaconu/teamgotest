import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:teamgotest/business_logic/activity_feed_bloc.dart';
import 'package:teamgotest/business_logic/session_state.dart';
import 'package:teamgotest/model/activity.dart';

class ActivityEditScreen extends StatefulWidget {
  final Activity activity;

  const ActivityEditScreen({Key key, this.activity}) : super(key: key);

  @override
  _ActivityEditScreenState createState() => _ActivityEditScreenState();
}

class _ActivityEditScreenState extends State<ActivityEditScreen> {
  TextEditingController titleController;
  TextEditingController descriptionController;
  TextEditingController locationController;

  @override
  void initState() {
    titleController = TextEditingController(text: widget.activity?.title ?? "");
    descriptionController =
        TextEditingController(text: widget.activity?.description ?? "");
    locationController =
        TextEditingController(text: widget.activity?.locationName ?? "");
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Edit activity"),
        actions: [
          IconButton(
            icon: Icon(Icons.done),
            onPressed: () => _updateActivity(context),
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: titleController,
              decoration: InputDecoration(labelText: "Title"),
            ),
            TextField(
              controller: descriptionController,
              decoration: InputDecoration(labelText: "Description"),
            ),
            TextField(
              controller: locationController,
              decoration: InputDecoration(labelText: "Location"),
            ),
          ],
        ),
      ),
    );
  }

  /// Normally, this screen would be a bit more complex and it would have its
  /// own bloc, that would possibly talk to other blocs if needed.
  /// For now, this also works.
  Future<void> _updateActivity(BuildContext context) async {
    ActivityFeedBloc bloc = Provider.of<ActivityFeedBloc>(context, listen: false);
    SessionState session = Provider.of<SessionState>(context, listen: false);
    if (widget.activity == null) {
      bloc.addNewActivity(Activity(
        id: _id(),
        title: titleController.value.text,
        description: descriptionController.value.text,
        author: session.currentUser,
        locationName: locationController.value.text,
        startDate:
            DateTime.now().add(Duration(days: 2)), // Create a picker for this
        attendingUsers: List(),
        invitedUsers: List(),
        lastMessages: List(),
      ));
    } else {
      bloc.updateActivity(widget.activity.copyWith(
        title: titleController.value.text,
        description: descriptionController.value.text,
        locationName: locationController.value.text,
      ));
    }
    Navigator.of(context).pop();
  }

  /// Or include a UUID library and use it
  String _id() {
    final dictionary = 'ABCDEFGHIJKLMNOPQRSTUVXZ0123456789';
    var result = '';
    for (int i = 0; i < 16; i++) {
      result += dictionary[Random().nextInt(dictionary.length)];
    }
    return result;
  }
}

class ActivityEditScreenRouteArguments extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final Activity activity = ModalRoute.of(context).settings.arguments;
    return ActivityEditScreen(
      activity: activity,
    );
  }
}
