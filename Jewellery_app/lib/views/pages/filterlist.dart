import 'package:flutter/material.dart';



class MyHomePage extends StatelessWidget {
  final List<String> items = ['Item 1', 'Item 2', 'Item 3'];
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('ListView Example'),
      ),
      body: ListView.builder(
        itemCount: items.length,
        itemBuilder: (context, index) {
          return MyListItem(item: items[index]);
        },
      ),
    );
  }
}

class MyListItem extends StatefulWidget {
  final String item;
  
  const MyListItem({required this.item, Key? key}) : super(key: key);

  @override
  _MyListItemState createState() => _MyListItemState();
}

class _MyListItemState extends State<MyListItem> {
  bool isSelected = false;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(
        widget.item,
        style: TextStyle(
          color: isSelected ? Colors.red : Colors.black, // Change color based on isSelected
        ),
      ),
      onTap: () {
        setState(() {
          isSelected = !isSelected; // Toggle isSelected state
        });
      },
    );
  }
}
