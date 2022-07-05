import 'package:awesome_app/containers/home/home_screen.dart';
import 'package:awesome_app/cubit/photos/photos_cubit.dart';
import 'package:awesome_app/cubit/photos/search_photos_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (_) => PhotosCubit(),
        ),
        BlocProvider(
          create: (_) => SearchPhotosCubit(""),
        ),
      ],
      child: MaterialApp(
        title: 'Awesome App',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: HomeScreen(),
      ),
    );
  }
}
