import 'dart:async';

import 'package:flutter/widgets.dart';

class WidgetSelector  extends StatelessWidget{

  final Stream<bool> buildEvents;
  final Widget onTrue;
  final Widget onFalse;

  const WidgetSelector({this.buildEvents,  this.onTrue,  this.onFalse, Key key }) 
          :  assert(onTrue != null), assert(onFalse != null), super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(stream: buildEvents,
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
