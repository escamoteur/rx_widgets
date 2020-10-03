import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:rx_command/rx_command.dart';
import 'package:rx_widgets/src/builder_functions.dart';

/// Spinner/Busy indicator that reacts on the output of a `Stream<CommandResult<T>>`.
/// It's made especially to work together with `RxCommand` from the `rx_command`package.
/// it starts running as soon as an item with `isExecuting==true` is received  until `isExecuting==true` is received.
/// To react on other possible states (`data, no data, error`) that can be emitted it offers three option `Builder` methods.
class RxCommandBuilder<T> extends StatelessWidget {
  final Stream<CommandResult<T>> commandResults;
  final RxBuilder<T> dataBuilder;
  final ErrorBuilder<Exception> errorBuilder;
  final BusyBuilder busyBuilder;
  final PlaceHolderBuilder placeHolderBuilder;
  final TargetPlatform platform;

  /// Creates a new `RxCommandBuilder` instance
  /// [commandResults] : `Stream<CommandResult<T>>` or a `RxCommand<T>` that issues `CommandResults`
  /// [busyBuilder] : Builder that will be called as soon as an event with `isExecuting==true`.
  /// [dataBuilder] : Builder that will be called as soon as an event with data is received. It will get passed the `data` field of the CommandResult.
  /// If this is null a `Container` will be created instead.
  /// [placeHolderBuilder] : Builder that will be called as soon as an event with `data==null` is received.
  /// If this is null a `Container` will be created instead.
  /// [dataBuilder] : Builder that will be called as soon as an event with an `error` is received. It will get passed the `error` field of the CommandResult.
  /// If this is null a `Container` will be created instead.
  const RxCommandBuilder({
    Key key,
    @required this.commandResults,
    this.platform,
    this.busyBuilder,
    this.dataBuilder,
    this.placeHolderBuilder,
    this.errorBuilder,
  })  : assert(commandResults != null),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<CommandResult<T>>(
      stream: commandResults,
      builder: (context, snapshot) {
        CommandResult<T> item;
        if (snapshot.hasData) {
          item = snapshot.data;
        } else if (snapshot.hasError) {
          item = CommandResult.error(snapshot.error);
        } else {
          item = const CommandResult(null, null, false);
        }
        return _processItem(context, item);
      },
    );
  }

  Widget _processItem(BuildContext context, CommandResult<T> item) {
    assert(item != null);

    if (item.isExecuting) {
      if (busyBuilder != null) {
        return busyBuilder(context);
      } else {
        final spinner = (platform ?? defaultTargetPlatform == TargetPlatform.iOS)
            ? const CupertinoActivityIndicator()
            : const CircularProgressIndicator();
        return Center(child: spinner);
      }
    }

    if (item.hasData) {
      if (dataBuilder != null) {
        return dataBuilder(context, item.data);
      } else {
        return const SizedBox();
      }
    }

    if (item.hasError) {
      if (errorBuilder != null) {
        return errorBuilder(context, item.error);
      } else {
        return const SizedBox();
      }
    }

    if (placeHolderBuilder != null) {
      return placeHolderBuilder(context);
    } else {
      return const SizedBox();
    }
  }
}
