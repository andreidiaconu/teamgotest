import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:teamgotest/business_logic/activity_details_state.dart';
import 'package:teamgotest/model/activity.dart';
import 'package:teamgotest/repository/activity_repository.dart';

/// Simplest form of bloc, which uses methods for input
class ActivityDetailsBloc {
  Stream<ActivityDetailsState> get outputStream =>
      _stateStreamController.stream;

  final ActivityRepository _activityRepository;
  final String activityId;
  ActivityDetailsState _state = ActivityDetailsState.initial();
  final StreamController<ActivityDetailsState> _stateStreamController =
      StreamController();

  ActivityDetailsBloc({
    @required ActivityRepository activityRepository,
    @required this.activityId,
  }) : this._activityRepository = activityRepository;

  Future<void> refresh() async {
    _updateState(_state.copyWith(loading: true));
    Activity activity = await _activityRepository.getActivity(activityId);
    _updateState(_state.copyWith(activity: activity, loading: false));
  }

  void _updateState(ActivityDetailsState state) {
    _state = state;
    _stateStreamController.add(state);
  }

  void dispose() {
    _stateStreamController.close();
  }
}
