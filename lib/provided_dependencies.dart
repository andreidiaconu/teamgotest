import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';
import 'package:teamgotest/business_logic/activity_feed_bloc.dart';
import 'package:teamgotest/business_logic/session_state.dart';
import 'package:teamgotest/model/user.dart';
import 'package:teamgotest/repository/activity_repository.dart';
import 'package:teamgotest/repository/dummy_activity_repository.dart';

class ProvidedDependencies extends StatelessWidget {
  final Widget child;

  // Would normally come from GetIt or some other DI
  final ActivityRepository repository = DummyActivityRepository();

  // Would normally have a session Bloc that owns the current user
  final User currentUser = User(
    id: 'FJDUIKF358F8DJ29IF',
    name: 'Joey',
    avatar:
    "https:\/\/tinyfac.es\/data\/avatars\/26CFEFB3-21C8-49FC-8C19-8E6A62B6D2E0-200w.jpeg",
  );

  ProvidedDependencies({Key key, this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Provider<ActivityRepository>(
      create: (_) => repository,
      child: Provider<SessionState>(
        create: (_) => SessionState(currentUser: currentUser),
        child: Provider<ActivityFeedBloc>(
          create: (_) => ActivityFeedBloc(activityRepository: repository),
          dispose: (_, bloc) => bloc.dispose(),
          child: child,
        ),
      ),
    );
  }
}