import 'package:flutter/material.dart';

class NoDataWidget extends StatelessWidget {
  final String text;

  const NoDataWidget({
    super.key,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    return Center(child: Text(text));
  }
}