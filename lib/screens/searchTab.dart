import 'package:flutter/material.dart';

class SearchTab extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Search Bar with Buttons'),
        centerTitle: true,
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
              padding: EdgeInsets.all(16.0),
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(25.0),
                ),
                width: 300, // Adjust the width as needed
                child: TextField(
                  onSubmitted: (value) {
                    print(value);
                  },
                  decoration: InputDecoration(
                    hintText: 'Search',
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
                  },
                  child: Text('Trending Movies'),
                ),
                SizedBox(width: 20),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    primary: Color.fromARGB(255, 125, 1, 1), // background
                    onPrimary: Colors.white, // foreground
                  ),
                  onPressed: () {
                    // Add functionality for button 2
                  },
                  child: Text('Trending TV'),
                ),
                SizedBox(width: 20),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    primary: Color.fromARGB(255, 125, 1, 1), // background
                    onPrimary: Colors.white, // foreground
                  ),
                  onPressed: () {
                    // Add functionality for button 3
                  },
                  child: Text('Trending People'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
