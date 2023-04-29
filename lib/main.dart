import 'dart:async';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

void main() => runApp(const MyApp());

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  bool isTapped = false;
  @override
  Widget build(BuildContext context) {
    log('MaterialApp');
    return MaterialApp(
      title: 'Material App',
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Material App Bar'),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              isTapped ? const DTimer() : const SizedBox(),
              const SizedBox(height: 60,),
              ElevatedButton(
                  onPressed: () {
                    isTapped = !isTapped;
                    setState(() {});
                  },
                  child: const Text('Toggle Timer'))
            ],
          ),
        ),
      ),
    );
  }
}

class DTimer extends StatefulWidget {
  const DTimer({super.key});

  @override
  State<DTimer> createState() => _TimerState();
}

class _TimerState extends State<DTimer> {
  Timer? _timer;
  Duration _duration = const Duration(seconds: 0);
  final formater = NumberFormat('00');
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
        _duration = _duration + const Duration(seconds: 1);
        setState(() {});
      });
    });
    super.initState();
  }

  @override
  void dispose() {
    if (_timer?.isActive ?? true) _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    log('DTimer');
    return Center(
      child: Text(
          '${formater.format(_duration.inHours)} : ${formater.format(_duration.inMinutes.remainder(60))} : ${formater.format(_duration.inSeconds.remainder(60))}'),
    );
  }
}
