import 'package:flutter/material.dart';
import 'package:rx_command/rx_command.dart';
import 'package:rx_widgets/src/builder_functions.dart';

/// Spinner/Busyindicator that reacts on the output of a `Stream<CommandResult<T>>`. It's made especially to work together with
/// `RxCommand` from the `rx_command`package.
/// it starts running as soon as an item with  `isExecuting==true` is received
/// until `isExecuting==true` is received.
/// To react on other possible states (`data, nodata, error`) that can be emitted it offers three option `Builder` methods
class RxCommandBuilder<T> extends StatefulWidget {
  final Stream<CommandResult<T>> commandResults;
  final RxBuilder<T> dataBuilder;
  final ErrorBuilder<Exception> errorBuilder;
  final BusyBuilder busyBuilder;
  final PlaceHolderBuilder placeHolderBuilder;

  final TargetPlatform platform;

  /// Creates a new `RxCommandBuilder` instance
  /// [commandResults] : `Stream<CommandResult<T>>` or a `RxCommand<T>` that issues `CommandResults`
  /// [busyBuilder] : Builder that will be called as soon as an event with `isExecuting==true`.
  /// [dataBuilder] : Builder that will be called as soon as an event with data is received. It will get passed the `data` feeld of the CommandResult.
  /// If this is null a `Container` will be created instead.
  /// [placeHolderBuilder] : Builder that will be called as soon as an event with `data==null` is received.
  /// If this is null a `Container` will be created instead.
  /// [dataBuilder] : Builder that will be called as soon as an event with an `error` is received. It will get passed the `error` feeld of the CommandResult.
  /// If this is null a `Container` will be created instead.
  const RxCommandBuilder({
    Key key,
    this.commandResults,
    this.platform,
    this.busyBuilder,
    this.dataBuilder,
    this.placeHolderBuilder,
    this.errorBuilder,
  })  : assert(commandResults != null),
        super(key: key);

  @override
  _RxCommandBuilderState createState() {
    return new _RxCommandBuilderState<T>();
  }
}

class _RxCommandBuilderState<T> extends State<RxCommandBuilder<T>> {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<CommandResult<T>>(
      stream: widget.commandResults,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          final item = snapshot.data;
          return _processItem(item);
        } else if (snapshot.hasError) {
          return widget.errorBuilder(context, snapshot.error);
        } else {
          return widget.placeHolderBuilder(context);
        }
      },
    );
  }

  Widget _processItem(CommandResult<T> item) {
    if (item.isExecuting) {
      return widget.busyBuilder(context);
    }
    if (item.hasData) {
      if (widget.dataBuilder != null) {
        return widget.dataBuilder(context, item.data);
      }
    }

    if (!item.hasData && !item.hasError) {
      if (widget.placeHolderBuilder != null) {
        return widget.placeHolderBuilder(context);
      }
    }

    if (item.hasError) {
      if (widget.errorBuilder != null) {
        return widget.errorBuilder(context, item.error);
      }
    }
  }
}
