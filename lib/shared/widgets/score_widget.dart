import 'package:cardmate/shared/enums/rise_mode.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class ScoreWidget extends StatefulWidget {
  final String teamName;
  final int score;
  final void Function(int value) onAdd;
  final VoidCallback onSubtract;
  final void Function(String)? onNameChanged;
  final RiseMode riseMode;
  const ScoreWidget(
      {super.key,
      required this.teamName,
      required this.score,
      required this.onAdd,
      required this.onSubtract,
      this.onNameChanged,
      required this.riseMode});

  @override
  State<ScoreWidget> createState() => _ScoreWidgetState();
}

class _ScoreWidgetState extends State<ScoreWidget> {
  bool _isInverted = false;

  @override
  Widget build(BuildContext context) {
    return Material(
      borderRadius: BorderRadius.circular(8),
      clipBehavior: Clip.antiAlias,
      color: Colors.transparent,
      child: InkWell(
        onTap: () {
          setState(() {
            _isInverted = !_isInverted;
          });
        },
        child: Transform(
          alignment: Alignment.center,
          transform:
              _isInverted ? Matrix4.rotationX(3.14159) : Matrix4.identity(),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              TextFormField(
                onChanged: widget.onNameChanged,
                initialValue: widget.teamName,
                textAlign: TextAlign.center,
                decoration: const InputDecoration(
                  enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.transparent),
                  ),
                  focusedBorder: UnderlineInputBorder(
                    borderSide:
                        BorderSide(color: Color.fromARGB(0, 234, 221, 221)),
                  ),
                ),
                style: const TextStyle(color: Colors.white, fontSize: 38),
              ),
              Badge(
                backgroundColor: Colors.transparent,
                alignment: Alignment.centerRight,
                isLabelVisible: widget.score >= 10 && widget.score != 12,
                offset: const Offset(-18, 25),
                label: Lottie.asset(width: 30, 'assets/animations/fire.json'),
                child: Text(
                  widget.score.toString(),
                  style: TextStyle(
                      color: widget.score != 12
                          ? Colors.white
                          : Colors.amberAccent,
                      fontWeight: FontWeight.bold,
                      fontSize: 112),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  IconButton(
                      icon: const Icon(
                        Icons.remove,
                        color: Colors.white,
                      ),
                      onPressed: widget.onSubtract),
                  IconButton(
                    color: Colors.red,
                    icon: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Icon(
                          Icons.add,
                        ),
                        Text(
                          '${widget.riseMode.value}',
                          style: const TextStyle(color: Colors.red),
                        )
                      ],
                    ),
                    onPressed: () => widget.onAdd(widget.riseMode.value),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
