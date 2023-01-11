import 'dart:convert';
import 'dart:ui';

import 'package:api_movielist/database/database_model.dart';
import 'package:api_movielist/detailPage.dart';
import 'package:api_movielist/MovieListModel.dart';
import 'package:api_movielist/detail_movie_model.dart';
import 'package:api_movielist/video_movie_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:http/http.dart' as http;
import 'dart:io' show Platform;

import 'package:url_launcher/url_launcher.dart';
import 'package:url_launcher/url_launcher_string.dart';

import 'database/database_model.dart';
import 'database/movie_database.dart';

class detailPage extends StatefulWidget {
  detailPage({
    Key? key,
    required this.id,
  }) : super(key: key);
  final int id;

  @override
  State<detailPage> createState() => _detailPageState();
}

class _detailPageState extends State<detailPage> {
  CastListModel? castListModel;
  VideoMovieModel? _videoMovieModel;
  DetailMovieModel? detailMovieModel;
  Genres? genres;
  bool isloaded = true;
  bool isOn = false;
  List<MovieModel> dataListMovie = [];

  Future<void> _launchInBrowser(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {}
  }

  void getAllListCast() async {
    WidgetsFlutterBinding.ensureInitialized();
    setState(() {
      isloaded = false;
    });
    final res4 = await http.get(
      Uri.parse(
          "https://api.themoviedb.org/3/movie/${widget.id.toString()}/credits?api_key=fba4f8e25e3a917422cc1659f99c670b&language=en-US"),
    );
    castListModel = CastListModel.fromJson(jsonDecode(res4.body.toString()));
    setState(() {
      isloaded = true;
    });
    setState(() {
      isloaded = false;
    });
    final res5 = await http.get(
      Uri.parse(
          "https://api.themoviedb.org/3/movie/${widget.id.toString()}/videos?api_key=fba4f8e25e3a917422cc1659f99c670b&language=en-US"),
    );
    _videoMovieModel =
        VideoMovieModel.fromJson(jsonDecode(res5.body.toString()));
    setState(() {
      isloaded = true;
    });
    setState(() {
      isloaded = false;
    });
    final res6 = await http.get(
      Uri.parse(
          "https://api.themoviedb.org/3/movie/${widget.id.toString()}?api_key=fba4f8e25e3a917422cc1659f99c670b&language=en-US"),
    );
    detailMovieModel =
        DetailMovieModel.fromJson(jsonDecode(res6.body.toString()));
    setState(() {
      isloaded = true;
    });
    setState(() {
      isloaded = false;
    });
    final res = await http.get(
      Uri.parse(
          "https://api.themoviedb.org/3/genre/movie/list?api_key=[MY_KEY]&language=en-US"),
    );
    genres = Genres.fromJson(jsonDecode(res.body.toString()));
    dataListMovie = await MovieDatabase.instance.readAll();
    setState(() {
      isloaded = true;
    });
    for (var i = 0; i < dataListMovie.length; i++) {
      if (dataListMovie[i].name == detailMovieModel!.title.toString()) {
        isOn = true;
      }
    }
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
          actions: [
            InkWell(
              child: Icon(
                isOn ? Icons.bookmark : Icons.bookmark_border,
                color: Colors.grey,
                size: 25,
              ),
              onTap: () async {
                setState(() {
                  isOn = !isOn;
                });

                String? namaa = widget.id.toString();
                var karyawan;
                karyawan = MovieModel(
                    imagePath:
                        "https://www.themoviedb.org/t/p/w220_and_h330_face/" +
                            detailMovieModel!.posterPath.toString(),
                    name: detailMovieModel!.originalTitle.toString(),
                    idMovie: detailMovieModel!.id.toString());
                await MovieDatabase.instance.create(karyawan);
                Navigator.pop(context, "result");
                final snackBar = SnackBar(
                  content: const Text('Movie Disimpan!!'),
                  backgroundColor: (Colors.grey),
                  action: SnackBarAction(
                    label: 'Oke',
                    onPressed: () {},
                  ),
                );
                ScaffoldMessenger.of(context).showSnackBar(snackBar);
              },
            ),
          ],
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
                                    detailMovieModel!.backdropPath!.toString(),
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
                                            detailMovieModel!.posterPath!
                                                .toString()),
                                  ),
                                ),
                                Container(
                                  margin: EdgeInsets.only(top: 14),
                                  child: Text(
                                    detailMovieModel!.title!.toString(),
                                    style: TextStyle(fontSize: 18),
                                  ),
                                ),
                                Container(
                                  margin: EdgeInsets.only(top: 14),

                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text("Genre : "),
                                      Text(
                                        detailMovieModel!.genres![0].name!
                                                .toString() +
                                            ", ",
                                        style: TextStyle(fontSize: 12),
                                      ),
                                      Text(
                                        detailMovieModel!.genres![0].name!
                                            .toString(),
                                        style: TextStyle(fontSize: 12),
                                      )
                                    ],
                                  ),

                                  // child:
                                ),
                                Container(
                                  margin: EdgeInsets.only(top: 14),
                                  child: Text(
                                    "Release : " +
                                        detailMovieModel!.releaseDate!
                                            .toString(),
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
                                        detailMovieModel!.popularity!
                                            .toString(),
                                        style: TextStyle(fontSize: 12),
                                      )
                                    ],
                                  ),
                                ),
                                Container(
                                    padding: EdgeInsets.all(15),
                                    margin: EdgeInsets.only(top: 3),
                                    child: Text(
                                      detailMovieModel!.overview!.toString(),
                                      style: TextStyle(fontSize: 12),
                                    )),
                              ],
                            ),
                          ),
                        ],
                      ),
                      Container(
                        height: 155,
                        padding: EdgeInsets.all(10),
                        child: Column(
                          children: [
                            Container(
                              padding: EdgeInsets.only(left: 5, bottom: 5),
                              alignment: Alignment.centerLeft,
                              child: Text(
                                "CASTS",
                              ),
                            ),
                            Container(
                              height: 105,
                              child: ListView.builder(
                                  scrollDirection: Axis.horizontal,
                                  itemCount:
                                      castListModel!.cast!.length.bitLength,
                                  itemBuilder:
                                      (BuildContext context, int index) {
                                    return Column(
                                      children: [
                                        Container(
                                          padding: EdgeInsets.all(5),
                                          child: ClipOval(
                                              child: SizedBox.fromSize(
                                            size: Size.fromRadius(40),
                                            child: FadeInImage.assetNetwork(
                                                fit: BoxFit.cover,
                                                placeholder: 'assets/giphy.gif',
                                                image:
                                                    "https://image.tmdb.org/t/p/w200" +
                                                        castListModel!
                                                            .cast![index]
                                                            .profilePath
                                                            .toString()),
                                          )),
                                        ),
                                        Container(
                                          child: Text(
                                            castListModel!.cast![index].name
                                                .toString(),
                                            style: TextStyle(fontSize: 10),
                                          ),
                                        )
                                      ],
                                    );
                                  }),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.only(left: 7, right: 7, bottom: 5),
                        child: Stack(
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(15),
                              child: ColorFiltered(
                                  colorFilter: ColorFilter.mode(
                                      Colors.black.withOpacity(0.2),
                                      BlendMode.colorBurn),
                                  child: Image.network(
                                      "https://themoviedb.org/t/p/w500/" +
                                          detailMovieModel!.backdropPath!
                                              .toString())),
                            ),
                            Container(
                              margin: EdgeInsets.only(top: 70),
                              child: InkWell(
                                  onTap: () {
                                    launchUrl(Uri.parse(
                                        "https://www.youtube.com/watch?v=" +
                                            _videoMovieModel!.results![0].key
                                                .toString()));
                                    LaunchMode.externalApplication;
                                  },
                                  child: Center(
                                    child: Column(
                                      children: [
                                        Icon(
                                          Icons.play_circle_outline,
                                          color: Colors.yellow,
                                          size: 65,
                                        ),
                                      ],
                                    ),
                                  )),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              )
            : Center(child: CircularProgressIndicator()));
  }
}
