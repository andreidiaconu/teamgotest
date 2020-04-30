import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:teamgotest/model/activity.dart';

class ActivityFeedState  extends Equatable{
  final List<Activity> feed;
  final bool loading;

  const ActivityFeedState({
    @required this.feed,
    @required this.loading,
  });

  ActivityFeedState.initial()
      : feed = List(),
        loading = true;

  ActivityFeedState copyWith({
    List<Activity> feed,
    bool loading,
  }) {
    return new ActivityFeedState(
      feed: feed ?? this.feed,
      loading: loading ?? this.loading,
    );
  }

  @override
  String toString() {
    return 'ActivityFeedState{feed: $feed, loading: $loading}';
  }

  @override
  List<Object> get props => [feed, loading];
}
