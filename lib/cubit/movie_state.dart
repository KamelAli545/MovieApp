part of 'movie_cubit.dart';

sealed class MovieState {}

final class MovieInitial extends MovieState {}
final class MovieSuccess extends MovieState {
  final List<Movie> movies;
  MovieSuccess(this.movies);
}
final class MovieLoading extends MovieState {}
final class MovieError extends MovieState {
  final String message;
  MovieError(this.message);
}
