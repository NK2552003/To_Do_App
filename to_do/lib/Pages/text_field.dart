
import 'package:flutter/material.dart';

class TextFieldWidget extends StatefulWidget {
  const TextFieldWidget({
    super.key,
    required this.hintText,
    required this.maxLine,
    required this.txtController,
    required this.fNode,
  });
  final String hintText;
  final int maxLine;
  final TextEditingController txtController;
  final FocusNode fNode;

  @override
  State<TextFieldWidget> createState() => _TextFieldWidgetState();
}

class _TextFieldWidgetState extends State<TextFieldWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding:const EdgeInsets.symmetric(horizontal: 15),
      decoration: BoxDecoration(
          color: Colors.grey.shade200,
          borderRadius: BorderRadius.circular(10)),
      child:TextField(
        textInputAction: TextInputAction.done,
        focusNode: widget.fNode,
        controller: widget.txtController,
        decoration:InputDecoration(
          enabledBorder: InputBorder.none,
          focusedBorder: InputBorder.none,
          hintText: widget.hintText
        ),
        maxLines: widget.maxLine,
      ),
    );
  }
}