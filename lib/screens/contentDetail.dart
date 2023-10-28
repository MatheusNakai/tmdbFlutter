import 'package:flutter/material.dart';

class ContentDetail extends StatelessWidget {
  final Map<String, dynamic> contentData;

  ContentDetail({required this.contentData});

  @override
  Widget build(BuildContext context) {
    String name = contentData['name'];
    String posterUrl = contentData['posterUrl'];
    String overview = contentData['overview'];
    String type = contentData['type'];
    var extraInfo = contentData['extraInfo'];
    var subtitle1;
    var subtitle2;
    if (type == 'Movie' || type == 'Tv Series') {
      subtitle1 = 'Sinopse';
      subtitle2 = 'Gêneros';
    } else {
      subtitle1 = 'Biografia';
      subtitle2 = 'Conhecido por';
    }
    return Scaffold(
      appBar: AppBar(
        title: Text('$type Details'),
        backgroundColor: Color.fromARGB(255, 125, 1, 1),
      ),
      backgroundColor: Color(0xFF222222),
      body: SingleChildScrollView(
        child: Center(
          child: Container(
            width: MediaQuery.of(context).size.width * 0.8,
            decoration: BoxDecoration(
              color: Color(0xFF222222),
              border: Border.all(
                color: Colors.red,
                width: 2.0,
              ),
              borderRadius: BorderRadius.circular(16.0),
            ),
            padding: EdgeInsets.all(16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Image.network(posterUrl,
                    height: MediaQuery.of(context).size.height * 0.5),
                SizedBox(height: 16),
                Text(
                  name,
                  style: TextStyle(
                    color: Colors.red,
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 16),
                Container(
                  decoration: BoxDecoration(
                    color: Color(0xFF222222),
                    border: Border.all(
                      color: Colors.red,
                      width: 2.0,
                    ),
                    borderRadius: BorderRadius.circular(16.0),
                  ),
                  padding: EdgeInsets.all(16.0),
                  child: Column(
                    children: [
                      Text(subtitle1,
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          )),
                      SizedBox(height: 16),
                      Text(
                        overview,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 16),
                Text(
                  subtitle2,
                  style: TextStyle(
                    color: Colors.red,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 16),
                Text(
                  extraInfo.toString(),
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                  ),
                ),
                SizedBox(
                    height:
                        40), // Add an empty space of 16 logical pixels below the last Container
              ],
            ),
          ),
        ),
      ),
    );
  }
}
