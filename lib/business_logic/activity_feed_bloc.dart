import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:teamgotest/business_logic/activity_feed_state.dart';
import 'package:teamgotest/model/activity.dart';
import 'package:teamgotest/repository/activity_repository.dart';

/// Simplest form of bloc, which uses methods for input
class ActivityFeedBloc {
  Stream<ActivityFeedState> get outputStream => _stateStreamController.stream;

  final ActivityRepository _activityRepository;
  ActivityFeedState _state = ActivityFeedState.initial();
  final StreamController<ActivityFeedState> _stateStreamController =
      StreamController();

  ActivityFeedBloc({
    @required ActivityRepository activityRepository,
  }) : this._activityRepository = activityRepository;

  Future<void> loadActivityFeed() async {
    _updateState(_state.copyWith(loading: true));
    List<Activity> apiActivities = await _activityRepository.getActivities();
    _updateState(_state.copyWith(feed: apiActivities, loading: false));
  }

  Future<void> addNewActivity(Activity activity) async {
    final feed = List.of(_state.feed);
    feed.insert(0, activity);
    _updateState(_state.copyWith(feed: feed, loading: true)); // Eager UI update
    await _activityRepository.createActivity(activity);
    await loadActivityFeed();
  }

  Future<void> updateActivity(Activity activity) async {
    final feed = List.of(_state.feed);
    int index = feed.indexWhere((element) => element.id == activity.id);
    if (index != -1) {
      feed[index] = activity;
    }
    _updateState(_state.copyWith(feed: feed, loading: true)); // Eager UI update
    await _activityRepository.updateActivity(activity);
    await loadActivityFeed();
  }

  Future<void> deleteActivity(String activityId) async {
    final feed = List.of(_state.feed);
    int index = feed.indexWhere((element) => element.id == activityId);
    if (index != -1) {
      feed.removeAt(index);
    }
    _updateState(_state.copyWith(feed: feed, loading: true)); // Eager UI update
    await _activityRepository.deleteActivity(activityId);
    await loadActivityFeed();
  }

  void _updateState(ActivityFeedState state) {
    _state = state;
    _stateStreamController.add(state);
  }

  void dispose() {
    _stateStreamController.close();
  }
}
