import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:reactive_repo/repository.dart';

import 'events.dart';

class BlueBloc extends Bloc<BlocEvent, int> {
  final Repository repository;

  BlueBloc({required this.repository}) : super(0) {
    on<DecrementNumbers>(
      (event, emit) async {
        repository.decrementNumber();
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
