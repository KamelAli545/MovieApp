enum MovieCategory { nowPlaying, upcoming, topRated, popular }

class MovieTab {
  final String title;
  final MovieCategory category;

  const MovieTab(this.title, this.category);
}


const List<MovieTab> movieTabs = [
  MovieTab('Now Playing', MovieCategory.nowPlaying),
  MovieTab('Upcoming', MovieCategory.upcoming),
  MovieTab('Top Rated', MovieCategory.topRated),
  MovieTab('Popular', MovieCategory.popular),
];