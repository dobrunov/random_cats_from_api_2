import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

import '../constants/constants.dart';

class CatFactsTile extends StatelessWidget {
  CatFactsTile({
    Key? key,
    required this.catFactText,
    required this.timeStamp,
    required this.deleteFunction,
  }) : super(key: key);

  final String catFactText;
  final String timeStamp;
  Function(BuildContext)? deleteFunction;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: paddingsLeftRightTop25,
      child: Slidable(
        endActionPane: ActionPane(
          motion: const StretchMotion(),
          children: [
            SlidableAction(
              onPressed: deleteFunction,
              icon: Icons.delete,
              backgroundColor: deleteFactColor,
              borderRadius: BorderRadius.circular(12),
            )
          ],
        ),
        child: Container(
          padding: paddingsAll24,
          decoration: BoxDecoration(
            color: catFactsTileColor,
            borderRadius: BorderRadius.circular(20),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                catFactText,
                style: catFactTextStyle,
                maxLines: 5,
                overflow: TextOverflow.ellipsis,
              ),
              h10,
              Text(
                timeStamp,
                style: timeStampTextStyle,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
