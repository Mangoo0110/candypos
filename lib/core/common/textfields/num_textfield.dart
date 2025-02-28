import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class NumTextfield extends StatefulWidget {
  final TextEditingController controller;
  final Function (String text) onChanged;
  final Function (String text) validationCheck;
  final VoidCallback onTap;
  final String hintText;
  final String labelText;
  final int? maxLines;
  final bool onlyInteger;
  final RegExp? numRegExp;
  final IconData? prefiexIcon;
  const NumTextfield({
    required this.maxLines,
    required this.onChanged,
    required this.controller,
    required this.hintText,
    required this.labelText,
    required this.validationCheck,
    required this.onlyInteger,
    this.numRegExp,
    this.prefiexIcon,
    super.key, required this.onTap
    });

  @override
  State<NumTextfield> createState() => _NumTextfieldState();
}

class _NumTextfieldState extends State<NumTextfield> {
  final FocusNode _focusNode = FocusNode();

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) => TextFormField(
        onTap: () {
          _focusNode.requestFocus();

          setState(() {
            
          });
        },
        onTapOutside: (event){
          _focusNode.unfocus();
          setState(() {
            
          });
        },
        focusNode: _focusNode,
        maxLines: widget.maxLines,
        controller: widget.controller,
        showCursor: _focusNode.hasFocus,
        style: Theme.of(context).textTheme.bodyMedium,
        decoration: InputDecoration(
          prefixIcon: widget.prefiexIcon != null
          ? Icon(widget.prefiexIcon)
          : null,
          constraints: BoxConstraints(minHeight: constraints.maxHeight),
          hintText: widget.hintText,
          label: Text(widget.labelText),
          labelStyle: Theme.of(context).textTheme.titleMedium,
          hintStyle: const TextStyle(color: Colors.grey),
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
          focusedBorder: OutlineInputBorder(
              borderSide: const BorderSide(
                color: Colors.green,
                width: 2
              ),
              borderRadius: BorderRadius.circular(10)
          ),
        ),
        keyboardType: TextInputType.numberWithOptions(decimal: !widget.onlyInteger),
        inputFormatters: [
          if(widget.numRegExp != null) FilteringTextInputFormatter.allow(widget.numRegExp!),
        ],
        onChanged: (value) {
          widget.onChanged(value);
        },
        validator: (value) {
          return widget.validationCheck(value!);
        },
      ),
    );
  }

}