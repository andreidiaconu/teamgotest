import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:teamgotest/business_logic/activity_feed_bloc.dart';
import 'package:teamgotest/business_logic/activity_feed_state.dart';
import 'package:teamgotest/model/activity.dart';
import 'package:teamgotest/routing.dart';

class ActivityFeedScreen extends StatefulWidget {
  @override
  _ActivityFeedScreenState createState() => _ActivityFeedScreenState();
}

class _ActivityFeedScreenState extends State<ActivityFeedScreen> {
  @override
  void didChangeDependencies() {
    ActivityFeedBloc bloc = Provider.of<ActivityFeedBloc>(context);
    bloc.loadActivityFeed();
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    ActivityFeedBloc bloc = Provider.of<ActivityFeedBloc>(context);
    return Scaffold(
      body: StreamBuilder<ActivityFeedState>(
        stream: bloc.outputStream,
        initialData: ActivityFeedState.initial(),
        builder: (context, snapshot) => ActivityFeed(
          data: snapshot.data.feed,
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).pushNamed(Routes.ACTIVITY_CREATE);
        },
        tooltip: 'Add Activity',
        child: Icon(Icons.add),
      ),
    );
  }
}

class ActivityFeed extends StatelessWidget {
  final List<Activity> data;

  const ActivityFeed({Key key, this.data}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: data.length,
      itemBuilder: (context, index) => ActivityFeedItem(
        activity: data[index],
      ),
    );
  }
}

class ActivityFeedItem extends StatelessWidget {
  final Activity activity;

  const ActivityFeedItem({Key key, this.activity}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: (){
        Routes.openActivityDetails(context, activity.id);
      },
      child: Container(
        padding: const EdgeInsets.only(left: 16.0, right: 16.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Stack(
              children: [
                SizedBox(
                  width: 48,
                  height: 48,
                  child: CircleAvatar(
                    backgroundImage: NetworkImage(activity.author.avatar),
                  ),
                ),
                Positioned(
                  bottom: 0,
                  right: 0,
                  child: Container(
                    decoration: ShapeDecoration(
                        shape: CircleBorder(), color: Colors.black),
                    child: Padding(
                      padding: const EdgeInsets.all(4.0),
                      child: Text("+${activity.invitedUsers.length}",
                          style: Theme.of(context)
                              .textTheme
                              .caption
                              .copyWith(color: Colors.white)),
                    ),
                  ),
                )
              ],
            ),
            SizedBox(
              width: 16,
            ),
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                  border: Border(
                    bottom: BorderSide(
                      width: 0.0,
                      color: Colors.grey.shade400,
                    ),
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 22.0),
                    Text(
                      _overlineText(),
                      style: Theme.of(context).textTheme.overline,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 4.0, bottom: 4.0),
                      child: Text(
                        activity.title,
                        style: Theme.of(context).textTheme.subtitle1,
                        maxLines: 1,
                        softWrap: false,
                        overflow: TextOverflow.fade,
                      ),
                    ),
                    Text(activity.description,
                        style: Theme.of(context).textTheme.caption,
                        maxLines: 2,
                        softWrap: false,
                        overflow: TextOverflow.ellipsis),
                    SizedBox(height: 22.0),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  String _overlineText() {
    String time = DateFormat("d MMM HH:mm").format(activity.startDate);
    return "${activity.attendingUsers.length} Confirmed   •  $time"
        .toUpperCase();
  }
}
