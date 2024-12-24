import 'package:flutter/material.dart';
import 'dart:async';

void main() => runApp(CountdownApp());

class CountdownApp extends StatelessWidget {
  const CountdownApp({super.key}); // Use super parameter

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(home: CountdownPage());
  }
}

class CountdownPage extends StatefulWidget {
  const CountdownPage({super.key}); // Use super parameter

  @override
  _CountdownPageState createState() => _CountdownPageState();
}

class _CountdownPageState extends State<CountdownPage> {
  late Timer _timer;
  Duration _timeLeft = Duration();

  @override
  void initState() {
    super.initState();
    _startCountdown();
  }

  void _startCountdown() {
    final now = DateTime.now();
    final christmas = DateTime(now.year, 12, 25);
    _timeLeft = christmas.difference(now);
    _timer = Timer.periodic(Duration(seconds: 1), (_) {
      setState(() {
        _timeLeft -= Duration(seconds: 1);
      });
    });
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Christmas Countdown!! Celebrate!")),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Add a festive message
            const Text(
              "🎄 Get ready for Christmas! 🎁",
              style: TextStyle(
                  fontSize: 28, fontWeight: FontWeight.bold, color: Colors.red),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 20), // Spacer for better layout

            // Countdown text
            Text(
              "${_timeLeft.inDays} Days, ${_timeLeft.inHours % 24} Hours, "
              "${_timeLeft.inMinutes % 60} Minutes, ${_timeLeft.inSeconds % 60} Seconds",
              style: const TextStyle(fontSize: 24),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 20),

            // Add extra details below the countdown
            const Text(
              "Keep the Christmas spirit alive! 🎅",
              style: TextStyle(
                  fontSize: 20,
                  color: Colors.green),
            ),
            const SizedBox(height: 10),
            const Text(
              "Don't forget to complete your holiday preparations. ⛄",
              style: TextStyle(fontSize: 18),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
