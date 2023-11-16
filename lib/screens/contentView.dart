// ignore_for_file: must_be_immutable

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'contentDetail.dart';

class ContentView extends StatefulWidget {
  late List<dynamic> content;
  late String appBarTitle;
  ContentView(this.content, this.appBarTitle);

  @override
  _ContentView createState() =>
      // TODO: implement createState
      _ContentView(content, appBarTitle);
}

class _ContentView extends State<ContentView> {
  late List<dynamic> content;
  late String appBarTitle;
  _ContentView(this.content, this.appBarTitle);

  Future<http.Response> getDetails(String mediaType, int id) {
    String bearer =
        "eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiI4NGJkMzExODc5NjAxOTk2OWQyZmVlMTNhNThiY2Y5MCIsInN1YiI6IjY0ZjA4MWRjY2FhNTA4MDBhYjcxZDM0YSIsInNjb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9uIjoxfQ.wf4s0kVeBajUQe3tOUoS7Wkiemt47UNlmzYGphWY0vY";
    String url = "https://api.themoviedb.org/3/$mediaType/$id?language=pt-BR";
    return http.get(
      Uri.parse(url),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': 'Bearer $bearer'
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(appBarTitle),
        centerTitle: true,
        backgroundColor: Color.fromARGB(255, 125, 1, 1),
      ),
      body: Container(
          decoration: const BoxDecoration(
              image: DecorationImage(
            image: NetworkImage(
                'https://nkpremices.com/content/images/size/w1100/2021/08/mih10uhu1464fx1kr0by-1.jpg'),
            fit: BoxFit.cover,
          )),
          child: ListView.builder(
              itemCount: content.length,
              itemBuilder: (context, index) {
                return GestureDetector(
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    children: <Widget>[
                      Container(
                          margin: EdgeInsets.all(10.0),
                          height: 100,
                          decoration: BoxDecoration(
                            color: Color(0xFF222222),
                            border: Border.all(
                              color: Colors.red,
                              width: 2.0,
                            ),
                            borderRadius: BorderRadius.circular(16.0),
                          ),
                          child: ListTileTheme(
                            tileColor: Color(0xFF222222),
                            child: ListTile(
                              dense: true,
                              contentPadding: EdgeInsets.symmetric(
                                  horizontal: 10.0, vertical: 10.0),
                              style: ListTileStyle.drawer,
                              leading: Image.network(content[index].posterPath,
                                  height: 300, width: 80, fit: BoxFit.fill),
                              title: Text(
                                content[index].name,
                                textAlign: TextAlign.left,
                                textDirection: TextDirection.ltr,
                                style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.red,
                                ),
                                strutStyle: StrutStyle(height: 3.5),
                              ),
                            ),
                          ))
                    ],
                  ),
                  onTap: () {
                    var image = "https://image.tmdb.org/t/p/original";

                    if (content[index].runtimeType.toString() == 'Movie\$') {
                      getDetails('movie', content[index].id).then(
                        (response) {
                          var body = jsonDecode(response.body);
                          var genres = [];
                          for (var genre in body['genres']) {
                            genres.add(genre['name']);
                          }

                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    ContentDetail(contentData: {
                                      'name': body['title'],
                                      'posterUrl':
                                          image + body['backdrop_path'],
                                      'overview': body['overview'],
                                      'extraInfo': genres,
                                      'type': 'Movie'
                                    })),
                          );
                        },
                      );
                    }
                    if (content[index].runtimeType.toString() == 'TvSeries\$') {
                      getDetails('tv', content[index].id).then(
                        (response) {
                          var body = jsonDecode(response.body);
                          var genres = [];
                          for (var genre in body['genres']) {
                            genres.add(genre['name']);
                          }
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    ContentDetail(contentData: {
                                      'name': body['name'],
                                      'posterUrl':
                                          image + body['backdrop_path'],
                                      'overview': body['overview'],
                                      'type': 'Tv Series',
                                      'extraInfo': genres
                                    })),
                          );
                        },
                      );
                    }
                    if (content[index].runtimeType.toString() == 'Person\$') {
                      getDetails('person', content[index].id).then(
                        (response) {
                          var body = jsonDecode(response.body);
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    ContentDetail(contentData: {
                                      'name': body['name'],
                                      'posterUrl': image + body['profile_path'],
                                      'overview': body['biography'],
                                      'type': 'Person',
                                      'extraInfo': content[index].knownFor
                                    })),
                          );
                        },
                      );
                    }
                  },
                );
              })),
    );
  }
}
