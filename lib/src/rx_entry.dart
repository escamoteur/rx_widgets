import 'package:flutter/material.dart';
import 'package:rx_command/rx_command.dart';

///A `TextField` based widget that reacts to `RxCommand<String,String>` where it keeps the text to input and the validation result.
class RxEntry extends StatelessWidget {
  RxEntry(
      {this.hintText = "",
      this.filledColor = Colors.transparent,
      this.fieldName,
      @required this.onChanged,
      this.obscureText = false,
      this.icon,
      this.focusedBorderColor = Colors.transparent,
      this.focusedBorderWidth = 0,
      this.unfocusedBorderColor = Colors.transparent,
      this.unfocusedBorderWidth = 0,
      this.borderRadius = 0});
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: onChanged,
      initialData: "",
      builder: (context, snapshot) {
        if (snapshot.hasData) if (snapshot.data.isEmpty)
          return TextField(
            obscureText: obscureText,
            onChanged: onChanged,
            decoration: InputDecoration(
              hintText: hintText,
              fillColor: filledColor,
              filled: true,
              labelText: fieldName,
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.all(
                  Radius.circular(borderRadius),
                ),
                borderSide: (this.focusedBorderColor != Colors.transparent &&
                        this.focusedBorderWidth > 0)
                    ? BorderSide(
                        color: this.focusedBorderColor,
                        width: this.focusedBorderWidth,
                      )
                    : BorderSide.none,
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.all(
                  Radius.circular(borderRadius),
                ),
                borderSide: (this.unfocusedBorderColor != Colors.transparent &&
                        this.unfocusedBorderWidth > 0)
                    ? BorderSide(
                        color: this.unfocusedBorderColor,
                        width: this.unfocusedBorderWidth,
                      )
                    : BorderSide.none,
              ),
              prefixIcon: icon != null ? Icon(icon) : null,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.all(
                  Radius.circular(borderRadius),
                ),
              ),
            ),
          );
        else
          return TextField(
            obscureText: obscureText,
            onChanged: onChanged,
            decoration: InputDecoration(
              hintText: hintText,
              errorText: snapshot.data,
              fillColor: filledColor,
              filled: true,
              labelText: fieldName,
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.all(
                  Radius.circular(borderRadius),
                ),
                borderSide: (this.focusedBorderColor != Colors.transparent &&
                        this.focusedBorderWidth > 0)
                    ? BorderSide(
                        color: this.focusedBorderColor,
                        width: this.focusedBorderWidth,
                      )
                    : BorderSide.none,
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.all(
                  Radius.circular(borderRadius),
                ),
                borderSide: (this.unfocusedBorderColor != Colors.transparent &&
                        this.unfocusedBorderWidth > 0)
                    ? BorderSide(
                        color: this.unfocusedBorderColor,
                        width: this.unfocusedBorderWidth,
                      )
                    : BorderSide.none,
              ),
              prefixIcon: icon != null ? Icon(icon) : null,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.all(
                  Radius.circular(borderRadius),
                ),
              ),
            ),
          );
      },
    );
  }

  /*Title of the entry that would show above the text*/
  final String fieldName;
  /**
  * `RxCommand<String,String>` where the input is the text entered, and the output is the validation text
  * For exmaple:  
  *```
  * String username;
  * RxCommand<String, String> usernameChanged;
  * MyClass() 
  * {
  *     username = ""; 
  *     usernameChanged = RxCommand.createSync<String, String>((s) 
  *     {
  *       username = s; 
  *       if (s.isEmpty) 
  *         return "Cannot be empty";
  *       if (s.length==3)
  *         return "Cannot be 3 characters";         
  *      return ""; 
  *  });
  *```
  */
  final RxCommand onChanged;

  /// To hide the text (mainly used for passwords)
  final bool obscureText;

  /// Icon which would be placed to the left of the text
  final IconData icon;

  final double focusedBorderWidth;
  final Color focusedBorderColor;
  final double unfocusedBorderWidth;
  final Color unfocusedBorderColor;
  final double borderRadius;
  final Color filledColor;

  /// The place holder
  final String hintText;
}
