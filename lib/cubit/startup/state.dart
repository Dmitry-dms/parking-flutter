import 'package:flutter_app/screens/home.dart';

abstract class StartupState{
  const StartupState();
}
class StartupInitialState extends StartupState{
  const StartupInitialState();
}
class StartupLoadingState extends StartupState{
  const StartupLoadingState();
}
class StartupLoadedState extends StartupState{
  final List<Parking> loadedParking;
  const StartupLoadedState({this.loadedParking}) : assert(loadedParking!=null);
}
class StartupErrorState extends StartupState{}