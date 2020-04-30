import 'package:flutter/widgets.dart';
import 'package:teamgotest/ui/activity_details_screen.dart';
import 'package:teamgotest/ui/activity_feed_screen.dart';

class Routes {
  static const String HOME = "/";
  static const String ACTIVITY_DETAILS = "/activity_details";
  static const String ACTIVITY_CREATE = "/activity_create";
  static const String ACTIVITY_EDIT = "/activity_edit";

  static Map<String, WidgetBuilder> generateRoutes() => {
    HOME: (_) => ActivityFeedScreen(),
    ACTIVITY_DETAILS: (_) => ActivityDetailsScreen(),
    ACTIVITY_CREATE: (_) => ActivityDetailsScreen(),
    ACTIVITY_EDIT: (_) => ActivityDetailsScreen(),
  };

  static Future<void> openActivityDetails(BuildContext context, String activityId) {
    return Navigator.of(context).pushNamed(ACTIVITY_DETAILS, arguments: activityId);
  }

  static Future<void> openActivityEdit(BuildContext context, String activityId) {
    return Navigator.of(context).pushNamed(ACTIVITY_EDIT, arguments: activityId);
  }
}