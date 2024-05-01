import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:intl/intl.dart';

import 'package:keihi/models/expense.dart';

class NewExpense extends StatefulWidget{
  const NewExpense({super.key, required this.onAddExpense});

  final void Function(Expense expense) onAddExpense;

  @override
  State<NewExpense> createState() {
    return _NewExpenseState();
  }
}

class _NewExpenseState extends State<NewExpense>{
  final _titleController = TextEditingController();
  final _amountController = TextEditingController();
  DateTime? _selectedDate;
  Category _selectedCategory = Category.leisure;

  void _presentDatePicker() async {
    final now = DateTime.now();
    final firstDate = DateTime(now.year - 1, now.month, now.day);
    final pickedDate = await showDatePicker(
      context: context,
      initialDate: _selectedDate ?? now,
      firstDate: firstDate,
      lastDate: now,
    )/*.then((value) {
      ここで色々書くとfuture型のやつ, 上で言うところのshowDatePicker()の返り値が確定したら処理してくれる
      今回はasyncを使うのでこっちの表記は省略
    })*/;
    // print('Date: ${formatter.format(pickedDate)}');// asyncとawaitの場合, awaitの分が評価された後に, 次の行に進む
    setState(() {
      _selectedDate = pickedDate;
    });
  }

  void _submitExpenseData(){
    final enteredAmount = double.tryParse(_amountController.text) ?? -1;// パースできないとnullが返る
    if(_titleController.text.trim().isEmpty || enteredAmount <= 0 || _selectedDate == null){
      // show error message
      showDialog(
        context: context, builder: (ctx) => AlertDialog(
          title: const Text('Invalid Input!'),
          content: const Text('Please make sure a valid title, amount, date, and catagory was entered.'),
          actions: [
            TextButton(onPressed: (){
              Navigator.pop(ctx);
            },
              child: const Text('OK'),
            ),
          ],
        ),
      );
      return;
    }
    // 値が正しかった時の処理
    widget.onAddExpense(
      Expense(
        title: _titleController.text,
        amount: enteredAmount,
        date: _selectedDate!,
        category: _selectedCategory,)
    );
    Navigator.pop(context);
  }

  @override
  void dispose() {
    _titleController.dispose();
    _amountController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 48, 16, 16),
      child: Column(
        children:  [
          TextField(
            maxLength: 64,
            controller: _titleController,
            decoration: const InputDecoration(
              label: Text('Title'),
            ),
          ),
          const SizedBox(height: 8,),
          Row(
            children: [
              Expanded(
                child: TextField(
                  maxLength: 16,
                  controller: _amountController,
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(
                    prefixText: '\$ ',
                    label: Text('Amount'),
                  ),
                ),
              ),
              const SizedBox(width: 16,),
              Expanded(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text(_selectedDate == null ? 'No date selected': formatter.format(_selectedDate!),),
                    IconButton(
                      onPressed: _presentDatePicker,
                      icon: const Icon(Icons.calendar_month),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 16,),
          Row(
            children: [
              DropdownButton(
                value: _selectedCategory,
                items: Category.values.map(
                  (category) => DropdownMenuItem(
                    value: category,
                    child: Text(category.name.toUpperCase()),
                  ),
                ).toList(),
                onChanged: (value){
                  setState(() {
                    /*if (value == null){
                      return;
                    }*/
                    _selectedCategory = value ?? _selectedCategory;
                  });
                },
              ),
              const Spacer(),
              TextButton(
                onPressed: (){
                  Navigator.pop(context);
                },
                child: const Text('Cancel'),
              ),
              ElevatedButton(
                onPressed: (){
                  _submitExpenseData();
                },
                child: const Text('Save Expense.'),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
