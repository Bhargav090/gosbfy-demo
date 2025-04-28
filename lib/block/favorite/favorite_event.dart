abstract class FavoriteEvent {}

class ToggleFavorite extends FavoriteEvent {
  final String productId;
  ToggleFavorite(this.productId);
}