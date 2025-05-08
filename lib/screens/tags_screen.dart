import 'package:flutter/material.dart';
import '../models/tag.dart';
import '../main.dart';

class TagsScreen extends StatefulWidget {
  const TagsScreen({Key? key}) : super(key: key);

  @override
  _TagsScreenState createState() => _TagsScreenState();
}

class _TagsScreenState extends State<TagsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('My Tags')),
      body: ListView.builder(
        itemCount: tags.length,
        itemBuilder: (context, index) {
          final tag = tags[index];
          return ListTile(
            title: Text(tag.name),
            trailing: IconButton(
              icon: Icon(Icons.edit),
              onPressed: () => _showEditTagDialog(tag),
            ),
          );
        },
      ),
    );
  }

  void _showEditTagDialog(Tag tag) {
    final controller = TextEditingController(text: tag.name);
    
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Edit Tag'),
          content: TextField(controller: controller),
          actions: [
            TextButton(
              child: Text('Cancel'),
              onPressed: () => Navigator.pop(context),
            ),
            TextButton(
              child: Text('Delete', style: TextStyle(color: Colors.red)),
              onPressed: () {
                Navigator.pop(context);
                _showDeleteConfirmation(tag);
              },
            ),
            TextButton(
              child: Text('Save'),
              onPressed: () {
                if (controller.text.isNotEmpty) {
                  setState(() {
                    tag.name = controller.text;
                  });
                  Navigator.pop(context);
                }
              },
            ),
          ],
        );
      },
    );
  }

  void _showDeleteConfirmation(Tag tag) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Delete Tag?'),
          content: Text('Are you sure you want to delete "${tag.name}"?'),
          actions: [
            TextButton(
              child: Text('Cancel'),
              onPressed: () => Navigator.pop(context),
            ),
            TextButton(
              child: Text('Delete', style: TextStyle(color: Colors.red)),
              onPressed: () {
                setState(() {
                  tags.removeWhere((t) => t.id == tag.id);
                });
                Navigator.pop(context);
              },
            ),
          ],
        );
      },
    );
  }
}