import 'package:antap/screens/map/pop_up/widgets/appbar.dart';
import 'package:antap/screens/map/pop_up/widgets/body.dart';
import 'package:antap/screens/map/pop_up/widgets/gutter.dart';
import 'package:flutter/material.dart';
import 'package:antap/src/appbar.dart';
import 'package:antap/src/gutter.dart';
import 'package:antap/src/card.dart';

class PopUp extends StatefulWidget {
  const PopUp({Key? key}) : super(key: key);

  @override
  State<PopUp> createState() => _PopUpState();
}

class _PopUpState extends State<PopUp> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            cardWithGutterAndAppBar(),
            // cardWithBodyOnly(),
            // cardWithAppBarOnly(),
            // cardWithGutterOnly(),
          ],
        ),
      ),
    );
  }

  // card with both gutter and app bar
  Widget cardWithGutterAndAppBar() => TextButton(
        onPressed: () => showDialog(
          context: context,
          builder: (builder) => XenPopupCard(
            appBar: appBar,
            gutter: gutter,
            body: NewPostScreen(),
          ),
        ),
        child: const Text("open card with gutter and app bar"),
      );
}
