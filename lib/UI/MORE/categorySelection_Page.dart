

import 'package:flutter/material.dart';


import 'package:flutter/material.dart';
 // Import the job category selector

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('Select Gig Categories'),
        ),
        body: Padding(
          padding: EdgeInsets.all(8.0),
          child: JobCategorySelector(),
        ),
      ),
    );
  }
}


class JobCategorySelector extends StatefulWidget {
  @override
  _JobCategorySelectorState createState() => _JobCategorySelectorState();
}

class _JobCategorySelectorState extends State<JobCategorySelector> {
  List<JobCategory> categories = [
    JobCategory(name: 'Software Development', imagePath: 'assets/menu_select.png'),
    JobCategory(name: 'Graphic Design', imagePath: 'assets/menu_select.png'),

    // Add more categories
  ];

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: categories.length,
      itemBuilder: (context, index) {
        JobCategory category = categories[index];
        return Card(
          child: ListTile(
            leading: Image.asset(category.imagePath, width: 50, height: 50),
            title: Text(category.name),
            trailing: category.isSelected
                ? Icon(Icons.check_circle, color: Colors.green)
                : Icon(Icons.check_circle_outline),
            onTap: () {
              setState(() {
                category.isSelected = !category.isSelected;
              });
            },
          ),
        );
      },
    );
  }
}

class JobCategory {
  String name;
  String imagePath;
  bool isSelected;

  JobCategory({required this.name, required this.imagePath, this.isSelected = false});
}
