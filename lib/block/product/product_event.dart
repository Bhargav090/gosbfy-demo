abstract class ProductEvent {}

class FetchProducts extends ProductEvent {}

class SortProducts extends ProductEvent {
  final String sortOption;
  SortProducts(this.sortOption);
}