import 'package:flutter/material.dart';
import 'package:flutter_app/cubit/home/cubit_home.dart';
import 'package:flutter_app/cubit/startup/cubit.dart';
import 'package:flutter_app/screens/home.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        // primarySwatch: Colors.blue,
        scaffoldBackgroundColor: Colors.redAccent,
      ),
      home: MultiBlocProvider(providers: [
        BlocProvider<StartupCubit>(
          create: (context) => StartupCubit(),
        ),
        BlocProvider<HomeCubit>(
          create: (context) => HomeCubit(),
        ),
      ], child: Home()),
    );
  }
}
