part of 'photos_cubit.dart';

abstract class PhotosState extends Equatable {
  const PhotosState();

  @override
  List<Object> get props => [];
}

class PhotosInitial extends PhotosState {}

class PhotosLoading extends PhotosState {
  @override
  List<Object> get props => [];
}

class PhotosLoaded extends PhotosState {
  final List<Photos> photos;
  PhotosLoaded(this.photos);

  @override
  List<Object> get props => [photos];
}

class PhotosError extends PhotosState {
  @override
  List<Object> get props => [];
}

class PhotosLoadingMore extends PhotosState {
  @override
  List<Object> get props => [];
}
