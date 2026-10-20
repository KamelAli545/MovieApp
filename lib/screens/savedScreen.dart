import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:movieapp/cubit/savedServices.dart';
import 'package:movieapp/model/Results.dart';
import 'package:movieapp/screens/DetailsScreen.dart';

class SavedScreen extends StatelessWidget {
  const SavedScreen({super.key});
  static const _imgBase = 'https://image.tmdb.org/t/p/w200';

  @override
  Widget build(BuildContext context) {
    final service = SavedService();

    return Scaffold(
      backgroundColor: const Color(0xFF242A32),
      appBar: AppBar(
        backgroundColor: const Color(0xFF242A32),
        iconTheme: const IconThemeData(color: Colors.white),
        title: const Text('Saved', style: TextStyle(color: Colors.white)),
        centerTitle: true,
      ),
      body: StreamBuilder<List<Movie>>(
        stream: service.watchSaved(),
        builder: (context, snap) {
          if (snap.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          if (snap.hasError) {
            return Center(
              child: Text('${snap.error}',
                  style: const TextStyle(color: Colors.white)),
            );
          }
          final movies = snap.data ?? [];
          if (movies.isEmpty) {
            return  Center(
              child: Lottie.asset("assets/animations/not found.json",

              )
            );
          }
          return ListView.builder(
            padding: const EdgeInsets.all(16),
            itemCount: movies.length,
            itemBuilder: (context, i) {
              final movie = movies[i];
              return Card(
                color: Colors.white10,
                margin: const EdgeInsets.only(bottom: 12),
                child: ListTile(
                  contentPadding: const EdgeInsets.all(8),
                  leading: ClipRRect(
                    borderRadius: BorderRadius.circular(8),
                    child: movie.posterPath == null
                        ? const SizedBox(
                      width: 56,
                      height: 80,
                      child: Icon(Icons.movie, color: Colors.white54),
                    )
                        : Image.network(
                      '$_imgBase${movie.posterPath}',
                      width: 56,
                      height: 80,
                      fit: BoxFit.cover,
                    ),
                  ),
                  title: Text(
                    movie.title ?? '',
                    style: const TextStyle(
                        color: Colors.white, fontWeight: FontWeight.bold),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  subtitle: Text(
                    '⭐ ${movie.voteAverage?.toStringAsFixed(1) ?? '-'}'
                        '  •  ${movie.releaseDate ?? '-'}',
                    style: const TextStyle(color: Colors.white54),
                  ),
                  trailing: IconButton(
                    icon: const Icon(Icons.delete_outline, color: Colors.white54),
                    onPressed: () => service.toggle(movie),
                  ),
                  onTap: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => DetailsScreen(movie: movie),
                    ),
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}