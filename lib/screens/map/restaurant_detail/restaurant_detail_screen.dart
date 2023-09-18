import 'dart:ui';
import 'package:antap/screens/create_post/create_post_popup.dart';
import 'package:antap/screens/create_post/create_post_tabbar.dart';
import 'package:antap/screens/create_post/widgets/appbar.dart';
import 'package:antap/screens/create_post/widgets/body_video.dart';
import 'package:antap/screens/map/pop_up/widgets/gutter.dart';
import 'package:antap/src/card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:antap/screens/map/restaurant_detail/values/data.dart';
import 'package:antap/screens/map/restaurant_detail/values/values.dart';
import 'package:antap/screens/map/restaurant_detail/widgets/card_tags.dart';
import 'package:antap/screens/map/restaurant_detail/widgets/dark_overlay.dart';
import 'package:antap/screens/map/restaurant_detail/widgets/heading_row.dart';
import 'package:antap/screens/map/restaurant_detail/widgets/potbelly_button.dart';
import 'package:antap/screens/map/restaurant_detail/widgets/ratings_widget.dart';
import 'package:antap/screens/map/restaurant_detail/widgets/spaces.dart';

import '../../../data/data.dart';
import '../../../src/card.dart';
import '../../create_post/widgets/appbar.dart';
import '../../posts/components/post_info_widget.dart';
import '../../posts/components/post_react_widget.dart';
import '../pop_up/widgets/gutter.dart';

class ScreenArguments {
  String resID = "";
  String imagePath = "";
  String restaurantName = "TEST";
  String restaurantAddress = "HCMUS";
  String category = "ANTAP";
  //static String id = 'detail_screen';
  String distance = "5KM";
  String rating = "5";

  ScreenArguments(
      {required this.resID,
      required this.imagePath,
      required this.restaurantName,
      required this.restaurantAddress,
      required this.category,
      required this.distance,
      required this.rating});
}

class RestaurantDetailsScreen extends StatelessWidget {
  static String id = 'detail_screen';

  RestaurantDetailsScreen({super.key});

  TextStyle addressTextStyle = Styles.customNormalTextStyle(
    color: AppColors.accentText,
    fontSize: Sizes.TEXT_SIZE_14,
  );

  TextStyle openingTimeTextStyle = Styles.customNormalTextStyle(
    color: Colors.red,
    fontSize: Sizes.TEXT_SIZE_14,
  );

  TextStyle subHeadingTextStyle = Styles.customTitleTextStyle(
    color: AppColors.headingText,
    fontWeight: FontWeight.w600,
    fontSize: Sizes.TEXT_SIZE_18,
  );

  BoxDecoration fullDecorations = Decorations.customHalfCurvedButtonDecoration(
    color: Colors.black.withOpacity(0.1),
    topleftRadius: 24,
    bottomleftRadius: 24,
    topRightRadius: 24,
    bottomRightRadius: 24,
  );
  BoxDecoration leftSideDecorations =
      Decorations.customHalfCurvedButtonDecoration(
    color: Colors.black.withOpacity(0.1),
    topleftRadius: 24,
    bottomleftRadius: 24,
  );

  BoxDecoration rightSideDecorations =
      Decorations.customHalfCurvedButtonDecoration(
    color: Colors.black.withOpacity(0.1),
    topRightRadius: 24,
    bottomRightRadius: 24,
  );

  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context)!.settings.arguments as ScreenArguments;
    var heightOfStack = MediaQuery.of(context).size.height / 2.8;
    var aPieceOfTheHeightOfStack = heightOfStack - heightOfStack / 3.5;
    return Scaffold(
      body: SafeArea(
        child: Container(
          child: Column(
            children: <Widget>[
              Expanded(
                child: ListView(
                  shrinkWrap: true,
                  children: <Widget>[
                    Stack(
                      children: <Widget>[
                        Positioned(
                          child: Image.network(
                            args.imagePath,
                            width: MediaQuery.of(context).size.width,
                            height: heightOfStack,
                            fit: BoxFit.cover,
                          ),
                        ),
                        DarkOverLay(
                            gradient: Gradients.restaurantDetailsGradient),
                        Positioned(
                          child: Container(
                            padding: EdgeInsets.only(
                              right: Sizes.MARGIN_16,
                              top: Sizes.MARGIN_16,
                            ),
                            child: Row(
                              children: <Widget>[
                                InkWell(
                                  onTap: () => Navigator.pop(context),
                                  child: Padding(
                                    padding: const EdgeInsets.only(
                                      left: Sizes.MARGIN_16,
                                      right: Sizes.MARGIN_16,
                                    ),
                                    child: Image.asset(
                                        "assets/images/arrow_back.png"),
                                  ),
                                ),
                                Spacer(flex: 1),
                                InkWell(
                                  child: Icon(
                                    FeatherIcons.share2,
                                    color: AppColors.white,
                                  ),
                                ),
                                SpaceW20(),
                                InkWell(
                                  child: Image.asset(
                                      "assets/images/bookmarks_icon.png",
                                      color: Colors.white),
                                ),
                              ],
                            ),
                          ),
                        ),
                        Positioned(
                          top: aPieceOfTheHeightOfStack,
                          left: 24,
                          right: 24 - 0.5,
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(24.0),
                            child: BackdropFilter(
                              filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
                              child: Container(
                                padding: EdgeInsets.symmetric(vertical: 4.0),
                                decoration: fullDecorations,
                                child: Row(
                                  children: <Widget>[
                                    Container(
                                      padding: EdgeInsets.symmetric(
                                          horizontal: 8.0, vertical: 8.0),
                                      width:
                                          (MediaQuery.of(context).size.width /
                                                  2) -
                                              24,
//                                      decoration: leftSideDecorations,
                                      child: Row(
                                        children: <Widget>[
                                          SizedBox(width: 4.0),
                                          Image.asset(
                                              "assets/images/call_icon.png"),
                                          SizedBox(width: 8.0),
                                          Text(
                                            '+233 549546967',
                                            style: Styles.normalTextStyle,
                                          )
                                        ],
                                      ),
                                    ),
                                    IntrinsicHeight(
                                      child: VerticalDivider(
                                        width: 0.5,
                                        thickness: 3.0,
                                        color: Colors.red,
                                      ),
                                    ),
                                    Container(
                                      padding: EdgeInsets.symmetric(
                                          horizontal: 8.0, vertical: 8.0),
//                                      width:
//                                      (MediaQuery
//                                          .of(context)
//                                          .size
//                                          .width /
//                                          2) -
//                                          24,
//                                      decoration: rightSideDecorations,
                                      child: Row(
                                        children: <Widget>[
                                          SizedBox(width: 4.0),
                                          Image.asset(
                                              "assets/images/direction_icon.png"),
                                          SizedBox(width: 8.0),
                                          Text(
                                            'Direction',
                                            style: Styles.normalTextStyle,
                                          )
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                    Container(
                      margin: EdgeInsets.symmetric(
                          horizontal: 16.0, vertical: 16.0),
                      child: Column(
                        children: <Widget>[
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Row(
                                children: <Widget>[
                                  Text(
                                    args.restaurantName,
                                    textAlign: TextAlign.left,
                                    style: Styles.customTitleTextStyle(
                                      color: AppColors.headingText,
                                      fontWeight: FontWeight.w600,
                                      fontSize: Sizes.TEXT_SIZE_20,
                                    ),
                                  ),
                                  SizedBox(width: 4.0),
                                  CardTags(
                                    title: args.category,
                                    decoration: BoxDecoration(
                                      gradient: Gradients.secondaryGradient,
                                      boxShadow: [
                                        Shadows.secondaryShadow,
                                      ],
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(8.0)),
                                    ),
                                  ),
                                  SizedBox(width: 4.0),
                                  CardTags(
                                    title: args.distance,
                                    decoration: BoxDecoration(
                                      color: Color.fromARGB(255, 132, 141, 255),
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(8.0)),
                                    ),
                                  ),
                                  Spacer(flex: 1),
                                  Ratings(args.rating)
                                ],
                              ),
                              SizedBox(height: 16.0),
                              Text(
                                args.restaurantAddress,
                                style: addressTextStyle,
                              ),
                              SizedBox(height: 8.0),
                              RichText(
                                text: TextSpan(
                                  style: openingTimeTextStyle,
                                  children: [
                                    TextSpan(text: "Open Now "),
                                    TextSpan(
                                        text: "daily time ",
                                        style: addressTextStyle),
                                    TextSpan(text: "9:30 am to 11:30 am "),
                                  ],
                                ),
                              )
                            ],
                          ),
                          SpaceH24(),
                          HeadingRow(
                              title: StringConst.MENU_AND_PHOTOS,
                              number: StringConst.SEE_ALL_32,
                              onTapOfNumber: () => {}
                              //AutoRouter.of(context).push(MenuPhotosScreen()),
                              ),
                          SizedBox(height: 16.0),
                          Container(
                            height: 120,
                            width: MediaQuery.of(context).size.width,
                            child: ListView.builder(
                              scrollDirection: Axis.horizontal,
                              itemCount: 4,
                              itemBuilder: (context, index) {
                                return Container(
                                  margin: EdgeInsets.only(right: 12.0),
                                  decoration: BoxDecoration(
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(8))),
                                  child: Image.asset(
                                    menuPhotosImagePaths[index],
                                    fit: BoxFit.fill,
                                    width: 160,
                                  ),
                                );
                              },
                            ),
                          ),
                          SpaceH24(),
                          HeadingRow(
                            title: StringConst.REVIEWS_AND_RATINGS,
                            number: StringConst.SEE_ALL_32,
                            // onTapOfNumber: () => AutoRouter.of(context)
                            //    .push(ReviewRatingScreen()),
                          ),
                          SizedBox(height: 16.0),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: createUserListTiles(),
                          )
                        ],
                      ),
                    )
                  ],
                ),
              ),
              PotbellyButton(
                'Rate Your Experience ',
                onTap: () {
                  showDialog(
                    context: context,
                    builder: (builder) => XenPopupCard(
                      gutter: gutter,
                      body: TabBarApp(resID: args.resID),
                    ),
                  );
                },
                buttonHeight: 65,
                buttonWidth: MediaQuery.of(context).size.width,
                decoration: Decorations.customHalfCurvedButtonDecoration(
                  topleftRadius: Sizes.RADIUS_24,
                  topRightRadius: Sizes.RADIUS_24,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  List<Widget> createUserListTiles({@required numberOfUsers}) {
    return List.generate(
      listPost.length,
      (index) {
        return Container(
          color: Colors.black87,
          width: double.infinity,
          margin: const EdgeInsets.fromLTRB(0, 10, 0, 10),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(10),
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      PostInfoWidget(post: listPost[index]),
                      const SizedBox(
                        height: 10,
                      ),
                      Text(
                        listPost[index].getReview().title,
                        style: const TextStyle(
                            fontSize: 17,
                            fontWeight: FontWeight.w700,
                            color: Colors.white),
                      ),
                      Text(
                        listPost[index].getReview().content,
                        style:
                            const TextStyle(fontSize: 14, color: Colors.white),
                      )
                    ]),
              ),
              listPost[index].getImageVideo(),
              Padding(
                  padding: const EdgeInsets.all(10),
                  child: PostReactWidget(post: listPost[index]))
            ],
          ),
        );
      },
    );
  }
}
