import 'package:flutter/material.dart';

class AnimatedAmount extends StatefulWidget {
  final double amount;
  final TextStyle? style;
  final String prefix;
  final Duration duration;

  const AnimatedAmount({
    super.key,
    required this.amount,
    this.style,
    this.prefix = '₹',
    this.duration = const Duration(milliseconds: 1200),
  });

  @override
  State<AnimatedAmount> createState() => _AnimatedAmountState();
}

class _AnimatedAmountState extends State<AnimatedAmount>
    with SingleTickerProviderStateMixin {
  late AnimationController _ctrl;
  late Animation<double> _anim;
  double _prev = 0;

  @override
  void initState() {
    super.initState();
    _ctrl = AnimationController(vsync: this, duration: widget.duration);
    _anim = Tween<double>(begin: 0.0, end: widget.amount)
        .animate(CurvedAnimation(parent: _ctrl, curve: Curves.easeOutExpo));
    _ctrl.forward();
  }

  @override
  void didUpdateWidget(AnimatedAmount old) {
    super.didUpdateWidget(old);
    if (old.amount != widget.amount) {
      _prev = old.amount;
      _anim = Tween<double>(begin: _prev, end: widget.amount).animate(
          CurvedAnimation(parent: _ctrl..reset(), curve: Curves.easeOutExpo));
      _ctrl.forward();
    }
  }

  @override
  void dispose() {
    _ctrl.dispose();
    super.dispose();
  }

  String _fmt(double v) {
    // Indian number formatting: 1,00,000 style
    final n = v.toInt();
    if (n < 1000) return '${widget.prefix}$n';
    if (n < 100000) return '${widget.prefix}${(n / 1000).toStringAsFixed(1)}K';
    return '${widget.prefix}${(n / 100000).toStringAsFixed(1)}L';
  }

  @override
  Widget build(BuildContext context) => AnimatedBuilder(
        animation: _anim,
        builder: (_, __) => Text(_fmt(_anim.value), style: widget.style),
      );
}
