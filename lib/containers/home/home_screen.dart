import 'package:awesome_app/components/colored_safearea.dart';
import 'package:awesome_app/components/loading_indicator.dart';
import 'package:awesome_app/components/not_found.dart';
import 'package:awesome_app/components/shimmer_loading.dart';
import 'package:awesome_app/containers/home/components/grid_photos.dart';
import 'package:awesome_app/containers/home/components/search_screen.dart';
import 'package:awesome_app/cubit/photos/photos_cubit.dart';
import 'package:awesome_app/models/photos_model.dart';
import 'package:awesome_app/values/colors.dart';
import 'package:awesome_app/values/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  double? _width, _height;
  bool _showAppBar = false;
  final ScrollController _scrollController = ScrollController();
  scrollListener() {
    _scrollController.addListener(() {
      var innerPos = _scrollController.position.pixels;
      _showAppBar = innerPos > 30 ? true : false;
      if (_scrollController.position.maxScrollExtent ==
          _scrollController.offset) {
        BlocProvider.of<PhotosCubit>(context).getPhotosMore();
      }
      setState(() => null);
    });
  }

  @override
  void initState() {
    scrollListener();
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    _width = MediaQuery.of(context).size.width;
    _height = MediaQuery.of(context).size.height;
    return ColoredSafeArea(
      color: dark,
      child: Scaffold(
        body: RefreshIndicator(
          color: regular,
          onRefresh: () async {
            BlocProvider.of<PhotosCubit>(context).getPhotos();
          },
          child: Stack(
            children: [
              _body(),
              _header(),
            ],
          ),
        ),
        bottomNavigationBar: _bottomNavigation(),
      ),
    );
  }

  Widget _header() {
    return Container(
      color: _showAppBar ? white : Colors.transparent,
      child: Container(
        margin: EdgeInsets.all(16),
        child: Row(
          children: [
            Text(
              "AW",
              style: TextStyle(
                color: _showAppBar ? regular : white,
                fontWeight: FontWeight.bold,
                fontSize: 30,
              ),
              textScaleFactor: 1,
            ),
            _showAppBar
                ? Expanded(
                    child: Container(
                      margin: EdgeInsets.symmetric(horizontal: 10),
                      child: _searchPanel(header: true),
                    ),
                  )
                : Spacer(),
            GestureDetector(
              onTap: () {},
              child: Icon(
                Icons.favorite,
                color: _showAppBar ? Colors.red : white,
                size: 25,
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _body() {
    return Container(
      height: double.infinity,
      child: SingleChildScrollView(
        controller: _scrollController,
        physics: BouncingScrollPhysics(
          parent: AlwaysScrollableScrollPhysics(),
        ),
        child: Column(
          children: <Widget>[
            _searchContent(),
            _listPhotos(),
          ],
        ),
      ),
    );
  }

  Widget _searchContent() {
    return Container(
      width: _width,
      height: (_height! * .4),
      decoration: BoxDecoration(
        color: Colors.grey,
        backgroundBlendMode: BlendMode.saturation,
        image: DecorationImage(
          image: AssetImage("assets/images/bg.jpeg"),
          fit: BoxFit.cover,
        ),
      ),
      child: Container(
        padding: EdgeInsets.all(paddingBody),
        child: Column(
          children: [
            Container(
              margin: EdgeInsets.only(top: 50, bottom: 20),
              child: Text(
                "Awesome app the best platform to search photos and videos free",
                style: TextStyle(fontSize: 25, color: white),
                textScaleFactor: 1,
              ),
            ),
            _searchPanel(),
          ],
        ),
      ),
    );
  }

  Widget _searchPanel({header = false}) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context).push(
          MaterialPageRoute<Null>(
            builder: (BuildContext context) {
              return SearchScreen();
            },
            fullscreenDialog: true,
          ),
        );
      },
      child: Container(
        height: header ? 40 : 50,
        width: double.infinity,
        child: Container(
          height: 10,
          padding: EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: white,
            borderRadius: BorderRadius.circular(
              10,
            ),
            border: Border.all(color: header ? dark : white),
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Text(
                  "Search for free photos",
                  style: TextStyle(
                    fontSize: 16,
                    color: dark,
                  ),
                  textScaleFactor: 1,
                ),
              ),
              Container(
                margin: EdgeInsets.only(bottom: 5),
                child: Icon(
                  Icons.search,
                  color: dark,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _listPhotos() {
    return BlocBuilder<PhotosCubit, PhotosState>(
      builder: (context, state) {
        List<Photos> _listData = context.read<PhotosCubit>().getListData();
        if (state is PhotosInitial) {
          return Container();
        } else if (state is PhotosLoading) {
          return shimmerGridPhotos();
        } else if (state is PhotosError ||
            state is PhotosLoaded && _listData.length < 1) {
          return Container(
            margin:
                EdgeInsets.only(top: MediaQuery.of(context).size.height * .1),
            child: NotFound(
              width: 150,
              aspecRatio: 1.1,
              press: () {
                BlocProvider.of<PhotosCubit>(context).getPhotos();
              },
            ),
          );
        } else {
          return GridPhotos(data: _listData);
        }
      },
    );
  }

  Widget _bottomNavigation() {
    return BlocBuilder<PhotosCubit, PhotosState>(builder: (context, state) {
      if (state is PhotosLoadingMore) {
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
