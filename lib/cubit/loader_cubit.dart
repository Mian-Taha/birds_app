import 'package:flutter_bloc/flutter_bloc.dart';

enum LoaderState {
  Initial,
  Loading,
  Success,
  Error,
}

class LoaderCubit extends Cubit<LoaderState> {
  LoaderCubit() : super(LoaderState.Initial);

  void startLoading() {
    emit(LoaderState.Loading);
  }

  void stopLoading() {
    emit(LoaderState.Initial);
  }

  void loadingSuccess() {
    emit(LoaderState.Success);
  }

  void loadingError() {
    emit(LoaderState.Error);
  }
}
