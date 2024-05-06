import 'dart:developer';

import 'package:flutter/material.dart';

class DynamicForm extends StatefulWidget {
  @override
  _DynamicFormState createState() => _DynamicFormState();
}

class _DynamicFormState extends State<DynamicForm> {
  // List to hold text editing controllers
  List<TextEditingController> controllers = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Dynamic Form'),
      ),
      body: Column(
        children: [
          Expanded(
            // Use ListView.builder for dynamic forms
            child: ListView.builder(
              itemCount: controllers.length,
              itemBuilder: (context, index) {
                // Build form fields based on index
                return ListTile(
                  title: TextField(
                    controller: controllers[index],
                    decoration:
                        InputDecoration(labelText: 'Field ${index + 1}'),
                  ),
                );
              },
            ),
          ),
          // Button to add new form fields
          ElevatedButton(
            onPressed: () {
              setState(() {
                // Add new controller when button is pressed
                controllers.add(TextEditingController());
                log(controllers[0].text);
              });
            },
            child: Text('Add Field'),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    // Dispose all controllers to avoid memory leaks
    for (var controller in controllers) {
      controller.dispose();
    }
    super.dispose();
  }
}

