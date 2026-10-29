import 'package:flutter/material.dart';
import 'package:movieapp/cubit/savedServices.dart';
import 'package:movieapp/model/Results.dart';

const kBg = Color(0xFF242A32);

class DetailsScreen extends StatelessWidget {
  const DetailsScreen({super.key, required this.movie});

  final Movie movie;

  static const _posterBase = 'https://image.tmdb.org/t/p/w500';

  @override
  Widget build(BuildContext context) {
    final service = SavedService();
    final poster = movie.posterPath;

    return Scaffold(
      backgroundColor: kBg,
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.white),
        backgroundColor: kBg,
        title: Text(
          movie.title ?? '',
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: const TextStyle(color: Colors.white),
        ),
        actions: [
          StreamBuilder<bool>(
            stream: service.watchIsSaved(movie.id ?? 0),
            builder: (context, snap) {
              final isSelected = snap.data ?? false;
              return IconButton(
                tooltip: isSelected ? 'Remove from saved' : 'Save movie',
                onPressed: () => service.toggle(movie),
                icon: Icon(
                  isSelected ? Icons.favorite_rounded : Icons.favorite_outline,
                  color: isSelected ? Colors.red : Colors.white,
                ),
              );
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: SizedBox(
                width: 200,
                child: AspectRatio(
                  aspectRatio: 2 / 3,
                  child: Hero(
                    tag: 'movie-poster-${movie.id}',
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(16),
                      child: poster == null
                          ? const ColoredBox(
                        color: Colors.black26,
                        child: Center(
                          child: Icon(Icons.movie,
                              size: 48, color: Colors.white54),
                        ),
                      )
                          : Image.network(
                        '$_posterBase$poster',
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 20),
            Text(
              movie.title ?? '',
              style: const TextStyle(
                color: Colors.white,
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            Row(
              children: [
                const Icon(Icons.star, color: Colors.amber, size: 20),
                const SizedBox(width: 4),
                Expanded(
                  child: Text(
                    '${movie.voteAverage?.toStringAsFixed(1) ?? '-'}'
                        '  (${movie.voteCount ?? 0} votes)',
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(color: Colors.white),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 4),
            Text(
              'Release date: ${movie.releaseDate ?? '-'}',
              style: const TextStyle(color: Colors.white70),
            ),
            const SizedBox(height: 20),
            const Text(
              'Overview',
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w600,
                fontSize: 16,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              (movie.overview == null || movie.overview!.isEmpty)
                  ? 'No overview available.'
                  : movie.overview!,
              style: const TextStyle(
                color: Colors.white,
                height: 1.5,
              ),
            ),
          ],
        ),
      ),
    );
  }
}