import 'package:flutter/material.dart';
import 'package:flutter_app/cubit/home/cubit_home.dart';
import 'package:flutter_app/cubit/home/home_state.dart';
import 'package:flutter_app/cubit/startup/cubit.dart';
import 'package:flutter_app/cubit/startup/state.dart';
import 'package:flutter_app/screens/startup.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final StartupCubit cubit = BlocProvider.of<StartupCubit>(context);
    return Scaffold(body: BlocBuilder<StartupCubit, StartupState>(
      builder: (ctx, state) {
        if (state is StartupLoadingState) {
          print('loading');
          cubit.getAddresses();
          return StartupWidget();
        } else if (state is StartupLoadedState) {
          print('loaded');
          return Column(mainAxisAlignment: MainAxisAlignment.start, children: [
            Card(
              color: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15.0),
              ),
              margin: EdgeInsets.fromLTRB(20, 50, 20, 20),
              //borderOnForeground: false,
              child: SizedBox(
                child: DropDownScreen(state.loadedParking),
                height: 100,
              ),
            ),
            BlocBuilder<HomeCubit, HomeState>(builder: (ctx, state) {
              if (state is HomeLoadingState) {
                return Center(
                  child: CircularProgressIndicator(
                    backgroundColor: Colors.black,
                  ),
                );
              } else if (state is HomeLoadedState) {
                return Column(
                  children: [
                    ParkImage(
                        '${state.selected.imageUrl}'),
                    Card(
                      color: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15.0),
                      ),
                      margin: EdgeInsets.only(top: 20),
                      child: SizedBox(
                        child: Center(child: Text(
                            'Свободных мест на парковке : ${state.selected
                                .freeSpace}')),
                        width: 300,
                        height: 100,
                      ),
                    ),
                  ],
                );
              } else
                return Container();
            })
          ]);
        }
        else {
          //cubit.getAddresses();
          return Text('Error while loading addresses');
        }
      },
    ));
  }
}

class ParkImage extends StatefulWidget {
  String imageUrl;

  ParkImage(this.imageUrl);

  @override
  _ParkImageState createState() => _ParkImageState();
}

class _ParkImageState extends State<ParkImage> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 300,
      width: 300,
      child: Image.network(
        widget.imageUrl,
        fit: BoxFit.cover,
        errorBuilder: (BuildContext context, Object exception,
            StackTrace stackTrace) {
          // Appropriate logging or analytics, e.g.
          // myAnalytics.recordError(
          //   'An error occurred loading "https://example.does.not.exist/image.jpg"',
          //   exception,
          //   stackTrace,
          // );
          print(exception);
          return Text('😢');
        },
      ),
    );
  }

}

class Parking {
  String imageUrl, name;
  int freeSpace;

  Parking(this.imageUrl, this.name, this.freeSpace);
}

class DropDownScreen extends StatefulWidget {
  List<Parking> loadedParkings;
  Parking selected;

  DropDownScreen(this.loadedParkings);

  @override
  _DropDownScreenState createState() => _DropDownScreenState();
}

class _DropDownScreenState extends State<DropDownScreen> {
  Parking selectedParking;

  @override
  Widget build(BuildContext context) {
    final HomeCubit home = context.read<HomeCubit>();
    return Center(
      child: DropdownButton<Parking>(
        hint: Text('Выберите парковку'),
        value: selectedParking,
        onChanged: (Parking value) {
          setState(() {
            widget.selected = value;
            home.getInfo(widget.selected);
          });
        },
        items: widget.loadedParkings
            .map((e) =>
            DropdownMenuItem(
              value: e,
              child: Row(
                children: [
                  Text(
                    e.name,
                    style: TextStyle(color: Colors.black),
                  )
                ],
              ),
            ))
            .toList(),
      ),
    );
  }
}
