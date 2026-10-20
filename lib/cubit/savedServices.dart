import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:movieapp/model/Results.dart';

class SavedService {
  final _db = FirebaseFirestore.instance;

  String get _uid => FirebaseAuth.instance.currentUser?.uid ?? '';

  CollectionReference<Map<String, dynamic>> get _saved =>
      _db.collection('users').doc(_uid).collection('saved');

  /// قايمة الأفلام المحفوظة، بتتحدث لوحدها
  Stream<List<Movie>> watchSaved() {
    return _saved
        .orderBy('savedAt', descending: true)
        .snapshots()
        .map((snap) => snap.docs.map((d) => _fromDoc(d.data())).toList());
  }

  /// هل الفيلم ده محفوظ؟
  Stream<bool> watchIsSaved(int movieId) {
    return _saved.doc('$movieId').snapshots().map((d) => d.exists);
  }

  /// لو محفوظ يشيله، لو مش محفوظ يحفظه
  Future<void> toggle(Movie movie) async {
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
    id: d['id'],
    title: d['title'],
    posterPath: d['posterPath'],
    voteAverage: (d['voteAverage'] as num?)?.toDouble(),
    overview: d['overview'],
    releaseDate: d['releaseDate'],
    backdropPath: d['backdropPath'],
    voteCount: d['voteCount'],
  );
}