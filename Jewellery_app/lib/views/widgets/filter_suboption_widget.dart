import 'package:flutter/material.dart';

class FilterSubOptionsWidget extends StatefulWidget {
  final Map<String, dynamic> subOptions;
  final int index;
  final bool isFilterSubOptionClicked;
  final VoidCallback onTap;
  FilterSubOptionsWidget(
      {super.key,
      required this.subOptions,
      required this.index,
      required this.isFilterSubOptionClicked,
      required this.onTap});

  @override
  State<FilterSubOptionsWidget> createState() => _FilterSubOptionsWidgetState();
}

class _FilterSubOptionsWidgetState extends State<FilterSubOptionsWidget> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.onTap,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            SizedBox(
                width: MediaQuery.of(context).size.width / 2,
                child: Text(
                  widget.subOptions["label"] ?? "filter${widget.index}",
                  maxLines: 2,
                  style: TextStyle(
                      color: widget.isFilterSubOptionClicked
                          ? Theme.of(context).primaryColor
                          : Colors.black,
                      fontSize: 15.0),
                )),
            Text(
              widget.subOptions["count"].toString(),
              style: TextStyle(
                  color: widget.isFilterSubOptionClicked
                      ? Theme.of(context).primaryColor
                      : Colors.black,
                  fontSize: 15.0),
            )
          ],
        ),
      ),
    );
    ;
  }
}
