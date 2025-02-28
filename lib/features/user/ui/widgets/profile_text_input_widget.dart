
import 'package:flutter/material.dart';

class ProfileTextInputWidget extends StatefulWidget {
  final String hintText;
  final String labelText;
  final Widget? suffixIcon;
  final String initialTextData;
  final Function(String textTheme) onChanged;
  const ProfileTextInputWidget({
    super.key,
    required this.hintText,
    required this.labelText,
    required this.suffixIcon,
    required this.initialTextData,
    required this.onChanged,
  });

  @override
  State<ProfileTextInputWidget> createState() => _ProfileTextInputWidgetState();
}

class _ProfileTextInputWidgetState extends State<ProfileTextInputWidget> {

  @override
  void initState() {
    // TODO: implement initState
    _controller.text = widget.initialTextData;
    super.initState();
  }

  final FocusNode _focusNode = FocusNode();
  final TextEditingController _controller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return SizedBox(
          height: 70,
          width: constraints.maxWidth,
          child: TextField(
            controller: _controller,
            onTapOutside: (event) {
              _focusNode.unfocus();
            },
            focusNode: _focusNode,            
            onChanged: (value) {
              widget.onChanged(value);
            },
            decoration: InputDecoration(
              contentPadding: const EdgeInsets.only(right: 4, bottom: 6, top: 6),
              suffixIcon: widget.suffixIcon,
              alignLabelWithHint: true,
              floatingLabelBehavior: FloatingLabelBehavior.always,
              labelText: widget.labelText,
              hintText: " ${widget.hintText}",
              // enabledBorder: const UnderlineInputBorder(),
              // focusedBorder: const UnderlineInputBorder(),
              // border: const UnderlineInputBorder(),
              // disabledBorder: const UnderlineInputBorder()
            ),
          ),
        );
      
      },
    );
  }
}
