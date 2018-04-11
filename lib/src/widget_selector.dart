import 'dart:async';

import 'package:flutter/widgets.dart';



/// `WidgetSelector`is a convenience class that will return one of two Widgets based on the output of a `Stream<bool>`
/// This is pretty handy if you want to react to state change like enable/disable in you ViewModel and update
/// the View accordingly.
/// If you don't need builders for the alternative child widgets this class offers a more concise expression than `WidgetBuilderSelector`
class WidgetSelector  extends StatelessWidget{

  final Stream<bool> buildEvents;
  final Widget onTrue;
  final Widget onFalse;

  /// Creates a new WidgetSelector instance
  /// `buildEvents` : `Stream<bool>`that signals that the this Widget should be updated
  /// `onTrue` : Widget that should be returned if an item with value true is received
  /// `onFalse`: Widget that should be returned if an item with value true is received
  const WidgetSelector({this.buildEvents,  this.onTrue,  this.onFalse, Key key }) 
          :   assert(buildEvents != null),assert(onTrue != null), assert(onFalse != null), super(key: key);

  @override
  Widget build(BuildContext context) {
    return new StreamBuilder(stream: buildEvents,
                          builder: (BuildContext context, AsyncSnapshot<bool> event)
                          {   
                              if (event.hasData && event.data == true)
                              {
                                  return onTrue;
                              }
                              else
                              {
                                return onFalse;
                              }
                          }); 
  }
  
}

/// `WidgetBuilderSelector`is a convenience class that will one of two builder methods based on the output of a `Stream<bool>`
/// This is pretty handy if you want to react to state change like enable/disable in you ViewModel and update
/// the View accordingly.
/// In comparrison to `WidgetSelector` this is best used if the alternative child widgets are large so that you don't want to have them created 
/// without using them. 
class WidgetBuilderSelector  extends StatelessWidget{

  final Stream<bool> buildEvents;
  final WidgetBuilder onTrue;
  final WidgetBuilder onFalse;

  /// Creates a new WidgetBuilderSelector instance
  /// `buildEvents` : `Stream<bool>`that signals that the this Widget should be updated
  /// `onTrue` : builder that should be executed if an item with value true is received
  /// `onFalse`: builder that should be executed if an item with value true is received
  const WidgetBuilderSelector({this.buildEvents,  this.onTrue,  this.onFalse, Key key }) 
          :  assert(buildEvents != null),assert(onTrue != null), assert(onFalse != null), super(key: key);

  @override
  Widget build(BuildContext context) {
    return new StreamBuilder(stream: buildEvents,
                          builder: (BuildContext context, AsyncSnapshot<bool> event)
                          {   
                              if (event.hasData && event.data == true)
                              {
                                  return onTrue(context);
                              }
                              else
                              {
                                return onFalse(context);
                              }
                          }); 
  }
  
}
                         