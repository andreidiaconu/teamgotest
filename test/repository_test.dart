// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility that Flutter provides. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:teamgotest/main.dart';
import 'package:teamgotest/model/activity.dart';
import 'package:teamgotest/repository/dummy_activity_repository.dart';

void main() {
  test('Dummy activity repo generates valid activities', () async {
    final repo = DummyActivityRepository(secondsOfDelay: 0);
    final activities = await repo.getActivities();
    final oneActivity = activities[0];

    print(oneActivity);

    expect(oneActivity.id, isNotNull);
    expect(oneActivity.title, isNotNull);
    expect(oneActivity.description, isNotNull);
    expect(oneActivity.author, isNotNull);
    expect(oneActivity.startDate, isNotNull);
    expect(oneActivity.invitedUsers, isNotNull);
    expect(oneActivity.attendingUsers, isNotNull);
    expect(oneActivity.lastMessages, isNotNull);
  });

  test('Dummy activity repo adds a new activity', () async {
    final repo = DummyActivityRepository(secondsOfDelay: 0);
    final activitiesCount1 = (await repo.getActivities()).length;
    repo.createActivity(Activity());
    final activitiesCount2 = (await repo.getActivities()).length;

    expect(activitiesCount2, equals(activitiesCount1 + 1));
  });

  test('Dummy activity repo updates activities', () async {
    final testTitle = "Test title";
    final activityIndex = 5;
    final repo = DummyActivityRepository(secondsOfDelay: 0);

    final activities = await repo.getActivities();
    final activity = activities[activityIndex];
    final updatedActivity = activity.copyWith(title: testTitle);
    repo.updateActivity(updatedActivity);
    final activities2 = await repo.getActivities();

    expect(activities2[activityIndex].title, equals(testTitle));
  });

  test('Dummy activity repo deletes activities', () async {
    final repo = DummyActivityRepository(secondsOfDelay: 0);
    final activities = await repo.getActivities();
    final activitiesCount1 = activities.length;
    repo.deleteActivity(activities[0].id);
    final activitiesCount2 = (await repo.getActivities()).length;

    expect(activitiesCount2, equals(activitiesCount1 - 1));
  });
}

