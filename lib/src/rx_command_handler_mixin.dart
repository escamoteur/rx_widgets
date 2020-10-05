import 'package:flutter/widgets.dart';
import 'package:rx_command/rx_command.dart';

/// Adds ability to listen om RxCommand events inside Stateless Widgets.
///
/// Add [RxCommandHandlerMixin] to your Stateless widget to get an ability to listen for events
/// from command and make actions when its streams fire events.
/// Mixin will take care of RxCommandListener init dispose.
/// This way you can keep your [Widget] Stateless.
mixin RxCommandHandlerMixin<T, R> on StatelessWidget {
  final _state = _MixinState<T, R>();

  @override
  StatelessElement createElement() => _StatelessMixInElement<RxCommandHandlerMixin, T, R>(this);

  RxCommandListener<T, R> get commandListener;
}

/// Adds ability to listen om RxCommand events inside Stateful Widgets.
///
/// Add [RxCommandStatefulHandlerMixin] to your Stateful widget to get an ability to listen for events
/// from command and make actions when its streams fire events.
/// Mixin will take care of RxCommandListener init dispose.
mixin RxCommandStatefulHandlerMixin<T, R> on StatefulWidget {
  final _state = _MixinState<T, R>();

  @override
  StatefulElement createElement() => _StatefulMixInElement<RxCommandStatefulHandlerMixin, T, R>(this);

  RxCommandListener<T, R> get commandListener;
}

class _StatelessMixInElement<W extends RxCommandHandlerMixin, T, R> extends StatelessElement {
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


class _StatefulMixInElement<W extends RxCommandStatefulHandlerMixin, T, R> extends StatefulElement {
  _StatefulMixInElement(W widget) : super(widget);

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


class _MixinState<T, R> {
  RxCommandListener<T, R> _listener;

  void init(RxCommandListener<T, R> listener) => _listener = listener;

  void dispose() => _listener?.dispose();
}