import 'package:flutter/material.dart';

void showAddCategoryModal(BuildContext context) {
  final screenWidth = MediaQuery.of(context).size.width;

  final isDesktopOrTablet = screenWidth > 600;

  if (isDesktopOrTablet) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Add Category'),
          content: const AddCategoryForm(),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                // Add your logic to save the category
                Navigator.of(context).pop();
              },
              child: const Text('Add'),
            ),
          ],
        );
      },
    );
  } else {
    // Show a bottom sheet for mobile
    showModalBottomSheet(
      context: context,
      isScrollControlled: true, // Make it full-screen initially
      shape: RoundedRectangleBorder(
        // Apply rounded corners
        borderRadius: BorderRadius.circular(16.0),
      ),
      builder: (context) {
        bool isExpanded =
            false; // Track expansion state within the bottom sheet
        return StatefulBuilder(
          // Use StatefulBuilder to manage state within the bottom sheet
          builder: (context, setState) {
            return AnimatedContainer(
              // Use AnimatedContainer for smooth transitions
              duration: const Duration(milliseconds: 300),
              curve: Curves.easeInOut,
              height:
                  isExpanded
                      ? MediaQuery.of(context).size.height
                      : MediaQuery.of(context).size.height * 0.6,
              // Adjust initial height as needed
              decoration: const BoxDecoration(
                color: Colors.white, // Ensure the background color is white
                borderRadius: BorderRadius.vertical(top: Radius.circular(16.0)),
              ),
              child: Material(
                //Added Material,
                child: Column(
                  children: [
                    // Added GestureDetector for the handle icon
                    Expanded(
                      child: AddCategoryBottomSheet(
                        isExpanded: isExpanded,
                        onExpandStateChange: () {
                          setState(() {
                            isExpanded = !isExpanded;
                          });
                        },
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }
}

// Form widget for adding a category (used in both dialog and bottom sheet)
class AddCategoryForm extends StatefulWidget {
  const AddCategoryForm({super.key});

  @override
  State<StatefulWidget> createState() => _AddCategoryFormState();
}

class _AddCategoryFormState extends State<AddCategoryForm> {
  final _formKey = GlobalKey<FormState>();
  String _categoryName = '';
  String _categoryDescription = '';

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          TextFormField(
            decoration: const InputDecoration(labelText: 'Category Name'),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter category name';
              }
              return null;
            },
            onSaved: (value) {
              _categoryName = value!;
            },
          ),
          const SizedBox(height: 12),
          TextFormField(
            decoration: const InputDecoration(
              labelText: 'Category Description',
            ),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter category description';
              }
              return null;
            },
            onSaved: (value) {
              _categoryDescription = value!;
            },
          ),
        ],
      ),
    );
  }
}

// Bottom sheet widget for adding a category
class AddCategoryBottomSheet extends StatelessWidget {
  const AddCategoryBottomSheet({
    super.key,
    required this.isExpanded,
    required this.onExpandStateChange,
  });

  final bool isExpanded;
  final VoidCallback onExpandStateChange;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        bottom: MediaQuery.of(context).viewInsets.bottom,
      ),
      child: Container(
        padding: const EdgeInsets.all(16),
        child: SingleChildScrollView(
          // Added SingleChildScrollView
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Row(
                children: [
                  Expanded(
                    child: Center(
                      child: const Text(
                        'Add Category',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: onExpandStateChange,
                    child: Container(
                      alignment: Alignment.center,
                      padding: const EdgeInsets.only(top: 8),
                      child: Icon(
                        // Use a handle icon
                        isExpanded ? Icons.expand_less : Icons.expand_more,
                        size: 30,
                        color: Colors.grey, // Style the handle icon as needed
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              const AddCategoryForm(), // Reuse the form widget
              const SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  TextButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: const Text('Cancel'),
                  ),
                  TextButton(
                    onPressed: () {
                      // Add logic to save
                      Navigator.of(context).pop();
                    },
                    child: const Text('Add'),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// Example usage:
class MyWidget extends StatelessWidget {
  const MyWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('My App')),
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            showAddCategoryModal(context);
          },
          child: const Text('Add Category'),
        ),
      ),
    );
  }
}
