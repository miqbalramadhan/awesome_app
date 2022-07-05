part of 'search_photos_cubit.dart';

abstract class SearchPhotosState extends Equatable {
  const SearchPhotosState();

  @override
  List<Object> get props => [];
}

class SearchPhotosInitial extends SearchPhotosState {}

class SearchPhotosLoading extends SearchPhotosState {
  @override
  List<Object> get props => [];
}

class SearchPhotosLoaded extends SearchPhotosState {
  final List<Photos> photos;
  SearchPhotosLoaded(this.photos);

  @override
  List<Object> get props => [photos];
}

class SearchPhotosError extends SearchPhotosState {
  @override
  List<Object> get props => [];
}

class SearchPhotosLoadingMore extends SearchPhotosState {
  @override
  List<Object> get props => [];
}
