import 'package:flutter/cupertino.dart';
import 'package:instabug_task_flutter/Consts/consts.dart';
import 'package:instabug_task_flutter/Model/MoviesData.dart';
import 'package:instabug_task_flutter/Network/dio_helper.dart';

class MoviesProvider extends ChangeNotifier {
  MoviesData? moviesData ;
  List<Results> results = [];

int page = 1;
  fetchData(int pageNumber) {
    DioHelper.getData(url: '3/discover/movie', query: {
      'api_key': apiKey,
      'page': pageNumber,
    }).then((value) {
      if (value.statusCode == 200) {
        moviesData = MoviesData.fromJson(value.data);
        results.addAll(moviesData!.results!);
      }
      notifyListeners();
      print(value.data['results'].length);
    }).catchError((error) => print(error.toString()));
  }
}
