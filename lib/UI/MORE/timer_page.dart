import 'package:buytime/UI/MORE/tag_page.dart';
import 'package:flutter/material.dart';

class TimerPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Timer', style: TextStyle(fontSize: 20),),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Specify Job Duration',
                style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 16.0),
              _buildCurvedTextBox(),
              SizedBox(height: 16.0),
              ElevatedButton(
                onPressed: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) => TagsPage()));
                },
                child: Text('Next'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildCurvedTextBox() {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20.0),
        color: Colors.grey[200],
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: TextField(
          decoration: InputDecoration(
            border: InputBorder.none,
            hintText: 'Enter time duration...',
          ),
        ),
      ),
    );
  }
}