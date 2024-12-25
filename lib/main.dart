import 'package:flutter/material.dart';
import 'dart:async';
import 'package:audioplayers/audioplayers.dart';
import 'package:snowfall_or_anythings/snowfall_or_anythings.dart';

void main() => runApp(CountdownApp());

class CountdownApp extends StatelessWidget {
  const CountdownApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(home: CountdownPage());
  }
}

class CountdownPage extends StatefulWidget {
  const CountdownPage({super.key});

  @override
  CountdownPageState createState() => CountdownPageState();
}

class CountdownPageState extends State<CountdownPage> {
  final AudioPlayer _audioPlayer = AudioPlayer();
  late Timer _timer;
  Duration _timeLeft = Duration();

  @override
  void initState() {
    super.initState();
    _startCountdown();
  }

  void _startCountdown() {
    final current = DateTime.now();
    final christmas = DateTime(current.year, 12, 25);
    _timeLeft = christmas.difference(current);
    _timer = Timer.periodic(Duration(seconds: 1), (_) {
      setState(() {
        _timeLeft -= Duration(seconds: 1);
      });
    });
  }

  void _playMusic() async {
    await _audioPlayer.play(AssetSource('jinglebells.mp3'));
  }

  @override
  void dispose() {
    _audioPlayer.dispose();
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Christmas Countdown!! Celebrate!"), backgroundColor: Colors.red[900],),
      body: Stack(
        children: [
          // Snowfall effect as the background
          Container(
            color: Colors.red[900], // Set the desired background color here
            child: const SnowfallOrAnythings(
              numberOfParticles: 200,
              particleSize: 4.0,
              particleSpeed: 0.8,
              particleType: ParticleType.snowflake,
            ),
          ),
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  "🎄 Get ready for Christmas! 🎁",
                  style: TextStyle(
                      fontSize: 30, fontWeight: FontWeight.bold, color: Colors.white),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 20),
                Text(
                  "${_timeLeft.inDays} Days, ${_timeLeft.inHours % 24} Hours, "
                  "${_timeLeft.inMinutes % 60} Minutes, ${_timeLeft.inSeconds % 60} Seconds",
                  style: const TextStyle(fontSize: 30, color: Colors.white),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 20),
                const Text(
                  "Keep the Christmas spirit alive! 🎅",
                  style: TextStyle(
                      fontSize: 30,
                      color: Colors.green),
                ),
                const SizedBox(height: 10),
                const Text(
                  "Don't forget to complete your holiday preparations. ⛄",
                  style: TextStyle(fontSize: 30, color: Colors.blueAccent),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: _playMusic,
                  child: const Text("Play Christmas Music 🎶"),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
