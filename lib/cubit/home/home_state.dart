
import 'package:flutter_app/screens/home.dart';

abstract class HomeState{
  const HomeState();
}
class HomeInitialState extends HomeState{
  const HomeInitialState();
}
class HomeLoadingState extends HomeState{
  const HomeLoadingState();
}
class HomeLoadedState extends HomeState{
  final Parking selected;
  const HomeLoadedState({this.selected}) : assert(selected!=null);
}
class HomeErrorState extends HomeState{}