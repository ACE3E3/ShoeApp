import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  final String text;
  final Function onPress;
  final bool outlineButton;
  final bool isLoading;
  CustomButton({this.text, this.onPress, this.outlineButton, this.isLoading});

  @override
  Widget build(BuildContext context) {
    bool _outlineButton = outlineButton ?? false;
    bool _isLoading = isLoading ?? false;

    return GestureDetector(
    onTap: onPress,
    child: Container(
      height: 65.0,
      decoration: BoxDecoration(
        color: _outlineButton ? Colors.transparent: Colors.black,
        border: Border.all(
          color: Colors.black,
          width: 2.0,
        ),
        borderRadius: BorderRadius.circular(12.0,),
      ),
      padding: EdgeInsets.symmetric(
        horizontal: 24.0,
        vertical: 12.0,
      ),
      margin: EdgeInsets.symmetric(
        horizontal: 24.0,
        vertical: 8.0,
      ),
      child: Stack(
      children: [
        Visibility(
          visible: _isLoading ? false : true,
        child: Center(
        child: Text(
          text ?? "Text",
          style: TextStyle(
          fontSize: 16.0,
        color: _outlineButton ? Colors.black : Colors.white,
        fontWeight: FontWeight.w600,
        ),
        ),
        ),
        ),
        Visibility(
          visible: _isLoading,
        child: Center(
        child: SizedBox(
          height: 30.0,
          width: 30.0,
          child: CircularProgressIndicator(),
        ),
        ),
        ),
      ],
      ),
    ),
    );
  }
}
