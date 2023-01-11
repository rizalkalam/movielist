import 'dart:ffi';

import 'package:api_movielist/MovieListModel.dart';
import 'package:api_movielist/database/movie_database.dart';
import 'package:api_movielist/detailPage.dart';
import 'package:api_movielist/list_database.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_image_slideshow/flutter_image_slideshow.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';

class ListAllFootball extends StatefulWidget {
  const ListAllFootball({Key? key}) : super(key: key);

  @override
  State<ListAllFootball> createState() => _ListAllFootballState();
}

class _ListAllFootballState extends State<ListAllFootball> {
  MovieListModel? movieListModel;
  MovieListModel2? movieListModel2;
  MovieListModel3? movieListModel3;

  bool isloaded = true;

  // Future<CastListModel> fetchAlbum() async {
  //   final response = await http
  //       .get(Uri.parse('https://api.themoviedb.org/3/movie/634649/credits?api_key=fba4f8e25e3a917422cc1659f99c670b&language=en-US'));

  //   if (response.statusCode == 200) {
  //     // If the server did return a 200 OK response,
  //     // then parse the JSON.
  //     return CastListModel.fromJson(jsonDecode(response.body));
  //   } else {
  //     // If the server did not return a 200 OK response,
  //     // then throw an exception.
  //     throw Exception('Failed to load album');
  //   }
  // }

  void getAllListPL() async {
    setState(() {
      isloaded = false;
    });
    final res = await http.get(
      Uri.parse(
          "https://api.themoviedb.org/3/movie/upcoming?api_key=fba4f8e25e3a917422cc1659f99c670b&language=en-US"),
    );
    print("status code " + res.statusCode.toString());
    movieListModel = MovieListModel.fromJson(json.decode(res.body.toString()));
    setState(() {
      isloaded = true;
    });
    setState(() {
      isloaded = false;
    });
    final res2 = await http.get(
      Uri.parse(
          "https://api.themoviedb.org/3/movie/top_rated?api_key=fba4f8e25e3a917422cc1659f99c670b&language=en-US&page=1"),
    );
    movieListModel2 =
        MovieListModel2.fromJson(json.decode(res2.body.toString()));
    setState(() {
      isloaded = true;
    });
    setState(() {
      isloaded = false;
    });
    final res3 = await http.get(Uri.parse(
        "https://api.themoviedb.org/3/movie/popular?api_key=fba4f8e25e3a917422cc1659f99c670b&language=en-US&page=1"));
    movieListModel3 =
        MovieListModel3.fromJson(json.decode(res3.body.toString()));
    setState(() {
      isloaded = true;
    });
  }

  // late PageController _pageController;
  // List<String> images = [
  //   "https://themoviedb.org/t/p/w500/${widget.results.posterPath.toString()}",
  //   "https://wallpaperaccess.com/full/2637581.jpg",
  //   "https://uhdwallpapers.org/uploads/converted/20/01/14/the-mandalorian-5k-1920x1080_477555-mm-90.jpg"
  // ];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getAllListPL();
    // _pageController = PageController(viewportFraction: 0.8);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: Container(
        height: 40,
        width: 40,
        // ignore: sort_child_properties_last
        child: FloatingActionButton(
          backgroundColor: Colors.red,
          child: Icon(Icons.bookmark_add),
          onPressed: () async {
            final result = await Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (BuildContext context) => ListMoviePage()));
            Future.delayed(Duration(seconds: 2));
          },
        ),
      ),
      backgroundColor: Colors.black,
      body: Center(
          child: isloaded
              ? Container(
                  child: ListView(
                    padding: EdgeInsets.all(3),
                    children: [
                      Container(
                          child: CarouselSlider.builder(
                        itemCount: movieListModel!.results!.length,
                        options: CarouselOptions(
                          autoPlay: true,
                          height: 180,
                        ),
                        itemBuilder: (context, index, realIndex) {
                          return Container(
                            margin: EdgeInsets.only(left: 10),
                            width: 500,
                            color: Colors.black12,
                            child: Container(
                              child: FittedBox(
                                child: FadeInImage.assetNetwork(
                                    placeholder: 'assets/giphy.gif',
                                    image: 'https://themoviedb.org/t/p/w500/' +
                                        movieListModel!
                                            .results![index].backdropPath
                                            .toString()),
                                fit: BoxFit.fill,
                              ),
                            ),
                          );
                        },
                      )),
                      Container(
                        padding: EdgeInsets.only(left: 7, top: 17),
                        child: Column(
                          children: [
                            Container(
                              alignment: Alignment.centerLeft,
                              child: Text(
                                "UPCOMING",
                              ),
                            ),
                            Container(
                                height: 250,
                                child: ListView.builder(
                                    scrollDirection: Axis.horizontal,
                                    itemCount: movieListModel!.results!.length,
                                    itemBuilder:
                                        (BuildContext context, int index) {
                                      return InkWell(
                                        onTap: () {
                                          Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      detailPage(
                                                        id: movieListModel!
                                                            .results![index].id!
                                                            .toInt(),
                                                      )));
                                        },
                                        child: Column(
                                          children: [
                                            Container(
                                              margin:
                                                  EdgeInsets.only(right: 10),
                                              height: 230,
                                              width: 130,
                                              child: FadeInImage.assetNetwork(
                                                placeholder: 'assets/giphy.gif',
                                                image:
                                                    "https://themoviedb.org/t/p/w500/" +
                                                        movieListModel!
                                                            .results![index]
                                                            .posterPath
                                                            .toString(),
                                              ),
                                            ),
                                          ],
                                        ),
                                      );
                                    })),
                          ],
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.only(left: 7),
                        child: Column(
                          children: [
                            Container(
                              alignment: Alignment.centerLeft,
                              child: Text(
                                "TOP RATED",
                              ),
                            ),
                            Container(
                                height: 250,
                                child: ListView.builder(
                                    scrollDirection: Axis.horizontal,
                                    itemCount:
                                        movieListModel2!.results2!.length,
                                    itemBuilder:
                                        (BuildContext context, int index) {
                                      return InkWell(
                                        onTap: () {
                                          Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      detailPage(
                                                        id: movieListModel2!
                                                            .results2![index]
                                                            .id!
                                                            .toInt(),
                                                      )));
                                        },
                                        child: Column(
                                          children: [
                                            Container(
                                              margin:
                                                  EdgeInsets.only(right: 10),
                                              height: 230,
                                              width: 130,
                                              child: FadeInImage.assetNetwork(
                                                placeholder: 'assets/giphy.gif',
                                                image:
                                                    "https://themoviedb.org/t/p/w500/" +
                                                        movieListModel2!
                                                            .results2![index]
                                                            .posterPath
                                                            .toString(),
                                              ),
                                            ),
                                          ],
                                        ),
                                      );
                                    })),
                          ],
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.only(left: 7),
                        child: Column(
                          children: [
                            Container(
                              alignment: Alignment.centerLeft,
                              child: Text(
                                "POPULAR",
                              ),
                            ),
                            Container(
                                height: 250,
                                child: ListView.builder(
                                    scrollDirection: Axis.horizontal,
                                    itemCount:
                                        movieListModel3!.results3!.length,
                                    itemBuilder:
                                        (BuildContext context, int index) {
                                      return InkWell(
                                        onTap: () {
                                          Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      detailPage(
                                                        id: movieListModel3!
                                                            .results3![index]
                                                            .id!
                                                            .toInt(),
                                                      )));
                                        },
                                        child: Column(
                                          children: [
                                            Container(
                                              margin:
                                                  EdgeInsets.only(right: 10),
                                              height: 230,
                                              width: 130,
                                              child: FadeInImage.assetNetwork(
                                                placeholder: 'assets/giphy.gif',
                                                image:
                                                    "https://themoviedb.org/t/p/w500/" +
                                                        movieListModel3!
                                                            .results3![index]
                                                            .posterPath
                                                            .toString(),
                                              ),
                                            ),
                                          ],
                                        ),
                                      );
                                    })),
                          ],
                        ),
                      ),
                    ],
                  ),
                )
              : CircularProgressIndicator()),
    );
  }
}
