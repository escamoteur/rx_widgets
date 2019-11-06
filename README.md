# RxWidgets

[![Pub](https://img.shields.io/pub/v/rx_widgets.svg)](https://pub.dev/packages/rx_widgets)

## About

A package with stream based Flutter Widgets that facilitate an reactive programming style.
 
Was built to be used especially in combination with [RxDart](https://github.com/ReactiveX/rxdart) and [RxCommands](https://github.com/escamoteur/rx_command).

>If you have any ideas for additional stream based Widget, open an issue
>PRs are always welcome ;-)


## Getting Started

Add to your `pubspec.yaml` dependencies to  `rx_widgets`


## Widgets Available
- [RxRaisedButton](#rxraisedbutton)
- [RxText](#rxtext)
- [RxLoader](#rxloader)
- [RxSpinner](#rxspinner)
- [WidgetSelector](#widgetselector)
- [RxCommandBuilder](#rxcommandbuilder)
- [ReactiveBuilder](#reactivebuilder)

### RxRaisedButton
Creates a `RaisedButton` that has an `rxCommand` instead of `onPressed`. It gets disabled if the command has canExecute:false or when isExecuting:true

An extended `RaisedButton` where the `onPressed` is replaced with `rxCommand` and it gets disabled if the `rxCommand` has the `canExecute` set to `false` or when it is executing.

```Dart
RxRaisedButton({
    Key key,
    // The RxCommand.
    this.rxCommand,
    this.child,
    this.onHighlightChanged,
    this.textTheme,
    this.textColor,
    this.disabledTextColor,
    this.color,
    this.disabledColor,
    this.highlightColor,
    this.splashColor,
    this.colorBrightness,
    this.elevation,
    this.highlightElevation,
    this.disabledElevation,
    this.padding,
    this.shape,
    this.materialTapTargetSize,
    this.animationDuration,
  }) : super(key: key);
```


### RxText
A `Text` that takes in a `Stream<String>` and displays it. An example of usage can be when showing status message , or results of some requests. 

**errorBuilder**  is a method that is called when the stream receives an error. By default this method returns a Text containing the error.

**placeHolderBuilder** is a method that is called when the stream has no data. By default this method returns a CircularProgressIndicator.
**initialData** parameter that can be used to provide a starting value, just like in StreamBuilder.
```Dart
    RxText({
    // New parameters.
    @required Stream<String> stream,
    String initialData,
    this.errorBuilder,
    this.placeHolderBuilder,
    
    // Normal Text parameters.
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
  })
```
### RxSpinner

Spinner/Busy indicator that reacts on the output of a `Stream<bool>` it starts running as soon as a `true` value is received until the next `false`is emitted. If the Spinner should replace another Widget while Spinning this widget can be passed as `normal` parameter. `RxSpinner` also adapts to the current or specified platform look. Needless to say that `RxSpinner` is ideal in combination with `RxCommand's` `isExecuting` Observable 


**busyEvents** `Stream<bool>` that controls the activity of the Spinner. On receiving `true` it replaces the `normal` widget and starts running undtil it receives a `false`value.

**platform** defines platorm style of the Spinner. If this is null or not provided the style of the current platform will be used.

**radius** is the radius of the Spinner.

**normal** is a Widget that should be displayed while the Spinner is not active. If this is null a `Container` will be created instead.
All other parameters please see https://docs.flutter.io/flutter/material/CircularProgressIndicator-class.html.

`RxSpinner` are ignored if the platform style is iOS.
```Dart
RxSpinner({    
    this.busyEvents, 
    this.platform, 
    this.radius = 20.0,  
    this.backgroundColor,
    this.value,
    this.valueColor,
    this.strokeWidth: 4.0,
    this.normal, 
    Key key })         
```


### RxLoader

RxSpinner is great for simple Applications where you just want to show or hide a Spinner. But often especially when loading data you want to deal with errors and show an alternative Widget if no data arrived. Since `RxCommand` offers not only three separate Observables for state changes and results but is also an `Observable<CommandResult<T>` itself that emits  `CommandResult` that bundle all state and data in one Object `RxLoader`leverage this to support the Flutter update mechanic better.


**busyEvents** `Stream<bool>` that controls the activity of the Spinner. On receiving `true` it replaces the `normal` widget and starts running undtil it receives a `false`value.

**platform** defines platorm style of the Spinner. If this is null or not provided the style of the current platform will be used.

**radius** radius of the Spinner.

**dataBuilder** Builder that will be called as soon as an event with data is received. It will get passed the `data` feeld of the CommandResult.

**placeHolderBuilder** Builder that will be called as soon as an event with `data==null` is received. 

**errorBuilder** Builder that will be called as soon as an event with an `error` is received. It will get passed the `error` feeld of the CommandResult.

All other parameters please see https://docs.flutter.io/flutter/material/CircularProgressIndicator-class.html.
`RxLoader` are ignored if the platform style is iOS.

```Dart
RxLoader({
    Key key 
    this.commandResults, 
    this.platform, 
    this.radius = 20.0,  
    this.backgroundColor,
    this.value,
    this.valueColor,
    this.strokeWidth: 4.0,
    this.dataBuilder, 
    this.placeHolderBuilder, 
    this.errorBuilder,
})
```




### WidgetSelector
`WidgetSelector`is a convenience class that will return one of two Widgets based on the output of a `Stream<bool>` This is pretty handy if you want to react to state change like enable/disable in you ViewModel and update the View accordingly.

If you don't need builders for the alternative child widgets this class offers a more concise expression than `WidgetBuilderSelector`

**buildEvents** `Stream<bool>`that signals that the this Widget should be updated.

**onTrue** Widget that should be returned if an item with value true is received.

**onFalse** Widget that should be returned if an item with value true is received.

**errorBuilder** Builder that will be called as soon as an event with an `error` is received. It will get passed the `error` feeld of the CommandResult.

**placeHolderBuilder** Builder that will be called as soon as an event with `data==null` is 
received.

**initialData** can be used to provide an initial value just as it does in StreamBuilder.

```Dart
  WidgetSelector(
      {Key key,
      Stream<bool> buildEvents,
      this.onTrue,
      this.onFalse,
      this.errorBuilder,
      this.placeHolderBuilder,
      bool initialValue,
      })
```

#### WidgetSelector Example
This is an example where it is used to enable/disable a Button

```Dart
WidgetSelector(
      buildEvents: myStream,
      onTrue: RaisedButton(
          child: Text("Update"),
          onPressed: () {
            // Action
          }),
      onFalse: RaisedButton(
        child: Text("Please Wait"),
        onPressed: null,
      ),
    );
```


### WidgetBuilderSelector

 Like `WidgetSelector` but instead return Widgets it executes one of two provided builder functions. 
 In comparison to `WidgetSelector` this is best used if the alternative child widgets are large so that you don't want to have them always created without using them. 



### RxCommandBuilder

If you are working with `RxCommands` this is a special Builder that lets you define different builder for the different states an RxCommand can issue.
If you don't specify one of the builders it will create a `Container` for that state.


**commandResults** `Stream<bool>` .`Stream<CommandResult<T>>` or a `RxCommand<T>` that issues `CommandResults`

**busyBuilder** Builder that will be called as soon as an event with `isExecuting==true`.

**dataBuilder** Builder that will be called as soon as an event with data is received. It will get passed the `data` feeld of the CommandResult. It will get passed the `data` feeld of the CommandResult.

**placeHolderBuilder** Builder that will be called as soon as an event with `data==null` is received. **If this is null** a `Container` will be created instead.  

**errorBuilder** Builder that will be called as soon as an event with an `error` is received. It will get passed the `error` feeld of the CommandResult.

``` dart
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
```


### ReactiveBuilder
Widget built to encapsulate StreamBuilder.

**stream** `Stream<T>` that controls the widget.

**initialData** can be used to provide an initial value just as it does in StreamBuilder.

**builder** lis a method that will be cal when the stream receive data.

**placeHolderBuilder** is a method that will be cal when the stream is initialized without data or when receive a null data. By default this method returns a CircularProgressIndicator.

**errorBuilder** is a method that will be call when the stream receive a error. By default this method returns a Text containing the error. 

``` dart
const ReactiveBuilder({
    Key key,
    @required Stream<T> stream,
    T initialData,
    @required this.builder,
    this.placeHolderBuilder,
    this.errorBuilder,
  })
```

#### ReactiveBuilder Example

``` dart
class Animal {
  String name;
  int age;
}

class Example extends StatelessWidget {
  final Stream<Animal> stream;

  Example(this.stream);

  @override
  Widget build(BuildContext context) {
    return ReactiveBuilder<Animal>(
      stream: stream,
      builder: (BuildContext context, data) {
        return ListTile(
          title: Text(data.name),
          subtitle: Text("${data.age}"),
        );
      },
    );
  }
}
```