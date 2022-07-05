import 'package:awesome_app/models/photos_model.dart';
import 'package:awesome_app/services/photos_provider.dart';
import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
part 'search_photos_state.dart';

class SearchPhotosCubit extends Cubit<SearchPhotosState> {
  String _query = "";
  List<Photos> _listData = [];
  int _page = 1;
  int _load = 15;
  SearchPhotosCubit(query) : super(SearchPhotosInitial()) {
    getSearchPhotos(query);
  }
  List<Photos> getListData() {
    return _listData;
  }

  void getSearchPhotos(query) async {
    _query = query;
    _page = 1;
    _listData = [];
    try {
      emit(SearchPhotosLoading());
      try {
        final Response response =
            await PhotosProvider.getAll(query: query, page: _page, load: _load);
        if (response.statusCode == 200) {
          PhotosModel photos = PhotosModel.fromJson(response.data);
          for (Photos item in photos.photos ?? []) {
            _listData.add(item);
          }
        }
        emit(SearchPhotosLoaded(_listData));
      } catch (e) {
        emit(SearchPhotosError());
      }
    } on SearchPhotosError {
      emit(SearchPhotosError());
    }
  }

  Future<void> getSearchPhotosMore() async {
    if (state is SearchPhotosLoaded) {
      _page += 1;
      emit(SearchPhotosLoadingMore());
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
        emit(SearchPhotosError());
      }
    }
    emit(SearchPhotosLoaded(_listData));
  }
}
