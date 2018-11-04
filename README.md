# rx_widgets

`rx_widgets` is a package with stream based Flutter Widgets and Widget helper/convenience classes that facilitate an reactive programming style especially in combination with [RxDart](https://github.com/ReactiveX/rxdart) and [RxCommands](https://github.com/escamoteur/rx_command).

>If you have any ideas for additional stream based Widget, open an issue
>PRs are always welcome ;-)


## Getting Started

Add to your `pubspec.yaml` dependencies to  `rx_widgets`


## Available Classes

### RxRaisedButton
Creates a RaisedButton that has an rxCommand instead of onPressed. It gets disabled if the command has canExecute:false or when isExecuting:true

```Dart
/// an extended `RaisedButton` where the `onPressed` is replaced with `rxCommand`
/// and it gets disabled if the `rxCommand` has the `canExecute` set to `false` or when it is executing
const RxRaisedButton({
    @required this.rxCommand,
    Key key,
    ValueChanged<bool> onHighlightChanged,
    ButtonTextTheme textTheme,
    Color textColor,
    Color disabledTextColor,
    Color color,
    Color disabledColor,
    Color highlightColor,
    Color splashColor,
    Brightness colorBrightness,
    double elevation,
    double highlightElevation,
    double disabledElevation,
    EdgeInsetsGeometry padding,
    ShapeBorder shape,
    Clip clipBehavior = Clip.none,
    MaterialTapTargetSize materialTapTargetSize,
    Duration animationDuration,
    Widget child,
  }) : super(
          key: key,
          onPressed: null,
          onHighlightChanged: onHighlightChanged,
          textTheme: textTheme,
          textColor: textColor,
          disabledTextColor: disabledTextColor,
          color: color,
          disabledColor: disabledColor,
          highlightColor: highlightColor,
          splashColor: splashColor,
          colorBrightness: colorBrightness,
          elevation: elevation,
          highlightElevation: highlightElevation,
          disabledElevation: disabledElevation,
          padding: padding,
          shape: shape,
          clipBehavior: clipBehavior,
          materialTapTargetSize: materialTapTargetSize,
          animationDuration: animationDuration,
          child: child,
        );
```


### RxText
a Text that takes in a `Stream<String>` and displays it. An example of usage can be when showing status message , or results of some requests. 
```Dart
    RxText(
    this.stream, {
    Key key,
    this.style,
    this.textAlign,
    this.textDirection,
    this.locale,
    this.softWrap,
    this.overflow,
    this.textScaleFactor,
    this.maxLines,
    this.semanticsLabel,
  })  : assert(stream != null && stream is Stream<String>),
        textSpan = null,
        super(key: key);
```
### RxSpinner

Spinner/Busy indicator that reacts on the output of a `Stream<bool>` it starts running as soon as a `true` value is received until the next `false`is emitted. If the Spinner should replace another Widget while Spinning this widget can be passed as `normal` parameter. `RxSpinner` also adapts to the current or specified platform look. Needless to say that `RxSpinner` is ideal in combination with `RxCommand's` `isExecuting` Observable 

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


### RxLoader

RxSpinner is great for simple Applications where you just want to show or hide a Spinner. But often especially when loading data you want to deal with errors and show an alternative Widget if no data arrived. Since `RxCommand` offers not only three separate Observables for state changes and results but is also an `Observable<CommandResult<T>` itself that emits  `CommandResult` that bundle all state and data in one Object `RxLoader`leverage this to support the Flutter update mechanic better.

```Dart
/// Creates a new `RxLoader` instance
/// [busyEvents] : `Stream<bool>` that controls the activity of the Spinner. On receiving `true` it replaces the `normal` widget 
///  and starts running undtil it receives a `false`value.
/// [platform]  : defines platorm style of the Spinner. If this is null or not provided the style of the current platform will be used
/// [radius]    : radius of the Spinner  
/// [dataBuilder] : Builder that will be called as soon as an event with data is received. It will get passed the `data` feeld of the CommandResult.
/// If this is null a `Container` will be created instead.
/// [placeHolderBuilder] : Builder that will be called as soon as an event with `data==null` is received. 
/// If this is null a `Container` will be created instead.
/// [dataBuilder] : Builder that will be called as soon as an event with an `error` is received. It will get passed the `error` feeld of the CommandResult.
/// If this is null a `Container` will be created instead.
///  all other parameters please see https://docs.flutter.io/flutter/material/CircularProgressIndicator-class.html 
///  they are ignored if the platform style is iOS.
const RxLoader({this.commandResults, 
                this.platform, 
                this.radius = 20.0,  
                this.backgroundColor,
                this.value,
                this.valueColor,
                this.strokeWidth: 4.0,
                this.dataBuilder, 
                this.placeHolderBuilder, 
                this.errorBuilder,
                Key key }) 
        :  assert(commandResults != null), super(key: key);
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


```Dart
/// Creates a new WidgetBuilderSelector instance
/// `buildEvents` : `Stream<bool>`that signals that the this Widget should be updated
/// `onTrue` : builder that should be executed if an item with value true is received
/// `onFalse`: builder that should be executed if an item with value true is received
const WidgetBuilderSelector({this.buildEvents,  this.onTrue,  this.onFalse, Key key }) 
        :  assert(buildEvents != null),assert(onTrue != null), assert(onFalse != null), super(key: key);
```


### RxCommandBuilder

If you are working with `RxCommands` this is a special Builder that lets you define different builder for the different states an RxCommand can issue.
If you don't specify one of the builders it will create a `Container` for that state.

```
/// Creates a new `RxCommandBuilder` instance
/// [commandResults] : `Stream<CommandResult<T>>` or a `RxCommand<T>` that issues `CommandResults`
/// [busyBuilder] : Builder that will be called as soon as an event with `isExecuting==true`.
/// [dataBuilder] : Builder that will be called as soon as an event with data is received. It will get passed the `data` feeld of the CommandResult.
/// If this is null a `Container` will be created instead.
/// [placeHolderBuilder] : Builder that will be called as soon as an event with `data==null` is received. 
/// If this is null a `Container` will be created instead.
/// [dataBuilder] : Builder that will be called as soon as an event with an `error` is received. It will get passed the `error` feeld of the CommandResult.
/// If this is null a `Container` will be created instead.
const RxCommandBuilder({Key key,
                this.commandResults, 
                this.platform, 
                this.radius = 20.0,  
                this.backgroundColor,
                this.value,
                this.valueColor,
                this.strokeWidth: 4.0,
                this.busyBuilder,
                this.dataBuilder, 
                this.placeHolderBuilder, 
                this.errorBuilder,
                }) 
        :  assert(commandResults != null), super(key: key);
```