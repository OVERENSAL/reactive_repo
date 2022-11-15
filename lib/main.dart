import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:reactive_repo/bloc/red_bloc.dart';
import 'package:reactive_repo/bloc/events.dart';
import 'package:reactive_repo/repository.dart';

import 'bloc/blue_bloc.dart';

const int booster = 20;

void main() {
  final app = RepositoryProvider(
    create: (context) => Repository(),
    child: MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => RedBloc(
            repository: context.read<Repository>(),
          )..subscribe(),
        ),
        BlocProvider(
          create: (context) => BlueBloc(
            repository: context.read<Repository>(),
          )..subscribe(),
        ),
      ],
      child: const MyApp(),
    ),
  );
  runApp(app);
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatelessWidget {
  const MyHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      body: Column(
        children: [
          BlocBuilder<RedBloc, int>(
            builder: (context, state) {
              final height = size.height / 2 + state * booster;
              final weight = height ~/ 100 * 100;

              return InkWell(
                onTap: () => _increaseRed(
                  context,
                  size: size,
                  state: state,
                ),
                child: AnimatedContainer(
                  width: size.width,
                  height: height,
                  duration: const Duration(milliseconds: 200),
                  color: Colors.red[weight],
                ),
              );
            },
          ),
          BlocBuilder<BlueBloc, int>(
            builder: (context, state) {
              final height = size.height / 2 - state * booster;
              final weight = height ~/ 100 * 100;

              return InkWell(
                onTap: () => _increaseBlue(
                  context,
                  size: size,
                  state: state,
                ),
                child: AnimatedContainer(
                  width: size.width,
                  height: height,
                  duration: const Duration(milliseconds: 200),
                  color: Colors.blue[weight],
                ),
              );
            },
          ),
        ],
      ),
    );
  }

  void _increaseRed(
    BuildContext context, {
    required Size size,
    required int state,
  }) {
    final bloc = context.read<RedBloc>();
    if (size.height > state * booster * 3) {
      bloc.add(
        IncrementNumbers(),
      );
    } else {
      bloc.add(
        Reset(),
      );
    }
  }

  void _increaseBlue(
    BuildContext context, {
    required Size size,
    required int state,
  }) {
    final bloc = context.read<BlueBloc>();
    if (-size.height < state * booster * 3) {
      bloc.add(
        DecrementNumbers(),
      );
    } else {
      bloc.add(
        Reset(),
      );
    }
  }
}
