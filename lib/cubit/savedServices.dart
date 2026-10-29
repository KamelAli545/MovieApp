import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:movieapp/model/Results.dart';

class SavedService {
  final _db = FirebaseFirestore.instance;

  String get _uid => FirebaseAuth.instance.currentUser?.uid ?? '';

  CollectionReference<Map<String, dynamic>> get _saved =>
      _db.collection('users').doc(_uid).collection('savedMovies');

  Stream<List<Movie>> watchSaved() {
    if (_uid.isEmpty) return Stream.value(const []);
    return _saved
        .orderBy('savedAt', descending: true)
        .snapshots()
        .map((snap) => snap.docs.map((d) => _fromDoc(d.data())).toList());
  }

  Stream<bool> watchIsSaved(int movieId) {
    if (_uid.isEmpty) return Stream.value(false);
    return _saved.doc('$movieId').snapshots().map((d) => d.exists);
  }

  Future<void> toggle(Movie movie) async {
    if (_uid.isEmpty || movie.id == null) return;
    final ref = _saved.doc('${movie.id}');
    final snap = await ref.get();
    if (snap.exists) {
      await ref.delete();
    } else {
      await ref.set({
        'id': movie.id,
        'title': movie.title,
        'posterPath': movie.posterPath,
        'voteAverage': movie.voteAverage,
        'overview': movie.overview,
        'releaseDate': movie.releaseDate,
        'backdropPath': movie.backdropPath,
        'voteCount': movie.voteCount,
        'savedAt': FieldValue.serverTimestamp(),
      });
    }
  }

  Movie _fromDoc(Map<String, dynamic> d) => Movie(
    id: (d['id'] as num?)?.toInt(),
    title: d['title'] as String?,
    posterPath: d['posterPath'] as String?,
    voteAverage: (d['voteAverage'] as num?)?.toDouble(),
    overview: d['overview'] as String?,
    releaseDate: d['releaseDate'] as String?,
    backdropPath: d['backdropPath'] as String?,
    voteCount: (d['voteCount'] as num?)?.toInt(),
  );
}