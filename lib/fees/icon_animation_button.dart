import 'package:flutter/material.dart';
//import 'package:flutter/services.dart';
//import 'package:rive/rive.dart';

class IconAnimationButton extends StatefulWidget {
  const IconAnimationButton(
      {Key? key,
      required this.isScrollable,
      required this.text,
      required this.color,
      required this.content,
      required this.onPressed})
      : super(key: key);

  final bool isScrollable;
  final String text;
  final VoidCallback onPressed;
  final Color color;
  final String content;

  @override
  State<IconAnimationButton> createState() => _IconAnimationButtonState();
}

class _IconAnimationButtonState extends State<IconAnimationButton>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;

  var isPlaying = false;
  var animateIconFile = 'assets/animated_arrow.riv';
  double _height = 0;
  late double _boxheight;
  // late SMITrigger start,end,toggle;
  // late Artboard artBoard;
  // late StateMachineController _stateMachineController;

  void _handleOnPressed() {
    setState(() {
      isPlaying = !isPlaying;
      isPlaying
          ? _animationController.forward()
          : _animationController.reverse();
    });
  }

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 450));
    //initArtBoard();
  }

  // void initArtBoard() {
  //
  //   rootBundle.load(animateIconFile).then((value){
  //     final file = RiveFile.import(value);
  //     final art = file.mainArtboard;
  //     _stateMachineController = StateMachineController.fromArtboard(art, 'State Machine 1')!;
  //     art.addController(_stateMachineController);
  //
  //     setState(() {
  //       artBoard = art;
  //     });
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    _boxheight = (MediaQuery.of(context).size.height * 20) / 100;
    return Column(
      children: [
        Padding(
          padding:
              const EdgeInsets.only(left: 2.0, bottom: 0, top: 2.0, right: 2.0),
          child: TextButton(
            style: ButtonStyle(
              fixedSize: MaterialStateProperty.all(
                  Size(MediaQuery.of(context).size.width, 50)),
              foregroundColor: MaterialStateProperty.all(Colors.white),
              backgroundColor: MaterialStateProperty.all(widget.color),
              shape: MaterialStateProperty.all(
                RoundedRectangleBorder(
                  borderRadius: BorderRadius.only(
                    topRight: const Radius.circular(5),
                    topLeft: const Radius.circular(5),
                    bottomLeft: Radius.circular(_height == 0?5:0),
                    bottomRight: Radius.circular(_height == 0?5:0),
                  ),
                ),
              ),
            ),
            onPressed: () {
              _handleOnPressed();
              setState(() {
                _height = _height == 0 ? _boxheight : 0;
              });
            },
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    widget.text,
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                  Row(
                    children: [
                      Text(
                        widget.content,
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                      if (widget.isScrollable)
                        const SizedBox(
                          width: 10,
                        ),
                      if (widget.isScrollable)
                        AnimatedIcon(
                          icon: AnimatedIcons.menu_close,
                          progress: _animationController,
                        ),
                    ],
                  ),

                  //Rive(artboard: artBoard),
                ],
              ),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 2.0),
          child: AnimatedContainer(
            height: _height,
            duration: const Duration(milliseconds: 300),
            decoration: BoxDecoration(
              borderRadius: const BorderRadius.only(
                  bottomLeft: Radius.circular(10),
                  bottomRight: Radius.circular(10)),
              border: Border.all(
                color: _height == 0 ? Colors.white : widget.color,
                width: 1,
                style: BorderStyle.solid,
              ),
            ),
          ),
        )
      ],
    );
  }
}
