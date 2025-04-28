import 'package:flutter_bloc/flutter_bloc.dart';
import '../../models/product.dart';
import 'favorite_event.dart';
import 'favorite_state.dart';

class FavoriteBloc extends Bloc<FavoriteEvent, FavoriteState> {
  FavoriteBloc() : super(FavoriteState()) {
    on<ToggleFavorite>(_onToggleFavorite);
  }

  void _onToggleFavorite(ToggleFavorite event, Emitter<FavoriteState> emit) {
    final updatedFavorites = Set<String>.from(state.favoriteIds);
    if (updatedFavorites.contains(event.productId)) {
      updatedFavorites.remove(event.productId);
    } else {
      updatedFavorites.add(event.productId);
    }
    emit(FavoriteState(favoriteIds: updatedFavorites));
  }
}