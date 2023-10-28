// ignore_for_file: must_be_immutable

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:tmdbflutter/models/Person.dart';

import '../models/Movie.dart';
import '../models/TvSeries.dart';
import 'contentView.dart';

class SearchTab extends StatelessWidget {
  late String query;

  SearchTab({super.key});
  String bearer =
      "eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiI4NGJkMzExODc5NjAxOTk2OWQyZmVlMTNhNThiY2Y5MCIsInN1YiI6IjY0ZjA4MWRjY2FhNTA4MDBhYjcxZDM0YSIsInNjb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9uIjoxfQ.wf4s0kVeBajUQe3tOUoS7Wkiemt47UNlmzYGphWY0vY";
  // Add functionality for searchMovies
  Future<http.Response> _searchMovies(String query) {
    var _query = query.replaceAll(' ', "%20");
    String url =
        "https://api.themoviedb.org/3/search/multi?query=$_query&include_adult=false&language=pt-BR&page=1";
    return http.get(
      Uri.parse(url),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': 'Bearer $bearer'
      },
    );
  }

  Future<http.Response> getTrending(String type) {
    String url =
        "https://api.themoviedb.org/3/trending/$type/week?language=pt-BR&page=1";
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
        title: Text('TMDB'),
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
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: EdgeInsets.all(8.0),
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(25.0),
                ),
                width: 300, // Adjust the width as needed
                child: TextField(
                  onSubmitted: (value) {
                    _searchMovies(value).then((response) {
                      if (response.statusCode == 200) {
                        List<dynamic> content = [];
                        List<dynamic> content2 = [];
                        var body = jsonDecode(response.body);
                        body['results'].forEach((item) {
                          if (item['media_type'] == 'tv') {
                            content.add(TvSeries.fromJson(item));
                            if (!content2.contains(['media_type'])) {
                              content2.add(TvSeries.fromJson(item).runtimeType);
                            }
                          }
                          if (item['media_type'] == 'movie') {
                            content.add(Movie.fromJson(item));
                            if (!content2.contains(['media_type'])) {
                              content2.add(Movie.fromJson(item).runtimeType);
                            }
                          }
                          if (item['media_type'] == 'person') {
                            content.add(Person.fromJson(item));
                            if (!content2.contains(['media_type'])) {
                              content2.add(Person.fromJson(item).runtimeType);
                            }
                          }
                        });
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    ContentView(content, 'Search Results')));
                      } else {
                        print(response.statusCode);
                      }
                    });
                  },
                  decoration: InputDecoration(
                    hintText: 'Pesquisa',
                    fillColor: Colors.white,
                    prefixIcon: Icon(Icons.search),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(25.0),
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    primary: Color.fromARGB(255, 125, 1, 1), // background
                    onPrimary: Colors.white, // foreground
                  ),
                  onPressed: () {
                    // Add functionality for button 1
                    getTrending('movie').then((response) {
                      if (response.statusCode == 200) {
                        List<dynamic> content = [];
                        var body = jsonDecode(response.body);
                        body['results'].forEach((item) {
                          content.add(Movie.fromJson(item));
                        });
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    ContentView(content, 'Trending Movies')));
                      } else {
                        print(response.statusCode);
                      }
                    });
                  },
                  child: Text(
                    'Trending Movies',
                    textScaleFactor: 0.8,
                  ),
                ),
                SizedBox(width: 10),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    primary: Color.fromARGB(255, 125, 1, 1), // background
                    onPrimary: Colors.white, // foreground
                  ),
                  onPressed: () {
                    // Add functionality for button 2
                    getTrending('tv').then((response) {
                      if (response.statusCode == 200) {
                        List<dynamic> content = [];
                        var body = jsonDecode(response.body);

                        body['results'].forEach((item) {
                          content.add(TvSeries.fromJson(item));
                        });
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    ContentView(content, 'Trending TV')));
                      } else {
                        print(response.statusCode);
                      }
                    });
                  },
                  child: Text(
                    'Trending TV',
                    textScaleFactor: 0.8,
                  ),
                ),
                SizedBox(width: 10),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    primary: Color.fromARGB(255, 125, 1, 1), // background
                    onPrimary: Colors.white, // foreground
                  ),
                  onPressed: () {
                    // Add functionality for button 3
                    getTrending('person').then((response) {
                      if (response.statusCode == 200) {
                        List<dynamic> content = [];
                        var body = jsonDecode(response.body);

                        body['results'].forEach((item) {
                          content.add(Person.fromJson(item));
                        });

                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    ContentView(content, 'Trending People')));
                      } else {
                        print(response.statusCode);
                      }
                    });
                  },
                  child: Text(
                    'Trending People',
                    textScaleFactor: 0.8,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
