# rx_widgets

`rx_widgets` is a package with stream based Flutter Widgets and Widget helper/convenience classes that facilitate an reactive programming style especially in combination with [RxDart](https://github.com/ReactiveX/rxdart) and [RxCommands](https://github.com/escamoteur/rx_command).


## Getting Started

Add to your `pubspec.yaml` dependencies to  `rx_widgets`


## Available Classes

### RxSpinner

Spinner/Busyindicator that reacts on the output of a `Stream<bool>` it starts running as soon as a `true` value is received until the next `false`is emitted. If the Spinner should replace another Widget while Spinning this widget can be passed as `normal` parameter. `RxSpinner` also adapts to the current or specified platform look. Needless to say that `RxSpinner` is ideal in combination with `RxCommand's` `isExecuting` Observable 

```Dart
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
```


### WidgetSelector
`WidgetSelector`is a convenience class that will return one of two Widgets based on the output of a `Stream<bool>` This is pretty handy if you want to react to state change like enable/disable in you ViewModel and update the View accordingly.

If you don't need builders for the alternative child widgets this class offers a more concise expression than `WidgetBuilderSelector`

```Dart
  /// Creates a new WidgetSelector instance
  /// `buildEvents` : `Stream<bool>`that signals that the this Widget should be updated
  /// `onTrue` : Widget that should be returned if an item with value true is received
  /// `onFalse`: Widget that should be returned if an item with value true is received
  const WidgetSelector({this.buildEvents,  this.onTrue,  this.onFalse, Key key }) 
          :   assert(buildEvents != null),assert(onTrue != null), 
              assert(onFalse != null), super(key: key);
```


This is an example where it is used to enable/disable a Button

```Dart
new WidgetSelector(buildEvents: TheViewModel.of(context).updateWeatherCommand.canExecute, 
    onTrue:  new RaisedButton(                               
                    child: new Text("Update"), 
                    color: new Color.fromARGB(255, 33, 150, 243),
                    textColor: new Color.fromARGB(255, 255, 255, 255),
                    onPressed: TheViewModel.of(context).updateWeatherCommand,
                    ),
    onFalse:  new RaisedButton(                               
                    child: new Text("Update"), 
                    color: new Color.fromARGB(255, 33, 150, 243),
                    textColor: new Color.fromARGB(255, 255, 255, 255),
                    onPressed: null,
                    ),
            
        ),
```


### WidgetBuilderSelector

 Like `WidgetSelector` but instead return Widgets it executes one of two provided builder functions. 
 In comparison to `WidgetSelector` this is best used if the alternative child widgets are large so that you don't want to have them always created without using them. 


```
/// Creates a new WidgetBuilderSelector instance
/// `buildEvents` : `Stream<bool>`that signals that the this Widget should be updated
/// `onTrue` : builder that should be executed if an item with value true is received
/// `onFalse`: builder that should be executed if an item with value true is received
const WidgetBuilderSelector({this.buildEvents,  this.onTrue,  this.onFalse, Key key }) 
        :  assert(buildEvents != null),assert(onTrue != null), assert(onFalse != null), super(key: key);
```