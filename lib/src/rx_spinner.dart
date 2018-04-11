import 'dart:async';


import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:rx_widgets/src/widget_selector.dart';
import 'package:flutter/material.dart';




/// Spinner/Busyindicator that reacts on the output of a `Stream<bool>` it starts running as soon as a `true` value is received
/// until the next `false`is emitted. If the Spinner should replace another Widget while Spinning this widget can be passed as `normal` parameter.
/// `RxSpinner` also adapts to the current or specified platform look.
/// Needless to say that `RxSpinner` is ideal in combination with `RxCommand's` `isExecuting` Observable 
class RxSpinner  extends StatelessWidget{

  final Stream<bool> busyEvents;
  final Widget normal;

  final TargetPlatform platform;

  final double radius;

  final Color backgroundColor;
  final Animation<Color> valueColor;
  final double strokeWidth;
  final double value;

  /// Creates a new RxSpinner instance
  /// `busyEvents` : `Stream<bool>` that controls the activity of the Spinner. On receiving `true` it replaces the `normal` widget 
  ///  and starts running undtil it receives a `false`value.
  /// `platform`  : defines platorm style of the Spinner. If this is null or not provided the style of the current platform will be used
  /// `radius`    : radius of the Spinner  
  /// `normal`    : Widget that should be displayed while the Spinner is not active. If this is null a `Container` will be created instead.
  ///  all other parameters please see https://docs.flutter.io/flutter/material/CircularProgressIndicator-class.html 
  ///  they are ignored if the platform style is iOS.
  const RxSpinner({this.busyEvents, 
                  this.platform, 
                  this.radius = 20.0,  
                  this.backgroundColor,
                  this.value,
                  this.valueColor,
                  this.strokeWidth: 4.0,
                  this.normal, 
                  Key key }) 
          :  assert(busyEvents != null), super(key: key);

  @override
  Widget build(BuildContext context) {

    var platformToUse = platform != null ? platform : defaultTargetPlatform;

    
    var spinner = (platformToUse == TargetPlatform.iOS) ? new CupertinoActivityIndicator(radius: this.radius,) 
                                                        : new CircularProgressIndicator(backgroundColor: backgroundColor,
                                                                                        strokeWidth: strokeWidth,
                                                                                        valueColor: valueColor,
                                                                                        value: value
                                                        ,);

    return new WidgetSelector(buildEvents: busyEvents,
                              onTrue: new  Center(child: 
                                              new Container(width: this.radius * 2, height: this.radius*2, 
                                                    child: spinner
                                                  )
                                            ), 
                              onFalse: normal != null ? normal : new Container(),
                              
                              );

  }
}