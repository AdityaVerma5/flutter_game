import 'dart:math';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Rock Paper Scissors',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> with SingleTickerProviderStateMixin {
  final List<String> options = ["Rock", "Paper", "Scissors"];
  String? userChoice;
  String? computerChoice;
  String? result;
  int streak = 0;
  double opacity = 0.0;

  void _playGame(String choice) {
    setState(() {
      userChoice = choice;
      computerChoice = options[Random().nextInt(3)];
      result = _getResult(userChoice!, computerChoice!);
      opacity = 1.0;
    });
  }

  String _getResult(String user, String computer) {
    if (user == computer) {
      return "It's a draw!";
    } else if ((user == "Rock" && computer == "Scissors") ||
        (user == "Paper" && computer == "Rock") ||
        (user == "Scissors" && computer == "Paper")) {
      streak++;
      return "You win!";
    } else {
      streak = 0;
      return "You lose!";
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Rock Paper Scissors'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            if (userChoice != null && computerChoice != null)
              AnimatedOpacity(
                opacity: opacity,
                duration: const Duration(seconds: 1),
                child: Column(
                  children: [
                    Text(
                      "Your choice: $userChoice",
                      style: const TextStyle(fontSize: 20),
                    ),
                    Text(
                      "Computer's choice: $computerChoice",
                      style: const TextStyle(fontSize: 20),
                    ),
                    Text(
                      result!,
                      style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                    ),
                    Text(
                      "Streak: $streak",
                      style: const TextStyle(fontSize: 20),
                    ),
                  ],
                ),
              ),
            const SizedBox(height: 50),
            const Text(
              'Choose your option:',
              style: TextStyle(fontSize: 24),
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: options.map((option) {
                return ElevatedButton(
                  onPressed: () => _playGame(option),
                  child: Text(option),
                );
              }).toList(),
            ),
          ],
        ),
      ),
    );
  }
}
