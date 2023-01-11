import 'dart:convert';
import 'package:api_movielist/tvDetailPage.dart';
import 'package:api_movielist/trending_model.dart';
import 'package:api_movielist/tv_model.dart';
import 'package:api_movielist/tv_model2.dart';
import 'package:api_movielist/tv_model3.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter_image_slideshow/flutter_image_slideshow.dart';
import 'package:http/http.dart' as http;
import 'package:api_movielist/MovieListModel.dart';
import 'package:flutter/material.dart';

import 'detailPage.dart';

class listview2 extends StatefulWidget {
  const listview2({Key? key}) : super(key: key);

  @override
  State<listview2> createState() => _listview2State();
}

class _listview2State extends State<listview2> {
  TvModel? tvModel;
  TvModel2? tvModel2;
  TvModel3? tvModel3;
  bool isloaded = true;

  void getAllListTv() async {
    setState(() {
      isloaded = false;
    });
    final res = await http.get(
      Uri.parse(
          "https://api.themoviedb.org/3/tv/top_rated?api_key=fba4f8e25e3a917422cc1659f99c670b&language=en-US&page=1"),
    );
    print("status code " + res.statusCode.toString());
    tvModel = TvModel.fromJson(json.decode(res.body.toString()));
    setState(() {
      isloaded = true;
    });
    setState(() {
      isloaded = false;
    });
    final res2 = await http.get(
      Uri.parse(
          "https://api.themoviedb.org/3/tv/popular?api_key=fba4f8e25e3a917422cc1659f99c670b&language=en-US&page=1"),
    );
    print("status code " + res.statusCode.toString());
    tvModel2 = TvModel2.fromJson(json.decode(res2.body.toString()));
    setState(() {
      isloaded = true;
    });
    setState(() {
      isloaded = false;
    });
    final res3 = await http.get(
      Uri.parse(
          "https://api.themoviedb.org/3/tv/on_the_air?api_key=fba4f8e25e3a917422cc1659f99c670b&language=en-US&page=1"),
    );
    print("status code " + res.statusCode.toString());
    tvModel3 = TvModel3.fromJson(json.decode(res3.body.toString()));
    setState(() {
      isloaded = true;
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getAllListTv();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Center(
          child: isloaded
              ? Container(
                  child: ListView(
                    padding: EdgeInsets.all(3),
                    children: [
                      Container(
                          child: CarouselSlider.builder(
                        itemCount: tvModel3!.results!.length,
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
                                    image: 'https://themoviedb.org/t/p/w300/' +
                                        tvModel3!.results![index].backdropPath
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
                                "TOP RATED",
                              ),
                            ),
                            Container(
                                height: 250,
                                child: ListView.builder(
                                    scrollDirection: Axis.horizontal,
                                    itemCount: tvModel!.results!.length,
                                    itemBuilder:
                                        (BuildContext context, int index) {
                                      return InkWell(
                                        onTap: () {
                                          Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      tvDetailPage(
                                                        background: tvModel!
                                                            .results![index]
                                                            .backdropPath
                                                            .toString(),
                                                        judul: tvModel!
                                                            .results![index]
                                                            .name
                                                            .toString(),
                                                        poster: tvModel!
                                                            .results![index]
                                                            .posterPath
                                                            .toString(),
                                                        popularity: tvModel!
                                                            .results![index]
                                                            .popularity
                                                            .toString(),
                                                        overview: tvModel!
                                                            .results![index]
                                                            .overview
                                                            .toString(),
                                                        id: tvModel!
                                                            .results![index].id!
                                                            .toInt(),
                                                        genre: '',
                                                        realesedate: '',
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
                                                        tvModel!.results![index]
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
                                    itemCount: tvModel2!.results!.length,
                                    itemBuilder:
                                        (BuildContext context, int index) {
                                      return InkWell(
                                        onTap: () {
                                          Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      tvDetailPage(
                                                        background: tvModel2!
                                                            .results![index]
                                                            .backdropPath
                                                            .toString(),
                                                        judul: tvModel2!
                                                            .results![index]
                                                            .name
                                                            .toString(),
                                                        poster: tvModel2!
                                                            .results![index]
                                                            .posterPath
                                                            .toString(),
                                                        realesedate: tvModel2!
                                                            .results![index]
                                                            .firstAirDate
                                                            .toString(),
                                                        popularity: tvModel2!
                                                            .results![index]
                                                            .popularity
                                                            .toString(),
                                                        overview: tvModel2!
                                                            .results![index]
                                                            .overview
                                                            .toString(),
                                                        id: tvModel2!
                                                            .results![index].id!
                                                            .toInt(),
                                                        genre: '',
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
                                                        tvModel2!
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
                                "ON THE AIR",
                              ),
                            ),
                            Container(
                                height: 250,
                                child: ListView.builder(
                                    scrollDirection: Axis.horizontal,
                                    itemCount: tvModel3!.results!.length,
                                    itemBuilder:
                                        (BuildContext context, int index) {
                                      return InkWell(
                                        onTap: () {
                                          Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      tvDetailPage(
                                                        background: tvModel3!
                                                            .results![index]
                                                            .backdropPath
                                                            .toString(),
                                                        judul: tvModel3!
                                                            .results![index]
                                                            .name
                                                            .toString(),
                                                        poster: tvModel3!
                                                            .results![index]
                                                            .posterPath
                                                            .toString(),
                                                        realesedate: tvModel3!
                                                            .results![index]
                                                            .firstAirDate
                                                            .toString(),
                                                        popularity: tvModel3!
                                                            .results![index]
                                                            .popularity
                                                            .toString(),
                                                        overview: tvModel3!
                                                            .results![index]
                                                            .overview
                                                            .toString(),
                                                        id: tvModel3!
                                                            .results![index].id!
                                                            .toInt(),
                                                        genre: '',
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
                                                        tvModel3!
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
                    ],
                  ),
                )
              : CircularProgressIndicator()),
    );
  }
}
