import 'package:expense_manager/user/bloc/user_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

class ExpenseCreatePage extends StatelessWidget {
  const ExpenseCreatePage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UserBloc, UserState>(
      builder: (context, state) {
        if (state is UserError) {
          return Center(child: Text(state.errMsg));
        }
        if (state is UserLoading) {
          return Center(child: CircularProgressIndicator(color: Colors.white));
        }
        return Center(child: _ExpenseCreationForm());
      },
    );
  }
}

class _ExpenseCreationForm extends StatefulWidget {
  const _ExpenseCreationForm({super.key});

  @override
  State<StatefulWidget> createState() => _ExpenseCreationFormState();
}

class _ExpenseCreationFormState extends State<_ExpenseCreationForm> {
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _amountController = TextEditingController();
  final TextEditingController _dateController = TextEditingController();

  DateTime? _selectedDate;

  @override
  void dispose() {
    _titleController.dispose();
    _descriptionController.dispose();
    _amountController.dispose();
    _dateController.dispose();
    super.dispose();
  }

  Future<void> _handleSelectDate(BuildContext context) async {
    DateTime? selectedDate = await showDatePicker(
      context: context,
      initialDate: _selectedDate ?? DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );

    if (selectedDate != null) {
      final selectedTime = await showTimePicker(
        context: context,
        initialTime:
            _selectedDate != null
                ? TimeOfDay.fromDateTime(_selectedDate!)
                : TimeOfDay.now(),
      );
      if (selectedTime != null) {
        selectedDate = DateTime(
          selectedDate.year,
          selectedDate.month,
          selectedDate.day,
          selectedTime.hour,
          selectedTime.minute,
        );
      }
    }
    if (selectedDate != _selectedDate) {
      _selectedDate = selectedDate;
      _dateController.text = formatToDisplayDate(_selectedDate!);
    }
  }

  String formatToDisplayDate(DateTime dateTime) {
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    final inputDate = DateTime(dateTime.year, dateTime.month, dateTime.day);

    if (inputDate.isAtSameMomentAs(today)) {
      return DateFormat('h:mma').format(dateTime).toLowerCase();
    } else {
      return DateFormat('dd MMM yyyy h:mm a').format(dateTime);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(10),
      constraints: BoxConstraints(maxWidth: 600),
      child: Form(
        child: Column(
          children: [
            TextFormField(
              controller: _titleController,
              decoration: InputDecoration(
                labelText: "Title",
                border: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.grey),
                ),
              ),
            ),
            SizedBox(height: 20),
            TextFormField(
              controller: _amountController,
              keyboardType: TextInputType.number,
              inputFormatters: [FilteringTextInputFormatter.digitsOnly],
              decoration: InputDecoration(
                hintText: "Enter a amount",
                labelText: "Amount",
                border: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.grey),
                ),
              ),
            ),
            SizedBox(height: 20),
            TextFormField(
              controller: _descriptionController,
              maxLines: 5,
              decoration: InputDecoration(
                labelText: "Description",
                alignLabelWithHint: true,
                border: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.grey),
                ),
              ),
            ),
            SizedBox(height: 20),
            TextFormField(
              controller: _dateController,
              readOnly: true,
              onTap: () => _handleSelectDate(context),
              decoration: InputDecoration(
                labelText: "Date",
                alignLabelWithHint: true,
                border: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.grey),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
