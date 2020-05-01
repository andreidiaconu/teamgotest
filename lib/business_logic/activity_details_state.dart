import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:teamgotest/model/activity.dart';

class ActivityDetailsState  extends Equatable{
  final Activity activity;
  final bool loading;

  const ActivityDetailsState({
    @required this.activity,
    @required this.loading,
  });

  ActivityDetailsState.initial()
      : activity = null,
        loading = true;

  ActivityDetailsState copyWith({
    Activity activity,
    bool loading,
  }) {
    return new ActivityDetailsState(
      activity: activity ?? this.activity,
      loading: loading ?? this.loading,
    );
  }

  @override
  List<Object> get props => [activity, loading];
}
