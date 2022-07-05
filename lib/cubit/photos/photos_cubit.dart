import 'package:awesome_app/models/photos_model.dart';
import 'package:awesome_app/services/photos_provider.dart';
import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
part 'photos_state.dart';

class PhotosCubit extends Cubit<PhotosState> {
  String _query = "nature";
  List<Photos> _listData = [];
  int _page = 1;
  int _load = 15;
  PhotosCubit() : super(PhotosInitial()) {
    getPhotos();
  }
  List<Photos> getListData() {
    return _listData;
  }

  void getPhotos() async {
    _page = 1;
    _listData = [];
    try {
      emit(PhotosLoading());
      try {
        final Response response = await PhotosProvider.getAll(
            query: _query, page: _page, load: _load);
        if (response.statusCode == 200) {
          PhotosModel photos = PhotosModel.fromJson(response.data);
          for (Photos item in photos.photos ?? []) {
            _listData.add(item);
          }
        }
        emit(PhotosLoaded(_listData));
      } catch (e) {
        emit(PhotosError());
      }
    } on PhotosError {
      emit(PhotosError());
    }
  }

  Future<void> getPhotosMore() async {
    if (state is PhotosLoaded) {
      _page += 1;
      emit(PhotosLoadingMore());
      try {
        final Response response = await PhotosProvider.getAll(
            query: _query, page: _page, load: _load);
        if (response.statusCode == 200) {
          PhotosModel photos = PhotosModel.fromJson(response.data);
          for (Photos item in photos.photos ?? []) {
            _listData.add(item);
          }
        }
      } catch (e) {
        emit(PhotosError());
      }
    }
    emit(PhotosLoaded(_listData));
  }
}
