import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:teamgotest/business_logic/activity_details_bloc.dart';
import 'package:teamgotest/business_logic/activity_details_state.dart';
import 'package:teamgotest/business_logic/session_state.dart';
import 'package:teamgotest/model/activity.dart';
import 'package:teamgotest/repository/activity_repository.dart';
import 'package:teamgotest/routing.dart';
import 'package:teamgotest/ui/activity/ActivityDetailsLarge.dart';

import 'conversation/message_list.dart';

class ActivityDetailsScreen extends StatefulWidget {
  final String activityId;

  const ActivityDetailsScreen({Key key, this.activityId}) : super(key: key);

  @override
  _ActivityDetailsScreenState createState() => _ActivityDetailsScreenState();
}

class _ActivityDetailsScreenState extends State<ActivityDetailsScreen> {
  ActivityDetailsBloc bloc;

  @override
  void didChangeDependencies() {
    ActivityRepository repository = Provider.of<ActivityRepository>(context);
    bloc = ActivityDetailsBloc(
      activityRepository: repository,
      activityId: widget.activityId,
    );
    bloc.init();
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<ActivityDetailsState>(
      stream: bloc.outputStream,
      builder: (context, snapshot) => snapshot.data.loading
          ? Scaffold(
              appBar: AppBar(),
              body: Center(child: CircularProgressIndicator()))
          : ActivityDetailsScreenLoaded(activity: snapshot.data.activity),
    );
  }
}

class ActivityDetailsScreenLoaded extends StatelessWidget {
  final Activity activity;

  const ActivityDetailsScreenLoaded({Key key, this.activity}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SessionState session = Provider.of<SessionState>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text(activity.title),
        actions: [
          if (activity.author.id == session.currentUser.id)
            IconButton(
              icon: Icon(Icons.edit),
              onPressed: () {
                Routes.openActivityEdit(context, activity.id);
              },
            )
        ],
      ),
      body: Column(
        children: [
          ActivityDetailsLarge(activity: activity),
          Container(
            height: 0,
            width: double.infinity,
            decoration: BoxDecoration(
              border: Border(
                bottom: BorderSide(
                  width: 0.0,
                  color: Colors.grey.shade400,
                ),
              ),
            ),
          ),
          Expanded(
            child: MessagesList(
              messages: activity.lastMessages,
            ),
          ),
          Material(
            color: Theme.of(context).colorScheme.background,
            child: SafeArea(
              minimum: EdgeInsets.only(left: 16, top: 12, bottom: 12),
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                      decoration: InputDecoration(
                        contentPadding: EdgeInsets.only(left: 8, right: 8),
                        border: OutlineInputBorder(
                          borderSide: BorderSide.none,
                        ),
                        fillColor: Colors.white,
                        filled: true,
                      ),
                    ),
                  ),
                  IconButton(
                    padding: EdgeInsets.all(16),
                    icon: Icon(Icons.send),
                    onPressed: () {},
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class ActivityDetailsScreenRouteArguments extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final String activityId = ModalRoute.of(context).settings.arguments;
    return ActivityDetailsScreen(
      activityId: activityId,
    );
  }
}
