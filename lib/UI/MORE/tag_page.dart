import 'package:flutter/material.dart';

class TagsPage extends StatefulWidget {
  @override
  _TagsPageState createState() => _TagsPageState();
}

class _TagsPageState extends State<TagsPage> {
  final TextEditingController tagsController = TextEditingController();
  List<String> enteredTags = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Tags Page', style: TextStyle(fontSize: 20),),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            _buildCurvedTextBox(),
            SizedBox(height: 20),
            _buildEnteredTags(),
            SizedBox(height: 20),
            _buildCheckoutButton(context),
          ],
        ),
      ),
    );
  }

  Widget _buildCurvedTextBox() {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12.0),
        border: Border.all(),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: TextField(
          controller: tagsController,
          onSubmitted: (value) {
            // When Enter key is pressed, add the tag to the list
            _addTag(value);
          },
          decoration: InputDecoration(
            labelText: 'Tags',
            border: InputBorder.none,
          ),
        ),
      ),
    );
  }

  Widget _buildEnteredTags() {
    return Wrap(
      spacing: 8.0,
      children: enteredTags
          .map((tag) => Chip(
        label: Text(tag),
      ))
          .toList(),
    );
  }

  Widget _buildCheckoutButton(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        // Handle checkout logic here
      },
      style: ElevatedButton.styleFrom(
        primary: Colors.green, // Background color
        onPrimary: Colors.white, // Text Color
        padding: EdgeInsets.symmetric(horizontal: 30, vertical: 15),
        textStyle: TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.bold,
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30),
        ),
      ),
      child: Text('Checkout'),
    );
  }

  void _addTag(String tag) {
    setState(() {
      enteredTags.add(tag);
      tagsController.clear(); // Clear the TextField after adding the tag
    });
  }

  @override
  void dispose() {
    tagsController.dispose();
    super.dispose();
    }
}