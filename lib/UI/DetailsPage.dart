import 'package:buytime/gigs.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';


class DetailsPage extends StatelessWidget {
  final cLocation item;

  DetailsPage({ required this.item});



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(item.name),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Text(item.distance),
      ),
    );
  }
}