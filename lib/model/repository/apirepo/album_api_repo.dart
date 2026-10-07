import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:news_app/model/datasource/remote/apiModel/data_class.dart';
import 'package:news_app/model/datasource/remote/apiService/album_api_service.dart';

class AlbumApiRepo {
  final AlbumApiService _apiService = AlbumApiService();
   
 

  Future<List<ActualData>> fetchData() async {
    List<ActualData> list = [];
    try {
      String json = await _apiService.getResponse();

      dynamic map = jsonDecode(json);
      for (Map<String, dynamic> i in map) {
        list.add(ActualData.fromJson(i));
      }
    

      // for (ActualData i in _actualList) {
      //   debugPrint(i.id.toString());
      // }
    } catch (e) {
      debugPrint("Exception->${e.toString()}");
    }
    return list;
  }
}
