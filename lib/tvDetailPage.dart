import 'dart:convert';
import 'dart:ui';

import 'package:api_movielist/detail_tv_model.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:http/http.dart' as http;

class tvDetailPage extends StatefulWidget {
  const tvDetailPage(
      {Key? key,
      required this.id,
      required String background,
      required String judul,
      required String poster,
      required String realesedate,
      required String popularity,
      required String overview,
      required String genre})
      : super(key: key);
  final int id;

  @override
  State<tvDetailPage> createState() => _tvDetailPageState();
}

class _tvDetailPageState extends State<tvDetailPage> {
  TvDetailModel? tvDetailModel;

  bool isloaded = true;

  void getAllListCast() async {
    setState(() {
      isloaded = false;
    });
    final res = await http.get(
      Uri.parse(
          "https://api.themoviedb.org/3/tv/${widget.id.toString()}?api_key=fba4f8e25e3a917422cc1659f99c670b&language=en-US"),
    );
    tvDetailModel = TvDetailModel.fromJson(jsonDecode(res.body.toString()));
    setState(() {
      isloaded = true;
    });
    // setState(() {
    //   isloaded = false;
    // });
    // final res5 = await http.get(
    //   Uri.parse(
    //       "https://api.themoviedb.org/3/movie/${widget.id.toString()}/videos?api_key=fba4f8e25e3a917422cc1659f99c670b&language=en-US"),
    // );
    // _videoMovieModel =
    //     VideoMovieModel.fromJson(jsonDecode(res5.body.toString()));
    // setState(() {
    //   isloaded = true;
    // });
    // setState(() {
    //   isloaded = false;
    // });
    // final res6 = await http.get(
    //   Uri.parse(
    //       "https://api.themoviedb.org/3/movie/${widget.id.toString()}?api_key=fba4f8e25e3a917422cc1659f99c670b&language=en-US"),
    // );
    // detailMovieModel =
    //     DetailMovieModel.fromJson(jsonDecode(res6.body.toString()));
    // setState(() {
    //   isloaded = true;
    // });
    // setState(() {
    //   isloaded = false;
    // });
    // final res = await http.get(
    //   Uri.parse(
    //       "https://api.themoviedb.org/3/genre/movie/list?api_key=[MY_KEY]&language=en-US"),
    // );
    // genres = Genres.fromJson(jsonDecode(res.body.toString()));
    // setState(() {
    //   isloaded = true;
    // });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getAllListCast();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.black,
        appBar: AppBar(
          title: Text("Detail Movie"),
          backgroundColor: Colors.black,
        ),
        body: isloaded
            ? SingleChildScrollView(
                child: Container(
                  child: Column(
                    children: [
                      Stack(
                        children: [
                          ClipRRect(
                              borderRadius: BorderRadius.only(
                                  bottomLeft: Radius.circular(30),
                                  bottomRight: Radius.circular(30)),
                              child: Image.network(
                                "https://themoviedb.org/t/p/w500/" +
                                    tvDetailModel!.backdropPath!.toString(),
                              )),
                          Container(
                            width: 500,
                            height: 220,
                            child: BackdropFilter(
                              filter: ImageFilter.blur(sigmaX: 10, sigmaY: 0.0),
                              child: Container(
                                color: Colors.black.withOpacity(0.2),
                              ),
                            ),
                          ),
                          Container(
                            child: Column(
                              children: [
                                Container(
                                  height: 220,
                                  margin: EdgeInsets.only(top: 100),
                                  child: Align(
                                    alignment: Alignment(0, 0),
                                    child: Image.network(
                                        "https://themoviedb.org/t/p/w500/" +
                                            tvDetailModel!.posterPath!
                                                .toString()),
                                  ),
                                ),
                                Container(
                                  margin: EdgeInsets.only(top: 14),
                                  child: Text(
                                    tvDetailModel!.name!.toString(),
                                    style: TextStyle(fontSize: 18),
                                  ),
                                ),
                                // Container(
                                //   margin: EdgeInsets.only(top: 14),

                                //   child: Row(
                                //     mainAxisAlignment: MainAxisAlignment.center,
                                //     children: [
                                //       Text("Genre : "),
                                //       Text(
                                //         tvDetailModel!.genres![0].name!
                                //                 .toString() +
                                //             ", ",
                                //         style: TextStyle(fontSize: 12),
                                //       ),
                                //       Text(
                                //         tvDetailModel!.genres![1].name!
                                //             .toString(),
                                //         style: TextStyle(fontSize: 12),
                                //       )
                                //     ],
                                //   ),

                                //   // child:
                                // ),
                                Container(
                                  margin: EdgeInsets.only(top: 14),
                                  child: Text(
                                    "Release : ",
                                    // tvDetailModel!.episodeRunTime!
                                    //     .toString(),
                                    style: TextStyle(fontSize: 12),
                                  ),
                                ),
                                Container(
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Image.asset(
                                        'assets/star.png',
                                        width: 20,
                                      ),
                                      Text(
                                        tvDetailModel!.popularity!.toString(),
                                        style: TextStyle(fontSize: 12),
                                      )
                                    ],
                                  ),
                                ),
                                Container(
                                    padding: EdgeInsets.all(15),
                                    margin: EdgeInsets.only(top: 3),
                                    child: Text(
                                      tvDetailModel!.overview!.toString(),
                                      style: TextStyle(fontSize: 12),
                                    )),
                              ],
                            ),
                          ),
                        ],
                      ),
                      // Container(
                      //   height: 155,
                      //   padding: EdgeInsets.all(10),
                      //   child: Column(
                      //     children: [
                      //       Container(
                      //         padding: EdgeInsets.only(left: 5, bottom: 5),
                      //         alignment: Alignment.centerLeft,
                      //         child: Text(
                      //           "CASTS",
                      //         ),
                      //       ),
                      //       Container(
                      //         height: 105,
                      //         child: ListView.builder(
                      //             scrollDirection: Axis.horizontal,
                      //             itemCount:
                      //                 castListModel!.cast!.length.bitLength,
                      //             itemBuilder:
                      //                 (BuildContext context, int index) {
                      //               return Column(
                      //                 children: [
                      //                   Container(
                      //                     padding: EdgeInsets.all(5),
                      //                     child: ClipOval(
                      //                         child: SizedBox.fromSize(
                      //                       size: Size.fromRadius(40),
                      //                       child: FadeInImage.assetNetwork(
                      //                           fit: BoxFit.cover,
                      //                           placeholder: 'assets/giphy.gif',
                      //                           image:
                      //                               "https://image.tmdb.org/t/p/w200" +
                      //                                   castListModel!
                      //                                       .cast![index]
                      //                                       .profilePath
                      //                                       .toString()),
                      //                     )),
                      //                   ),
                      //                   Container(
                      //                     child: Text(
                      //                       castListModel!.cast![index].name
                      //                           .toString(),
                      //                       style: TextStyle(fontSize: 10),
                      //                     ),
                      //                   )
                      //                 ],
                      //               );
                      //             }),
                      //       ),
                      //     ],
                      //   ),
                      // ),
                      // Container(
                      //   padding: EdgeInsets.only(left: 7, right: 7, bottom: 5),
                      //   child: Stack(
                      //     children: [
                      //       ClipRRect(
                      //         borderRadius: BorderRadius.circular(15),
                      //         child: ColorFiltered(
                      //             colorFilter: ColorFilter.mode(
                      //                 Colors.black.withOpacity(0.2),
                      //                 BlendMode.colorBurn),
                      //             child: Image.network(
                      //                 "https://themoviedb.org/t/p/w500/" +
                      //                     tvDetailModel!.backdropPath!
                      //                         .toString())),
                      //       ),
                      //       Container(
                      //         margin: EdgeInsets.only(top: 70),
                      //         child: InkWell(
                      //             onTap: () {
                      //               launchUrl(Uri.parse(
                      //                   "https://www.youtube.com/watch?v=" +
                      //                       _videoMovieModel!.results![0].key
                      //                           .toString()));
                      //               LaunchMode.externalApplication;
                      //             },
                      //             child: Center(
                      //               child: Column(
                      //                 children: [
                      //                   Icon(
                      //                     Icons.play_circle_outline,
                      //                     color: Colors.yellow,
                      //                     size: 65,
                      //                   ),
                      //                 ],
                      //               ),
                      //             )),
                      //       ),
                      //     ],
                      //   ),
                      // ),
                    ],
                  ),
                ),
              )
            : Center(child: CircularProgressIndicator()));
  }
}
