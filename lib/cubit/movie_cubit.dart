import 'package:bloc/bloc.dart';
import 'package:movieapp/core/Apiflims.dart';
import 'package:movieapp/model/Moviemodel.dart';
import 'package:movieapp/model/Results.dart';
import 'package:movieapp/widgets/movieTab.dart';

part 'movie_state.dart';

class MovieCubit extends Cubit<MovieState> {
  MovieCubit() : super(MovieInitial());

  final ApiFilms apiServices = ApiFilms();
  MovieCategory _currentCategory = MovieCategory.popular;
  int _requestId = 0;

  Future<void> loadMovie() => loadCategory(_currentCategory);

  final Map<MovieCategory, String?> posters = {};

  Future<void> loadCategory(MovieCategory category) async {
    _currentCategory = category;
    final id = ++_requestId;
    emit(MovieLoading());
    try {
      final result = await _fetch(category);
      if (id != _requestId) return;
      emit(MovieSuccess(result.results ?? []));
    }
 catch (e) {
      if (id != _requestId) return;
      emit(MovieError(e.toString()));
    }
  }
  Future<MovieModel> _fetch(MovieCategory category) {
    switch (category) {
      case MovieCategory.nowPlaying:
        return apiServices.getNowPlaying();
      case MovieCategory.upcoming:
        return apiServices.getUpcoming();
      case MovieCategory.topRated:
        return apiServices.getTopRated();
      case MovieCategory.popular:
        return apiServices.getPopular();
    }
  }
  Future<void> searchMovie(String query) async {
    final text = query.trim();
    if (text.isEmpty) {
      await loadMovie();
      return;
    }
    final id = ++_requestId;
    emit(MovieLoading());
    try {
      final result = await apiServices.searchMovie(text);
      if (id != _requestId) return;
      emit(MovieSuccess(result.results ?? []));
    } catch (e) {
      if (id != _requestId) return;
      emit(MovieError(e.toString()));
    }
  }

}