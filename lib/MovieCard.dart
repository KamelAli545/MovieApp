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
        children: [
          Expanded(
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
                width: 500,
              ),
            ),
          ),
          SizedBox(
            height: 6,
          ),
          Text(movie.title??'',
          style: TextStyle(color: Colors.white),
          maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
          Text('⭐ ${movie.voteAverage?.toStringAsFixed(1) ?? '-'}',
            style: TextStyle(color: Colors.white),
          ),
        ],
      ),
    );
  }
}