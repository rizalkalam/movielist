import 'dart:convert';

import 'package:api_movielist/MovieListModel.dart';
import 'package:api_movielist/trendDetailPage.dart';
import 'package:api_movielist/trending_model.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class listview3 extends StatefulWidget {
  const listview3({Key? key}) : super(key: key);

  @override
  State<listview3> createState() => _listview3State();
}

class _listview3State extends State<listview3> {
  TrendingModel? trendingModel;
  bool isloaded = true;

  void getAllListTrnd() async {
    setState(() {
      isloaded = false;
    });
    final res = await http.get(
      Uri.parse(
          "https://api.themoviedb.org/3/trending/movie/day?api_key=fba4f8e25e3a917422cc1659f99c670b"),
    );
    print("status code " + res.statusCode.toString());
    trendingModel = TrendingModel.fromJson(json.decode(res.body.toString()));
    setState(() {
      isloaded = true;
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getAllListTrnd();
  }
  // MovieListModel3? movieListModel;
  // bool isloaded = true;

  // void getAllListPL() async {
  //   setState(() {
  //     isloaded = false;
  //   });
  //   final res = await http.get(
  //     Uri.parse(
  //         "https://api.themoviedb.org/3/movie/popular?api_key=fba4f8e25e3a917422cc1659f99c670b&language=en-US&page=1"),
  //   );
  //   print("status code " + res.statusCode.toString());
  //   movieListModel = MovieListModel3.fromJson(json.decode(res.body.toString()));
  //   setState(() {
  //     isloaded = true;
  //   });
  // }

  // @override
  // void initState() {
  //   // TODO: implement initState
  //   super.initState();
  //   getAllListPL();
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          child: isloaded
              ? ListView.builder(
                  itemCount: trendingModel!.results!.length,
                  itemBuilder: (BuildContext context, int index) {
                    return InkWell(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => trendDetailPage(
                                      background: trendingModel!
                                          .results![index].backdropPath
                                          .toString(),
                                      judul: trendingModel!
                                          .results![index].title
                                          .toString(),
                                      poster: trendingModel!
                                          .results![index].posterPath
                                          .toString(),
                                      realesedate: trendingModel!
                                          .results![index].releaseDate
                                          .toString(),
                                      popularity: trendingModel!
                                          .results![index].popularity
                                          .toString(),
                                      overview: trendingModel!
                                          .results![index].overview
                                          .toString(),
                                      id: trendingModel!.results![index].id!
                                          .toInt(),
                                      genre: '',
                                    )));
                      },
                      child: Card(
                        margin: EdgeInsets.all(5),
                        child: Row(
                          children: [
                            Container(
                                margin: EdgeInsets.only(left: 10),
                                width: 87,
                                height: 150,
                                child: Image.network(
                                  "https://themoviedb.org/t/p/w500/" +
                                      trendingModel!.results![index].posterPath
                                          .toString(),
                                )),
                            Container(
                              margin: EdgeInsets.only(left: 20),
                              child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      trendingModel!.results![index].title
                                          .toString(),
                                      overflow: TextOverflow.ellipsis,
                                      maxLines: 3,
                                    )
                                  ]),

                              // Text(movieListModel!
                              //     .results2![index].originalTitle
                              //     .toString()),
                              // Text(movieListModel!
                              //     .results2![index].releaseDate
                              //     .toString()),
                            ),
                          ],
                        ),
                      ),
                    );
                  })
              : CircularProgressIndicator(),
        ),
      ),
    );
  }
}
