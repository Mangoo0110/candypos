
import 'package:flutter/material.dart';

class PasswordTextfield extends StatefulWidget {
  final TextEditingController controller;
  final Function (String text) onChanged;
  final String? Function (String text) validationCheck;
  final String hintText;
  final String labelText;
  final int maxLines;
  const PasswordTextfield({
    required this.maxLines,
    required this.onChanged,
    required this.controller,
    required this.hintText,
    required this.labelText,
    required this.validationCheck,
    super.key
    });

  @override
  State<PasswordTextfield> createState() => _PasswordTextfieldState();
}

class _PasswordTextfieldState extends State<PasswordTextfield> {
  bool obscureState = true;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState> ();
  final FocusNode _focusNode = FocusNode();

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: TextFormField(
        onTapOutside: (event){
            _focusNode.unfocus();
        },
        focusNode: _focusNode,
        maxLines: widget.maxLines,
        controller: widget.controller,
        obscureText: obscureState,
        autofillHints: const [AutofillHints.password],
        style: Theme.of(context).textTheme.bodyMedium,
        decoration: InputDecoration(
          suffixIcon: InkWell(
            onTap: () {
              setState(() {
                obscureState = !obscureState;
              });
            },
            child: obscureState ?
              const Padding(
                padding: EdgeInsets.all(8.0),
                child: Icon(Icons.visibility),
              )
              :
              const Padding(
                padding: EdgeInsets.all(8.0),
                child: Icon(Icons.visibility_off),
              )
          ),
          //alignLabelWithHint: true,
          hintText: widget.hintText,
          label: Text(widget.labelText),
            labelStyle: Theme.of(context).textTheme.labelMedium,
            hintStyle: const TextStyle(color: Colors.grey, fontWeight: FontWeight.w600),
            border: OutlineInputBorder(
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
          _formKey.currentState!.validate();
          widget.onChanged(value);
        },
        validator: (value) {
          if(value ==null || value.isEmpty) {
            return "Example ${widget.hintText.toLowerCase()}.";
          }
          return widget.validationCheck(value);
        },
      ),
    );
  }
}