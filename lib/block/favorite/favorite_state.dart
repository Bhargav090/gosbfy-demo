class FavoriteState {
  final Set<String> favoriteIds;

  FavoriteState({Set<String>? favoriteIds}) : favoriteIds = favoriteIds ?? {};

  int get count => favoriteIds.length;
}