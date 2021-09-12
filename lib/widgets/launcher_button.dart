import 'package:flutter/material.dart';

class LauncherButton extends StatelessWidget {
  final String text;
  final Function onTap;
  const LauncherButton({Key key, this.text, this.onTap}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      child: Text('Baca selengkap nya'),
      style: ElevatedButton.styleFrom(
        primary: Colors.blue,
      ),
      onPressed: () {},
    );
  }
}
