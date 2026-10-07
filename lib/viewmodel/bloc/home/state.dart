import 'package:news_app/model/datasource/remote/apiModel/data_class.dart';

class AlbumApiState {}

class InitialState extends AlbumApiState {}
 
class Loading extends AlbumApiState {}

class Success extends AlbumApiState {
  List<ActualData> data;
  Success({required this.data});
}

class Failure extends AlbumApiState {
  String error ;
  Failure({required this.error});
}
