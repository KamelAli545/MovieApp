import 'package:flutter/material.dart';
import 'package:movieapp/model/Results.dart';
import 'package:movieapp/screens/DetailsScreen.dart';

class MovieCard extends StatelessWidget {
  const MovieCard({super.key, required this.movie});

  final Movie movie;

  static const _imgBase = 'https://image.tmdb.org/t/p/w500';

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(16),
      onTap: () => Navigator.push(
        context,
        MaterialPageRoute(builder: (_) => DetailsScreen(movie: movie)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          AspectRatio(
            aspectRatio: 2 / 3,
            child: Hero(
              tag: 'movie-poster-${movie.id}',
              child: ClipRRect(
                borderRadius: BorderRadius.circular(16),
                child: movie.posterPath == null
                    ? const ColoredBox(
                  color: Colors.black26,
                  child: Center(child: Icon(Icons.movie)),
                )
                    : Image.network(
                  '$_imgBase${movie.posterPath}',
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
          const SizedBox(height: 6),
          Center(
            child: Text(
              movie.title ?? '',
              style: const TextStyle(color: Colors.white),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ),
          Center(
            child: Text(
              '⭐ ${movie.voteAverage?.toStringAsFixed(1) ?? '-'}',
              style: const TextStyle(color: Colors.white),
              maxLines: 1,
            ),
          ),
        ],
      ),
    );
  }
}