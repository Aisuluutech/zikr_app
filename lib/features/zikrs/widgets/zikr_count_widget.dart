import 'package:dhikras/features/zikrs/providers/providers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ZikrCountWidget extends ConsumerStatefulWidget {
  const ZikrCountWidget({
    super.key,
    required this.count,
    required this.onIncrement,
    required this.onReset,
    required this.onInfo,
    required this.onToggleAudio,
    required this.displayText,
    required this.displayAmount,
    required this.repeat,
    required this.countValue,
    required this.isUserAdded,
  });

  final int count;
  final VoidCallback onIncrement;
  final VoidCallback onReset;
  final VoidCallback onInfo;
  final VoidCallback onToggleAudio;
  final int countValue;
  final String displayText;
  final String displayAmount;
  final String repeat;
  final bool isUserAdded;

  @override
  ConsumerState<ZikrCountWidget> createState() => _ZikrCountWidgetState();
}

class _ZikrCountWidgetState extends ConsumerState<ZikrCountWidget>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _scale;

  bool _firstBuild = true;

  @override
  void initState() {
    super.initState();

    _animationController = AnimationController(
      vsync: this,
      duration: Duration(microseconds: 1000),
    );

    _scale = Tween<double>(begin: 1, end: 1).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.elasticInOut),
    );
  }

  @override
  void didUpdateWidget(covariant ZikrCountWidget oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.count != widget.count) {
      _animationController.forward(from: 0.0);
    }
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isPlayingicon = ref.watch(audioProvider);

    final beginColor = Theme.of(context).colorScheme.onSecondaryContainer;
    final endColor = Theme.of(context).colorScheme.primaryContainer;

    final color = TweenSequence<Color?>([
      TweenSequenceItem(
        tween: ColorTween(
          begin: _firstBuild ? endColor : beginColor,
          end: endColor,
        ),
        weight: 50,
      ),
      TweenSequenceItem(
        tween: ColorTween(begin: beginColor, end: endColor),
        weight: 50,
      ),
    ]).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.elasticInOut),
    );

    if (_firstBuild) {
      _firstBuild = false;
    }

    double progress;
    if (widget.count % widget.countValue == 0 && widget.count != 0) {
      progress = 1.0;
    } else {
      progress = (widget.count % widget.countValue) / widget.countValue;
    }

    return Center(
      child: Column(
        children: [
          Center(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                if (!widget.isUserAdded)
                  IconButton(
                    onPressed: widget.onToggleAudio,
                    icon: Icon(isPlayingicon ? Icons.pause : Icons.play_arrow),
                    style: IconButton.styleFrom(
                      backgroundColor:
                          Theme.of(context).colorScheme.outlineVariant,
                    ),
                  )
                else
                  const SizedBox(width: 48, height: 48),
                GestureDetector(
                  onTap: widget.onIncrement,
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      SizedBox(
                        width: 150.w,
                        height: 150.w,
                        child: CircularProgressIndicator(
                          value: progress,
                          strokeWidth: 6.w,
                          backgroundColor: Colors.grey[300],
                          valueColor: AlwaysStoppedAnimation<Color>(
                            Theme.of(context).colorScheme.onPrimary,
                          ),
                        ),
                      ),
                      AnimatedBuilder(
                        animation: _animationController,
                        builder: (BuildContext context, Widget? child) {
                          return Transform.scale(
                            scale: _scale.value,
                            child: CircleAvatar(
                              radius: 60.w,
                              backgroundColor: color.value,
                              child: Text(
                                widget.displayText,
                                style: TextStyle(
                                  color:
                                      Theme.of(context).colorScheme.onPrimary,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 24,
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                      Positioned(bottom: 35, child: Text(widget.displayAmount)),
                    ],
                  ),
                ),
                IconButton(
                  onPressed: widget.onInfo,
                  icon: Icon(Icons.info_outline_rounded),
                  style: IconButton.styleFrom(
                    backgroundColor:
                        Theme.of(context).colorScheme.outlineVariant,
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 14.h),
          Text(
            widget.repeat,
            style: TextStyle(color: Theme.of(context).colorScheme.onSurface),
          ),
          IconButton(
            onPressed: widget.onReset,
            icon: Icon(Icons.restore_page_rounded),
          ),
        ],
      ),
    );
  }
}
