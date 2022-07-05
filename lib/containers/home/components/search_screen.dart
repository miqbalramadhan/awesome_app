import 'package:awesome_app/components/colored_safearea.dart';
import 'package:awesome_app/components/loading_indicator.dart';
import 'package:awesome_app/components/not_found.dart';
import 'package:awesome_app/components/regular_text_field.dart';
import 'package:awesome_app/components/shimmer_loading.dart';
import 'package:awesome_app/containers/home/components/grid_photos.dart';
import 'package:awesome_app/cubit/photos/search_photos_cubit.dart';
import 'package:awesome_app/models/photos_model.dart';
import 'package:awesome_app/values/styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SearchScreen extends StatefulWidget {
  SearchScreen({Key? key}) : super(key: key);

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  TextEditingController _searchController = TextEditingController();
  FocusNode _searchNode = FocusNode();
  final _scrollController = ScrollController();
  _scrolListener() {
    _scrollController.addListener(() {
      if (_scrollController.position.maxScrollExtent ==
          _scrollController.offset) {
        BlocProvider.of<SearchPhotosCubit>(context).getSearchPhotosMore();
        setState(() {});
      }
    });
  }

  @override
  void initState() {
    super.initState();
    _searchNode.requestFocus();
    _scrolListener();
  }

  @override
  Widget build(BuildContext context) {
    return ColoredSafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        body: Container(
          height: double.infinity,
          width: double.infinity,
          child: Column(
            children: [_header(), _body()],
          ),
        ),
        bottomNavigationBar: _bottomNavigation(),
      ),
    );
  }

  Widget _header() {
    return Container(
      padding: EdgeInsets.only(top: 15, bottom: 15),
      decoration: borderBottom,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          IconButton(
            splashRadius: 20,
            icon: Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          Expanded(
            child: Container(
              width: double.infinity,
              child: RegularTextField(
                controller: _searchController,
                focusNode: _searchNode,
                labelText: "Search",
                hintText: "Search SearchPhotos",
                onSubmitted: () {
                  BlocProvider.of<SearchPhotosCubit>(context)
                      .getSearchPhotos(_searchController.text);
                },
                suffixIcon: IconButton(
                  icon: Icon(
                    Icons.search,
                  ),
                  onPressed: () {
                    BlocProvider.of<SearchPhotosCubit>(context)
                        .getSearchPhotos(_searchController.text);
                  },
                ),
              ),
            ),
          ),
          SizedBox(
            width: 10,
          )
        ],
      ),
    );
  }

  Widget _body() {
    return Expanded(
      child: RefreshIndicator(
        onRefresh: () async {
          BlocProvider.of<SearchPhotosCubit>(context)
              .getSearchPhotos(_searchController.text);
        },
        child: Container(
          height: double.infinity,
          child: SingleChildScrollView(
            controller: _scrollController,
            physics: BouncingScrollPhysics(
              parent: AlwaysScrollableScrollPhysics(),
            ),
            child: _listSearchPhotos(),
          ),
        ),
      ),
    );
  }

  Widget _listSearchPhotos() {
    return BlocBuilder<SearchPhotosCubit, SearchPhotosState>(
      builder: (context, state) {
        List<Photos> _listData =
            context.read<SearchPhotosCubit>().getListData();
        if (state is SearchPhotosInitial) {
          return Container();
        } else if (state is SearchPhotosLoading) {
          return shimmerGridPhotos();
        } else if (state is SearchPhotosError ||
            state is SearchPhotosLoaded && _listData.length < 1) {
          return NotFound(
            press: () {
              BlocProvider.of<SearchPhotosCubit>(context)
                  .getSearchPhotos(_searchController.text);
            },
          );
        } else {
          return GridPhotos(data: _listData);
        }
      },
    );
  }

  Widget _bottomNavigation() {
    return BlocBuilder<SearchPhotosCubit, SearchPhotosState>(
        builder: (context, state) {
      if (state is SearchPhotosLoadingMore) {
        return Container(
          padding: EdgeInsets.all(10),
          width: double.infinity,
          height: 60,
          child: LoadingIndicator(),
        );
      } else {
        return Container(
          width: double.infinity,
          height: 0,
        );
      }
    });
  }
}
