import 'dart:async';

import 'package:flutter/material.dart';

import 'builder_functions.dart';
import 'reactive_base_widget.dart';

/// A reimplementation of `Text` so it takes a [Stream<String>] instead of `String` as data
/// and reacts on it.
class RxText extends ReactiveBaseWidget<String> {
  final ErrorBuilder<String>? errorBuilder;
  final PlaceHolderBuilder? placeHolderBuilder;

  /// The text to display as a [TextSpan].
  /// If non-null, the style to use for this text.
  ///
  /// If the style's "inherit" property is true, the style will be merged with
  /// the closest enclosing [DefaultTextStyle]. Otherwise, the style will
  /// replace the closest enclosing [DefaultTextStyle].
  final TextStyle? style;

  /// How the text should be aligned horizontally.
  final TextAlign? textAlign;

  /// The directionality of the text.
  ///
  /// This decides how [textAlign] values like [TextAlign.start] and
  /// [TextAlign.end] are interpreted.
  ///
  /// This is also used to disambiguate how to render bidirectional text. For
  /// example, if the data is an English phrase followed by a Hebrew phrase,
  /// in a [TextDirection.ltr] context the English phrase will be on the left
  /// and the Hebrew phrase to its right, while in a [TextDirection.rtl]
  /// context, the English phrase will be on the right and the Hebrew phrase on
  /// its left.
  ///
  /// Defaults to the ambient [Directionality], if any.
  final TextDirection? textDirection;

  /// Used to select a font when the same Unicode character can
  /// be rendered differently, depending on the locale.
  ///
  /// It's rarely necessary to set this property. By default its value
  /// is inherited from the enclosing app with `Localizations.localeOf(context)`.
  ///
  /// See Flutter RenderParagraph.locale for more information.
  final Locale? locale;

  /// Whether the text should break at soft line breaks.
  ///
  /// If false, the glyphs in the text will be positioned as if there was unlimited horizontal space.
  final bool? softWrap;

  /// How visual overflow should be handled.
  final TextOverflow? overflow;

  /// The number of font pixels for each logical pixel.
  ///
  /// For example, if the text scale factor is 1.5, text will be 50% larger than
  /// the specified font size.
  ///
  /// The value given to the constructor as textScaleFactor. If null, will
  /// use the [MediaQueryData.textScaleFactor] obtained from the ambient
  /// [MediaQuery], or 1.0 if there is no [MediaQuery] in scope.
  final double? textScaleFactor;

  /// An optional maximum number of lines for the text to span, wrapping if necessary.
  /// If the text exceeds the given number of lines, it will be truncated according
  /// to [overflow].
  ///
  /// If this is 1, text will not wrap. Otherwise, text will be wrapped at the
  /// edge of the box.
  ///
  /// If this is null, but there is an ambient [DefaultTextStyle] that specifies
  /// an explicit number for its [DefaultTextStyle.maxLines], then the
  /// [DefaultTextStyle] value will take precedence. You can use a [RichText]
  /// widget directly to entirely override the [DefaultTextStyle].
  final int? maxLines;

  /// An alternative semantics label for this text.
  ///
  /// If present, the semantics of this widget will contain this value instead
  /// of the actual text.
  ///
  /// This is useful for replacing abbreviations or shorthands with the full
  /// text value:
  ///
  /// ```dart
  /// Text(r'$$', semanticsLabel: 'Double dollars')
  ///
  /// ```
  final String? semanticsLabel;

  RxText(
    Stream<String> stream, {
    Key? key,
    String? initialData,
    this.errorBuilder,
    this.placeHolderBuilder,
    this.style,
    this.textAlign,
    this.textDirection,
    this.locale,
    this.softWrap,
    this.overflow,
    this.textScaleFactor,
    this.maxLines,
    this.semanticsLabel,
  }) : super(
          stream,
          initialData,
          key: key,
        );

  @override
  Widget build(BuildContext context, String data) {
    return Text(
      data,
      locale: this.locale,
      key: this.key,
      maxLines: this.maxLines,
      overflow: this.overflow,
      semanticsLabel: this.semanticsLabel,
      softWrap: this.softWrap,
      style: this.style,
      textAlign: this.textAlign,
      textDirection: this.textDirection,
      textScaleFactor: this.textScaleFactor,
    );
  }

  @override
  Widget errorBuild(BuildContext context, Object? error) {
    if (errorBuilder != null) return errorBuilder!(context, error);
    return Container();
  }

  @override
  Widget placeHolderBuild(BuildContext context) {
    if (placeHolderBuilder != null) return placeHolderBuilder!(context);
    return Container();
  }
}
