import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class RoomRatingBar extends StatelessWidget {
  const RoomRatingBar({super.key, required this.onRating});

  final ValueChanged<double> onRating;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: RatingBar.builder(
          unratedColor: Colors.green.withOpacity(0.2),
          initialRating: 0,
          itemCount: 5,
          allowHalfRating: true,
          itemBuilder: (context, _) => Icon(
                Icons.star,
                color: Colors.amber,
              ),
          onRatingUpdate: onRating),
    );
  }
}
