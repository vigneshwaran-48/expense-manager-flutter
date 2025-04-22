import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:expense_manager/expense/bloc/expenses_bloc.dart';
import 'package:expense_manager/expense/expense.dart';
import 'package:expense_manager/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';

class ExpenseCreatePage extends StatelessWidget {
  const ExpenseCreatePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(child: _ExpenseCreationForm());
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

  final _formKey = GlobalKey<FormState>();

  DateTime? _selectedDate;
  bool _loading = false;

  @override
  void dispose() {
    _titleController.dispose();
    _descriptionController.dispose();
    _amountController.dispose();
    _dateController.dispose();
    super.dispose();
  }

  void _handleCreateExpense() {
    if (_loading) {
      return;
    }
    if (!_formKey.currentState!.validate()) {
      return;
    }
    BlocProvider.of<ExpensesBloc>(context).add(
      AddExpense(
        expense: Expense(
          title: _titleController.text,
          description: _descriptionController.text,
          amount: double.tryParse(_amountController.text),
          date: Timestamp.fromDate(_selectedDate!),
        ),
      ),
    );
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
    return BlocConsumer<ExpensesBloc, ExpensesState>(
      listener: (context, state) {
        if (state is ExpenseAdded) {
          ScaffoldMessenger.of(context).showSnackBar(
            buildSnackBar(message: "Added Expense", isError: false),
          );
          context.read<ExpensesBloc>().add(LoadExpenses());
          context.go("/expenses");
        }
      },
      builder: (context, state) {
        if (state is AddingExpense) {
          _loading = true;
        }
        return Container(
          padding: EdgeInsets.fromLTRB(10, 40, 10, 10),
          constraints: BoxConstraints(maxWidth: 600),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                TextFormField(
                  controller: _titleController,
                  maxLength: 50,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Title is required";
                    }
                    return null;
                  },
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
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Amount is required";
                    }
                    if (double.tryParse(value)! <= 0) {
                      return "Amount should greater than 0";
                    }
                    return null;
                  },
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
                SizedBox(height: 20),
                TextFormField(
                  controller: _descriptionController,
                  maxLines: 5,
                  maxLength: 300,
                  decoration: InputDecoration(
                    labelText: "Description",
                    alignLabelWithHint: true,
                    border: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.grey),
                    ),
                  ),
                ),
                SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    ElevatedButton(
                      onPressed: () => context.go("/expenses"),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.transparent,
                        foregroundColor: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(7),
                          side: BorderSide(color: Colors.grey),
                        ),
                      ),
                      child: Text("Cancel"),
                    ),
                    SizedBox(width: 10),
                    ElevatedButton(
                      onPressed: _handleCreateExpense,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.red,
                        foregroundColor: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(7),
                        ),
                      ),
                      child:
                          _loading
                              ? Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text("Creating"),
                                  SizedBox(width: 10),
                                  SizedBox(
                                    width: 20,
                                    height: 20,
                                    child: CircularProgressIndicator(
                                      color: Colors.white,
                                    ),
                                  ),
                                ],
                              )
                              : Text("Create"),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
