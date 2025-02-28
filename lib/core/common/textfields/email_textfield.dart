
import 'package:flutter/material.dart';


class EmailTextfield extends StatefulWidget {
  final TextEditingController controller;
  final Function (String text) onChanged;
  final String? Function (String text) validationCheck;
  final String hintText;
  final String labelText;
  final int? maxLines;
  const EmailTextfield({
    required this.maxLines,
    required this.onChanged,
    required this.controller,
    required this.hintText,
    required this.labelText,
    required this.validationCheck,
    super.key
    });

  @override
  State<EmailTextfield> createState() => _EmailTextfieldState();
}

class _EmailTextfieldState extends State<EmailTextfield> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState> ();

  final FocusNode _focusNode = FocusNode();

  @override
  Widget build(BuildContext context) {
    
    return LayoutBuilder(
      builder: (context, constraints) => Form(
        key: _formKey,
        child: TextFormField(
          onTap: () {
            _focusNode.requestFocus();
          },
          onTapOutside: (event){
            _focusNode.unfocus();
          },
          focusNode: _focusNode,
          maxLines: widget.maxLines,
          controller: widget.controller,
          style: Theme.of(context).textTheme.bodyMedium,
          decoration: InputDecoration(
            constraints: BoxConstraints(minHeight: constraints.maxHeight),
            hintText: widget.hintText,
            labelText: widget.labelText,
            //labelStyle: Theme.of(context).textTheme.labelMedium,
            hintStyle: const TextStyle(color: Colors.grey, fontWeight: FontWeight.w600),
            border:  OutlineInputBorder(
                borderSide: const BorderSide(
                  color: Colors.grey,
                ),
                borderRadius: BorderRadius.circular(10)
            ),
            enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(
                  color: Colors.grey.shade400,
                ),
                borderRadius: BorderRadius.circular(10)
            ),
            focusedBorder:  OutlineInputBorder(
                borderSide: const BorderSide(
                  color: Colors.green,
                  width: 2
                ),
                borderRadius: BorderRadius.circular(10)
            ),
          ),
          onChanged: (value) {
            widget.onChanged(value);
            _formKey.currentState!.validate();
          },
          validator: (value) {
            return widget.validationCheck(value!);
          },
        ),
      ),
    );
  }
}