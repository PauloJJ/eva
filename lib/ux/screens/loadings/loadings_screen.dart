import 'package:eva/ux/screens/loadings/widgets/loading_01_widget.dart';
import 'package:eva/ux/screens/loadings/widgets/loading_02_widget.dart';
import 'package:flutter/material.dart';

class LoadingsScreen extends StatelessWidget {
  final int loadingIndex;

  const LoadingsScreen({
    super.key,
    required this.loadingIndex,
  });

  @override
  Widget build(BuildContext context) {
    if (loadingIndex == 1) {
      return Loading01Widget();
    } else {
      return Loading02Widget();
    }
  }
}
