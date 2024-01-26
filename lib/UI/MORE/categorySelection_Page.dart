

import 'package:flutter/material.dart';
import 'package:buytime/main.dart';


import 'package:flutter/material.dart';
 // Import the job category selector



class  GigCategoryPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('Select Gig Categories'),
        ),
        body: Padding(
          padding: EdgeInsets.all(15.0),
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
    JobCategory(name: 'Cleaning Homes', imagePath: 'https://images.unsplash.com/photo-1605712776874-fc7dea449fe8?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w0NTYyMDF8MHwxfHNlYXJjaHwzfHxoYW5kJTIwd2FzaGluZyUyMGxhdW5kcnl8ZW58MHx8fHwxNzA2MjE0ODE2fDA&ixlib=rb-4.0.3&q=80&w=1080'),
    JobCategory(name: 'Washing Laundry', imagePath: 'https://images.unsplash.com/photo-1605712776874-fc7dea449fe8?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w0NTYyMDF8MHwxfHNlYXJjaHwzfHxoYW5kJTIwd2FzaGluZyUyMGxhdW5kcnl8ZW58MHx8fHwxNzA2MjE0ODE2fDA&ixlib=rb-4.0.3&q=80&w=1080'),
    JobCategory(name: 'Transportation', imagePath: 'https://images.unsplash.com/photo-1593950315186-76a92975b60c?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w0NTYyMDF8MHwxfHNlYXJjaHwxfHx1YmVyJTIwfGVufDB8fHx8MTcwNjIxNDg1NHww&ixlib=rb-4.0.3&q=80&w=1080'),
    JobCategory(name: 'Construction', imagePath: 'https://images.unsplash.com/photo-1517048915767-3daf31cb5be4?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w0NTYyMDF8MHwxfHNlYXJjaHwxfHxtYW51YWwlMjBsYWJvcnxlbnwwfHx8fDE3MDYyMTQ4NzB8MA&ixlib=rb-4.0.3&q=80&w=1080'),
    JobCategory(name: 'Gardening', imagePath: 'https://images.unsplash.com/photo-1617576683096-00fc8eecb3af?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w0NTYyMDF8MHwxfHNlYXJjaHwxM3x8Z2FyZGVuaW5nfGVufDB8fHx8MTcwNjIxNDkxMXww&ixlib=rb-4.0.3&q=80&w=1080'),
    JobCategory(name: 'Home Deliveries', imagePath: 'https://images.unsplash.com/photo-1612630741022-b29ec17d013d?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w0NTYyMDF8MHwxfHNlYXJjaHw3fHxkZWxpdmVyaWVzfGVufDB8fHx8MTcwNjIxNDkzMHww&ixlib=rb-4.0.3&q=80&w=1080'),
    JobCategory(name: 'Tour Guide', imagePath: 'https://images.unsplash.com/photo-1482332486572-10fff1bedfbe?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w0NTYyMDF8MHwxfHNlYXJjaHw0fHx0b3VyJTIwfGVufDB8fHx8MTcwNjIxNDk4NHww&ixlib=rb-4.0.3'),
    // Add more categories
  ];

  int _selectedCount = 0;

  void _toggleCategorySelection(JobCategory category) {
    if (!category.isSelected && _selectedCount < 3) {
      setState(() {
        category.isSelected = true;
        _selectedCount++;
      });
    } else if (category.isSelected) {
      setState(() {
        category.isSelected = false;
        _selectedCount--;
      });
    }
  }

  void _confirmSelection() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => MyApp()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: ListView.builder(
            itemCount: categories.length,
            itemBuilder: (context, index) {
              JobCategory category = categories[index];
              return Card(
                color: category.isSelected ? Colors.blue[100] : null, // Highlight if selected
                child: ListTile(
                  leading: ClipRRect(
                  borderRadius: BorderRadius.circular(8.0), // Rounded corners
                     child: Image.network(
                       category.imagePath,
                       width: 50,
                       height: 50,
                          fit: BoxFit.cover,
                         ),),
                  title: Text(category.name),
                  onTap: () => _toggleCategorySelection(category),
                ),
              );
            },
          ),
        ),
        ElevatedButton(
          onPressed: _selectedCount > 0 ? _confirmSelection : null, // Enable if at least one category is selected
          child: Text('Confirm Selection'),

        ),
      ],
    );
  }
}


/*

class JobCategorySelector extends StatefulWidget {
  @override
  _JobCategorySelectorState createState() => _JobCategorySelectorState();
}

class _JobCategorySelectorState extends State<JobCategorySelector> {

  List<JobCategory> categories = [
    JobCategory(name: 'Software Development', imagePath: 'assets/menu_select.png'),
    JobCategory(name: 'Graphic Design', imagePath: 'assets/menu_select.png'),
    JobCategory(name: 'Graphic Design Check', imagePath: 'assets/menu_select.png'),
    JobCategory(name: 'cleaning', imagePath: 'assets/menu_select.png'),
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
*/
class JobCategory {
  String name;
  String imagePath;
  bool isSelected;

  JobCategory({required this.name, required this.imagePath, this.isSelected = false});
}
