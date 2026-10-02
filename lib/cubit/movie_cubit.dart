import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:movieapp/core/Apiflims.dart';
import 'package:movieapp/model/Results.dart';

part 'movie_state.dart';

class MovieCubit extends Cubit<MovieState> {
  MovieCubit() : super(MovieInitial());
  final ApiFilms apiServices=ApiFilms();
  Future<void> loadMovie() async{
    emit(MovieLoading());
    try{
      final result= await apiServices.getPopular();
      emit(MovieSuccess(result.results??[]));
    }catch(e){
      emit(MovieError(e.toString()));
    }
  }
  Future<void>searchMovie(String query)async{
    final text=query.trim();
    if(text.isEmpty){
      await loadMovie();
      return;
    }try {
      final result = await apiServices.searchMovie(text);
      emit(MovieSuccess(result.results??[]));
    }catch(e){
      emit(MovieError(e.toString()));
    }
  }
}
