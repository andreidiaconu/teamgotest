import 'package:flutter/foundation.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:teamgotest/business_logic/activity_feed_bloc.dart';
import 'package:teamgotest/business_logic/activity_feed_state.dart';
import 'package:teamgotest/model/activity.dart';
import 'package:teamgotest/repository/activity_repository.dart';

void main() {
  group('Activity Feed business logic CRUD', () {
    ActivityRepository repository;
    ActivityFeedBloc bloc;

    setUp(() {
      repository = MockRepository();
      bloc = ActivityFeedBloc(activityRepository: repository);
    });

    test('Bloc fetches data from repository', () async {
      final activity = Activity(
        id: "activity id",
        title: "an activity to test with",
      );
      when(repository.getActivities())
          .thenAnswer((_) => Future.value([activity]));
      expectLater(bloc.outputStream,
          emitsThrough(ActivityFeedState(feed: [activity], loading: false)));
      await bloc.loadActivityFeed();
      bloc.dispose();
    });

    test('Bloc refreshes when adding Activity', () async {
      final activity = Activity(
        id: "activity id",
        title: "an activity to test with",
      );
      when(repository.getActivities())
          .thenAnswer((_) => Future.value([activity]));
      expectLater(bloc.outputStream,
          emitsThrough(ActivityFeedState(feed: [activity], loading: false)));
      await bloc.addNewActivity(Activity());
      bloc.dispose();
    });

    test('Bloc refreshes when when updating Activity', () async {
      final activity = Activity(
        id: "activity id",
        title: "an activity to test with",
      );
      when(repository.getActivities())
          .thenAnswer((_) => Future.value([activity]));
      expectLater(bloc.outputStream,
          emitsThrough(ActivityFeedState(feed: [activity], loading: false)));
      await bloc.updateActivity(Activity());
      bloc.dispose();
    });

    test('Bloc refreshes when when deleting Activity', () async {
      final activity = Activity(
        id: "activity id",
        title: "an activity to test with",
      );
      when(repository.getActivities())
          .thenAnswer((_) => Future.value([activity]));
      expectLater(bloc.outputStream,
          emitsThrough(ActivityFeedState(feed: [activity], loading: false)));
      await bloc.deleteActivity("some id");
      bloc.dispose();
    });

    test('Bloc calls repo when adding Activity', () async {
      final activity = Activity(id: "activity id");
      await bloc.addNewActivity(activity);
      verify(repository.createActivity(activity));
    });

    test('Bloc calls repo when when updating Activity', () async {
      final activity = Activity(id: "activity id");
      await bloc.updateActivity(activity);
      verify(repository.updateActivity(activity));
    });

    test('Bloc calls repo when when deleting Activity', () async {
      await bloc.deleteActivity("some id");
      verify(repository.deleteActivity("some id"));
    });

    test('Bloc does eager update with added Activity', () async {
      final activity = Activity(
        id: "activity id",
        title: "an activity to test with",
      );
      when(repository.getActivities()).thenAnswer((_) => Future.value([]));
      expectLater(bloc.outputStream,
          emitsThrough(ActivityFeedState(feed: [activity], loading: true)));
      await bloc.addNewActivity(activity);
      bloc.dispose();
    });

    test('Bloc does eager update with updated Activity', () async {
      final activity = Activity(
        id: "activity id",
        title: "an activity to test with",
      );
      when(repository.getActivities()).thenAnswer(
        (_) => Future.value([
          Activity(
            id: "activity id",
            title: "OLD TITLE",
          ),
        ]),
      );
      await bloc.loadActivityFeed();
      expectLater(bloc.outputStream,
          emitsThrough(ActivityFeedState(feed: [activity], loading: true)));
      await bloc.updateActivity(activity);
      bloc.dispose();
    });

    test('Bloc does eager update with deleted Activity', () async {
      final remainingActivity = Activity(
        id: "activity id 2",
        title: "OLD TITLE",
      );
      when(repository.getActivities()).thenAnswer(
        (_) => Future.value([
          Activity(
            id: "activity id 1",
            title: "OLD TITLE",
          ),
          remainingActivity,
        ]),
      );
      await bloc.loadActivityFeed();
      expectLater(
          bloc.outputStream,
          emitsThrough(
              ActivityFeedState(feed: [remainingActivity], loading: true)));
      await bloc.deleteActivity("activity id 1");
      bloc.dispose();
    });
  });
}

class MockRepository extends Mock implements ActivityRepository {}

Matcher withFeed(feed) => predicate<ActivityFeedState>(
    (state) => listEquals(state.feed, feed), 'has feed');
