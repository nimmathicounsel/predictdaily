import 'dart:async';
import 'package:flutter/material.dart';

class CountDownIndicator extends StatefulWidget {
  final int startSeconds;

  const CountDownIndicator({
    super.key,
    this.startSeconds = 60,
  });

  @override
  State<CountDownIndicator> createState() =>
      _CountDownIndicatorState();
}

class _CountDownIndicatorState
    extends State<CountDownIndicator> {

  late int _seconds;
  Timer? _timer;

  @override
  void initState() {
    super.initState();

    _seconds = widget.startSeconds;

    _timer = Timer.periodic(
      const Duration(seconds: 1),
      (timer) {
        if (!mounted) return;

        if (_seconds > 0) {
          setState(() {
            _seconds--;
          });
        } else {
          timer.cancel();
        }
      },
    );
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Text(
            'Analyzing ...',
            style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.w600,
            ),
          ),

          const SizedBox(height: 16),

          Text(
            '$_seconds',
            style: const TextStyle(
              fontSize: 64,
              fontWeight: FontWeight.bold,
            ),
          ),

          const SizedBox(height: 8),

          const Text(
            'seconds',
            style: TextStyle(
              fontSize: 18,
            ),
          ),
        ],
      ),
    );
  }
}