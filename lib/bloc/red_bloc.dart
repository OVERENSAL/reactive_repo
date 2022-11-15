import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:reactive_repo/repository.dart';

import 'events.dart';

class RedBloc extends Bloc<BlocEvent, int> {
  final Repository repository;

  RedBloc({required this.repository}) : super(0) {
    on<IncrementNumbers>(
      (event, emit) async {
        repository.incrementNumber();
      },
    );
    on<Reset>(
      (event, emit) async {
        repository.reset();
      },
    );
  }

  void subscribe() {
    repository.number.stream.listen((number) {
      emit(number);
    });
  }
}
