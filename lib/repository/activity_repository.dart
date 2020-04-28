import 'package:teamgotest/model/activity.dart';

abstract class ActivityRepository {
  Future<List<Activity>> getActivities();
  Future<void> createActivity(Activity activity);
  Future<void> updateActivity(Activity activity);
  Future<void> deleteActivity(String activityId);
}