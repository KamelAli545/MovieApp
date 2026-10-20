import 'package:dio/dio.dart';
import 'package:movieapp/model/Moviemodel.dart';

class ApiFilms {
  static const String _token = 'eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiI4OWNkMDA2MmM1MWY5Zjg0MGM5MjlkY2I2ZjljN2Q0NyIsIm5iZiI6MTc5MDk1OTQ0My41ODYsInN1YiI6IjZhYmZkZjUzNTdlOTI0MDQyZWI5YTE3NyIsInNjb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9uIjoxfQ.3V2fEIMjK27c4ApbwQnsLX8rWtuUeZyjAjjIbD4lq_o';

  final Dio dio = Dio(
    BaseOptions(
     baseUrl:"https://api.themoviedb.org/3",
      headers: {
        'Authorization': 'Bearer $_token',
        'accept': 'application/json',
      }
  )
  );

  Future<MovieModel> getPopular() async {
    final response = await dio.get("/movie/popular");
    return MovieModel.fromJson(response.data);
  }

  Future<MovieModel> getTopRated() async {
    final response = await dio.get('/movie/top_rated');
    return MovieModel.fromJson(response.data);
  }
  Future<MovieModel> searchMovie(String query) async {
    final response = await dio.get('/search/movie',
    queryParameters: {'query':query},);
    return MovieModel.fromJson(response.data);
  }
  Future<MovieModel> getNowPlaying() async {
    final response = await dio.get('/movie/now_playing');
    return MovieModel.fromJson(response.data);
  }

  Future<MovieModel> getUpcoming() async {
    final response = await dio.get('/movie/upcoming');
    return MovieModel.fromJson(response.data);
  }

}