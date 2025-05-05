import 'package:flutter/widgets.dart';
import 'package:flutter_typeahead/src/common/base/connector_widget.dart';
import 'package:flutter_typeahead/src/common/base/suggestions_controller.dart';

/// Hides the suggestions box when a suggestion is selected.
class SuggestionsFieldQueryConnector<T> extends StatelessWidget {
  const SuggestionsFieldQueryConnector({
    super.key,
    required this.controller,
    required this.child,
    this.hideOnSelect,
    this.onQueried,
  });

  final SuggestionsController<T> controller;
  final Widget child;

  final bool? hideOnSelect;
  final VoidCallback? onQueried;

  void _onQueried(void v) {
    onQueried?.call();
    if (hideOnSelect ?? true) {
      controller.close(retainFocus: true);
    } else {
      controller.focusField();
    }
  }

  @override
  Widget build(BuildContext context) {
    return ConnectorWidget(
      value: controller,
      connect: (value) => value.queries.listen(_onQueried),
      disconnect: (value, key) => key?.cancel(),
      child: child,
    );
  }
}
