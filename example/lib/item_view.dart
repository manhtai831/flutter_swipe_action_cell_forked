import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_swipe_action_cell_forked/core/cell.dart';
import 'package:flutter_swipe_action_cell_forked/core/controller.dart';

import 'main.dart';

class ItemView extends StatefulWidget {
  const ItemView({Key? key, this.item, this.controller}) : super(key: key);
  final Model? item;
  final SwipeActionController? controller;
  @override
  State<ItemView> createState() => _ItemViewState();
}

class _ItemViewState extends State<ItemView> with TickerProviderStateMixin {
  late Animation<double> animation;
  late AnimationController controller;

  @override
  void initState() {
    super.initState();
    controller = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 500),
      value: 0.0,
    );
    animation = Tween<double>(begin: 0, end: 1).animate(controller);
  }

  Future<void> onDoneAnimation() async {
    await controller.forward();
  }

  Future<void> onResetAnimation() async {
    controller.reverse();
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return Stack(
      children: [
        Container(
          width: width,
          height: 80,
          decoration: BoxDecoration(color: Colors.red),
          child: Row(
            children: [
              Expanded(child: Text('Texxt nay hienj ra khi sur dung cu chi')),
              Spacer(),
              Expanded(child: Text('Texxt nay hienj ra khi sur dung cu chi')),
            ],
          ),
        ),
        FadeTransition(
            opacity: animation,
            child: Container(
              width: width,
              color: Colors.white,
              child: GestureDetector(
                onTap: () {
                  Navigator.push(context, CupertinoPageRoute(builder: (ctx) => const HomePage()));
                },
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Text("This is index of ${widget.item?.index}", style: const TextStyle(fontSize: 30)),
                ),
              ),
            )),
        SwipeActionCell(
          controller: widget.controller,
          index: widget.item?.index,
          backgroundColor: Colors.transparent,
          key: ValueKey(widget.item),
          doneAnimation: onDoneAnimation,
          afterResetAnimation: onResetAnimation,
          trailingActions: [SwipeAction(onTap: (v) {}, performsFirstActionWithFullSwipe: true)],
          leadingActions: [SwipeAction(onTap: (v) {}, performsFirstActionWithFullSwipe: true)],
          child: Container(
            color: Colors.white,
            child: GestureDetector(
              onTap: () {
                Navigator.push(context, CupertinoPageRoute(builder: (ctx) => const HomePage()));
              },
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Text("This is index of ${widget.item?.index}", style: const TextStyle(fontSize: 30)),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
