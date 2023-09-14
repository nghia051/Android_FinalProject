import 'package:antap/screens/map/pop_up/widgets/appbar.dart';
import 'package:antap/screens/map/pop_up/widgets/body.dart';
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
  XenCardGutter gutter = const XenCardGutter(
    child: Padding(
      padding: EdgeInsets.all(8.0),
      child: CustomButton(text: "close"),
    ),
  );

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

  // card with body only
  // no appbar and gutter
  // Widget cardWithBodyOnly() => TextButton(
  //       onPressed: () => showDialog(
  //         context: context,
  //         builder: (builder) => XenPopupCard(
  //           body: ListView(
  //             children: const [
  //               Text("body"),
  //             ],
  //           ),
  //         ),
  //       ),
  //       child: const Text("open card with body only"),
  //     );

  // // card with appbar only
  // // no gutter
  // Widget cardWithAppBarOnly() => TextButton(
  //       onPressed: () => showDialog(
  //         context: context,
  //         builder: (builder) => XenPopupCard(
  //           appBar: appBar,
  //           body: ListView(
  //             children: const [
  //               Text("body"),
  //             ],
  //           ),
  //         ),
  //       ),
  //       child: const Text("open card with appbar only"),
  //     );

  // // card with gutter only
  // // no appbar
  // Widget cardWithGutterOnly() => TextButton(
  //       onPressed: () => showDialog(
  //         context: context,
  //         builder: (builder) => XenPopupCard(
  //           gutter: gutter,
  //           body: ListView(
  //             children: const [
  //               Text("body"),
  //             ],
  //           ),
  //         ),
  //       ),
  //       child: const Text("open card with  gutter only"),
  // );
}

// custom button
// ignore
class CustomButton extends StatelessWidget {
  const CustomButton({Key? key, required this.text, this.color})
      : super(key: key);

  final String text;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => Navigator.pop(context),
      child: Material(
        borderRadius: BorderRadius.circular(5),
        color: const Color(0xff6200ee),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: FittedBox(
            fit: BoxFit.scaleDown,
            child: Center(
              child: Text(text,
                  style: const TextStyle(
                      fontSize: 17,
                      color: Colors.white,
                      fontWeight: FontWeight.w500)),
            ),
          ),
        ),
      ),
    );
  }
}
