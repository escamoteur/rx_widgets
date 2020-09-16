import 'package:flutter/widgets.dart';
import 'package:rx_command/rx_command.dart';

/// Wrap your [Widget] into [RxCommandExecutable] widget to get an ability to listen for events
/// from [command] and make actions from its streams
/// This way you can keep your [Widget] Stateless.
class RxCommandExecutable<TParam, TResult> extends StatefulWidget {
  final RxCommand<TParam, TResult> command;
  final Widget child;

  // Is called on every emitted value of the command
  final void Function(TResult value) onValue;

  // Is called when isExecuting changes
  final void Function(bool isBusy) onIsBusyChange;

  // Is called on exceptions in the wrapped command function
  final void Function(dynamic ex) onError;

  // Is called when canExecute changes
  final void Function(bool state) onCanExecuteChange;

  // is called with the value of the .results Stream of the command
  final void Function(CommandResult<TResult> result) onResult;

  // to make the handling of busy states even easier these are called on their respective states
  final void Function() onIsBusy;
  final void Function() onNotBusy;

  // optional you can directly pass in a debounce duration for the values of the command
  final Duration debounceDuration;

  const RxCommandExecutable({
    Key key,
    @required this.command,
    @required this.child,
    this.onValue,
    this.onIsBusyChange,
    this.onError,
    this.onCanExecuteChange,
    this.onResult,
    this.onIsBusy,
    this.onNotBusy,
    this.debounceDuration,
  })  : assert(command != null),
        assert(child != null),
        super(key: key);

  @override
  _RxCommandExecutableState<TParam, TResult> createState() => _RxCommandExecutableState<TParam, TResult>();
}

class _RxCommandExecutableState<TParam, TResult> extends State<RxCommandExecutable<TParam, TResult>> {
  RxCommandListener<TParam, TResult> _listener;

  @override
  void initState() {

    _listener = RxCommandListener<TParam, TResult>(
      widget.command,
      onValue: widget.onValue,
      onIsBusyChange: widget.onIsBusyChange,
      onIsBusy: widget.onIsBusy,
      onNotBusy: widget.onNotBusy,
      onError: widget.onError,
      onCanExecuteChange: widget.onCanExecuteChange,
      onResult: widget.onResult,
      debounceDuration: widget.debounceDuration,
    );
    super.initState();
  }

  @override
  void dispose() {
    _listener.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return widget.child;
  }
}
