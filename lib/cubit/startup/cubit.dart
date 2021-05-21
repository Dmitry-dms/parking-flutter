
import 'package:flutter_app/cubit/startup/state.dart';
import 'package:flutter_app/screens/home.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class StartupCubit extends Cubit<StartupState>{

  StartupCubit() : super(StartupLoadingState());

  Future<void> getAddresses() async {
    try {
    // emit(StartupLoadingState());
    List<Parking> parking = await fetchAddress();
      emit(StartupLoadedState(loadedParking: parking));
    } catch (e){
      emit(StartupErrorState());
    }
  }
  Future<List<Parking>> fetchAddress() {
    return Future.delayed(Duration(seconds: 5),()
    {
      List<Parking> parking = <Parking>[
        Parking("https://espanarusa.com/files/autoupload/91/89/21/lozpdg5z377966.JPG", "test1", 100),
        Parking("https://oflex.ru/wp-content/uploads/2020/12/glavnaya-15.jpg", "test2", 0),
        Parking("https://img1.fonwall.ru/o/ae/aston-martin-cars-racing-xrvz.jpeg", "test3", 10),
      ];
      return parking;
    });
  }

}