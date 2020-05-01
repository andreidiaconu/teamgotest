import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:teamgotest/model/activity.dart';
import 'package:teamgotest/model/user.dart';

class ActivityDetailsLarge extends StatelessWidget {
  final Activity activity;

  const ActivityDetailsLarge({Key key, this.activity}) : super(key: key);
  
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:
      const EdgeInsets.only(top: 16, left: 16, right: 16, bottom: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: _firstRow(context),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 8.0, bottom: 8.0),
            child: Text(
              activity.title,
              style: Theme.of(context).textTheme.headline5,
            ),
          ),
          Text(
            activity.description,
            style: Theme.of(context).textTheme.bodyText2,
            maxLines: 2,
            softWrap: false,
            overflow: TextOverflow.ellipsis,
          ),
          Row(
            children: [
              Icon(
                Icons.location_on,
                size: 16,
              ),
              SizedBox(width: 8),
              Text(
                activity.locationName ?? "No location yet",
                style: Theme.of(context).textTheme.bodyText1,
              ),
              Expanded(child: Container()),
              FlatButton.icon(
                  onPressed: () {},
                  icon: Icon(Icons.done),
                  label: Text("Going")),
            ],
          ),
        ],
      ),
    );
  }

  List<Widget> _firstRow(BuildContext context) {
    List<Widget> result = List();
    result.add(
      SizedBox(
        width: 48,
        height: 48,
        child: CircleAvatar(
          backgroundImage: NetworkImage(activity.author.avatar),
        ),
      ),
    );
    result.addAll(_attendingList());
    result.addAll(_nonAttendingList());
    result.add(Expanded(child: Container()));
    result.add(
      Text(
        DateFormat("HH:dd  •  d MMM").format(activity.startDate),
        style: Theme.of(context).textTheme.bodyText1,
      ),
    );
    return result;
  }

  List<Widget> _attendingList() {
    return activity.attendingUsers
        .map<Widget>(
          (e) => Container(
        width: 32,
        height: 32,
        padding: EdgeInsets.all(2.0),
        child: CircleAvatar(
          backgroundImage: NetworkImage(e.avatar),
        ),
      ),
    )
        .toList();
  }

  List<Widget> _nonAttendingList() {
    List<User> nonAttending = activity.invitedUsers
        .where((element) => !activity.attendingUsers.contains(element))
        .toList();
    return nonAttending
        .map<Widget>(
          (e) => Opacity(
        opacity: 0.5,
        child: Container(
          width: 32,
          height: 32,
          padding: EdgeInsets.all(2.0),
          child: CircleAvatar(
            backgroundImage: NetworkImage(e.avatar),
          ),
        ),
      ),
    )
        .toList();
  }
}