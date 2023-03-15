import 'package:flutter/material.dart';
import 'dart:convert';
import 'jokesclass.dart';
import 'package:http/http.dart' as http;

void main() {
  runApp(const MaterialApp(
    home: HomePage(),
    debugShowCheckedModeBanner: false,
  ));
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Jokes? jokes;
  String jokessetup = "";
  String jokespunchline = "";
  fetchJokes() async {
    Uri url = Uri.parse("https://official-joke-api.appspot.com/random_joke");

    final response = await http.get(url);

    if (response.statusCode == 200) {
      final body = json.decode(response.body) as Map<String, dynamic>;
      setState(
        () {
          jokes = Jokes.fromJson(body);
          jokessetup = jokes!.setup;
          jokespunchline = jokes!.punchline;
        },
      );
    } else {
      print('Error');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Just For Laugh',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30),
        ),
        centerTitle: true,
        automaticallyImplyLeading: false,
        toolbarHeight: 60,
        backgroundColor: Colors.blueAccent,
        shadowColor: Colors.white,
      ),
      body: Padding(
        padding: const EdgeInsets.all(3),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(
              height: 70,
            ),
            Text(
              "SETUP: $jokessetup",
              style: const TextStyle(
                  fontSize: 20,
                  color: Colors.white,
                  fontStyle: FontStyle.italic),
            ),
            const SizedBox(height: 40),
            Text(
              "PUNCHLINE : $jokespunchline",
              style: const TextStyle(
                  fontSize: 20,
                  color: Colors.white,
                  fontStyle: FontStyle.italic),
            ),
            const SizedBox(height: 20),
            const SizedBox(
              height: 100,
            ),
            ElevatedButton(
              onPressed: () => fetchJokes(),
              child: const Center(
                child: Padding(
                  padding: EdgeInsets.symmetric(vertical: 5, horizontal: 30),
                  child: Text(
                    "New Joke",
                    style: TextStyle(fontSize: 20),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
      backgroundColor: Colors.black,
    );
  }
}
