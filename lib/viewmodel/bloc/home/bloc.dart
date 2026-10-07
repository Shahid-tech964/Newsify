import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/model/datasource/remote/apiModel/data_class.dart';
import 'package:news_app/model/repository/apirepo/album_api_repo.dart';
import 'package:news_app/viewmodel/bloc/home/event.dart';
import 'package:news_app/viewmodel/bloc/home/state.dart';

class HomeBloc extends Bloc<HomeEvent, AlbumApiState> {
  final AlbumApiRepo _albumApiRepo = AlbumApiRepo();
  HomeBloc() : super(InitialState()) {
    on<AlbumApiEvent>((event, emit) async {
      try {
        emit(Loading());
        List<ActualData> data = await _albumApiRepo.fetchData();
        emit(Success(data: data));
      } catch (e) {
        emit(Failure(error: e.toString()));
      }
    });
  }
}
