import 'package:fire_flutter/screens/NavScreens/listofscreens/homeScreen/helperwidgets/search_bar.dart';
import 'package:fire_flutter/utils/helperwidgets/helper_widgets.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

import 'helperwidgets/appbar_with_user.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({super.key});

  List<String> lsit = ['kum', 'sun', 'rev', 'tan'];

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      physics: ClampingScrollPhysics(),
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(0.0),
          child: Container(
            child: Padding(
              padding: const EdgeInsets.all(14.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  HeaderUserDetail(),
                  addVerticalSpacer(15.0),
                  Text(
                    "Let's find",
                    style: Theme.of(context).textTheme.headlineSmall,
                  ),
                  Text(
                    'the best Home for you',
                    style: Theme.of(context).textTheme.headlineMedium,
                  ),
                  addVerticalSpacer(10.0),
                  SearchActionsAndFilter(),
                  addVerticalSpacer(18.0),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Popular Homes',
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 18.0),
                      ),
                      Text(
                        'more..',
                        style: TextStyle(color: Colors.green),
                      )
                    ],
                  ),
                  SingleChildScrollView(
                    dragStartBehavior: DragStartBehavior.down,
                    physics: BouncingScrollPhysics(),
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: lsit
                          .map((e) => InkWell(
                                splashColor: Colors.green,
                                overlayColor: MaterialStateProperty.all(
                                    Colors.transparent),
                                onLongPress: () {
                                  showModalBottomSheet(
                                      context: context,
                                      builder: (context) {
                                        return SizedBox(
                                            height: 200.0, child: Text(e));
                                      });
                                },
                                child: Container(
                                    decoration:
                                        BoxDecoration(color: Colors.green[100]),
                                    width: 150,
                                    height: 200,
                                    margin: EdgeInsets.symmetric(
                                        horizontal: 10.0, vertical: 10.0),
                                    child: Text(e)),
                              ))
                          .toList(),
                    ),
                  ),
                  addVerticalSpacer(18.0),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Popular Homes',
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 18.0),
                      ),
                      Text(
                        'more..',
                        style: TextStyle(color: Colors.green),
                      )
                    ],
                  ),
                  SingleChildScrollView(
                    physics: BouncingScrollPhysics(),
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: lsit
                          .map((e) => Container(
                              decoration:
                                  BoxDecoration(color: Colors.green[100]),
                              width: 150,
                              height: 200,
                              margin: EdgeInsets.symmetric(
                                  horizontal: 10.0, vertical: 10.0),
                              child: Text(e)))
                          .toList(),
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
