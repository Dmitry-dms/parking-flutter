

import 'package:flutter_app/cubit/home/home_state.dart';
import 'package:flutter_app/screens/home.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit() : super(HomeInitialState());

  Future<void> getInfo(Parking parking) async {
    emit(HomeLoadingState());
    Parking p = await someWork(parking);
    emit(HomeLoadedState(selected: p));
  }
  Future<Parking> someWork(Parking parking) {
    return Future.delayed(Duration(seconds: 5),()
    {
      return parking;
    });
  }
}