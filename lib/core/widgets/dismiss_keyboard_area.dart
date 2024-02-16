import 'package:flutter/material.dart';

class DismissKeyboardArea extends StatefulWidget {
  final Widget child;
  final FocusScopeNode? node;
  const DismissKeyboardArea({
    super.key,
    required this.child,
    this.node,
  });

  @override
  State<DismissKeyboardArea> createState() => _DismissKeyboardAreaState();
}

class _DismissKeyboardAreaState extends State<DismissKeyboardArea> {
  late FocusScopeNode _node;

  @override
  void initState() {
    _node = widget.node ?? FocusScopeNode();
    super.initState();
  }

  void _onTap() {
    _node.unfocus();
  }

  @override
  Widget build(BuildContext context) {
    return FocusScope(
      node: _node,
      child: GestureDetector(
        onTap: _onTap,
        child: Container(
          color: Colors.transparent,
          child: widget.child,
        ),
      ),
    );
  }
}
