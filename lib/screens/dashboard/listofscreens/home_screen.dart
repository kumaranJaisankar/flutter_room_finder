import 'package:fire_flutter/utils/helper_widgets.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(0.0),
          child: Container(
            child: Column(
              children: [
                Stack(children: [
                  ColorFiltered(
                    colorFilter: ColorFilter.mode(
                        Colors.black.withOpacity(0.7), BlendMode.dstATop),
                    child: Image.network(
                        fit: BoxFit.cover,
                        width: double.infinity,
                        color: Color.fromRGBO(255, 255, 255, 0.5),
                        colorBlendMode: BlendMode.modulate,
                        'https://firebasestorage.googleapis.com/v0/b/my-portfolio-fe1ff.appspot.com/o/download%20(5).jpeg?alt=media&token=b373d68c-7d38-4a41-b580-5203cd661aee'),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          CircleAvatar(
                            radius: 30.0,
                            child: Text('K'),
                          ),
                          addHorizontalSpacer(10.0),
                          Text.rich(TextSpan(children: [
                            TextSpan(
                                text: 'Hello! ',
                                style: Theme.of(context).textTheme.subtitle1),
                            TextSpan(
                                text: 'Kumaran 👋',
                                style: Theme.of(context).textTheme.headline5)
                          ])),
                        ],
                      ),
                      IconButton(
                          onPressed: () {},
                          icon: Badge(
                              child: Icon(Icons.notifications_active_rounded)))
                    ],
                  ),
                ]),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
