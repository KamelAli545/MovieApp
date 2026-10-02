import 'package:flutter/material.dart';
import 'package:movieapp/model/Results.dart';
final kBg = Color(0xFF242A32);

class DetailsScreen extends StatelessWidget {
  const DetailsScreen({super.key, required this.movie});

  final Movie movie;

  static const _backdropBase = 'https://image.tmdb.org/t/p/w780';
  static const _posterBase = 'https://image.tmdb.org/t/p/w500';

  @override
  Widget build(BuildContext context) {
    final image = movie.backdropPath ?? movie.posterPath;
    return Scaffold(
      backgroundColor: kBg,

      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.white),
          backgroundColor: kBg,

          title: Text(movie.title ?? '',
            style: TextStyle(
                color: Colors.white
            ),

          )),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (image != null)
              Center(
                child: Image.network(
                  movie.backdropPath != null
                      ? '$_backdropBase$image'
                      : '$_posterBase$image',
                  width: double.infinity,
                  height: 220,
                  fit: BoxFit.cover,
                ),
              )
            else
              const SizedBox(
                height: 220,
                child: Center(child: Icon(Icons.movie, size: 64)),
              ),
            Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    movie.title ?? '',
                    style: TextStyle(
                        color: Colors.white
                    ),

                  ),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      const Icon(Icons.star, color: Colors.amber, size: 20),
                      const SizedBox(width: 4),
                      Text(
                        '${movie.voteAverage?.toStringAsFixed(1) ?? '-'}'
                            '  (${movie.voteCount ?? 0} votes)',
                        style: TextStyle(
                            color: Colors.white
                        ),

                      ),
                    ],
                  ),
                  const SizedBox(height: 4),
                  Text('Release date: ${movie.releaseDate ?? '-'}',
                  style: TextStyle(
                    color: Colors.white
                  ),
                  ),

                  const SizedBox(height: 16),
                  Text(
                    'Overview',
                    style: TextStyle(
                      color: Colors.white
                  ),

            ),
                  const SizedBox(height: 6),
                  Text(
                    (movie.overview == null || movie.overview!.isEmpty)
                        ? 'No overview available.'
                        : movie.overview!,
                    style: TextStyle(
                        color: Colors.white
                    ),

                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}