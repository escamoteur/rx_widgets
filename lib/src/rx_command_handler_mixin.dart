import 'package:flutter/widgets.dart';
import 'package:rx_command/rx_command.dart';

mixin RxCommandHandlerMixin<TParam, TResult> on StatelessWidget {
  final _state = _MixinState<TParam, TResult>();

  @override
  StatelessElement createElement() => _StatelessMixInElement<RxCommandHandlerMixin, TParam, TResult>(this);

  RxCommandListener<TParam, TResult> get commandListener;
}

class _StatelessMixInElement<W extends RxCommandHandlerMixin, TParam, TResult> extends StatelessElement {
  _StatelessMixInElement(W widget) : super(widget);

  @override
  W get widget => super.widget;

  @override
  void mount(Element parent, newSlot) {
    widget._state.init(widget.commandListener);
    super.mount(parent, newSlot);
  }

  @override
  void unmount() {
    widget._state.dispose();
    super.unmount();
  }
}

class _MixinState<TParam, TResult> {
  RxCommandListener<TParam, TResult> _listener;

  void init(RxCommandListener<TParam, TResult> listener) => _listener = listener;

  void dispose() => _listener.dispose();
}
