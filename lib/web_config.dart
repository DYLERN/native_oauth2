abstract class WebAuthenticationMode {
  const WebAuthenticationMode._();

  const factory WebAuthenticationMode.sameTab() = WebAuthenticationSameTab;

  const factory WebAuthenticationMode.popup({
    required String windowName,
    required int width,
    required int height,
    bool? shouldCenter,
    int? left,
    int? top,
    bool? fullscreen,
    bool? location,
    bool? menubar,
    bool? resizable,
    bool? scrollbars,
    bool? status,
    bool? titlebar,
    bool? toolbar,
    Map<String, String> additionalParams,
  }) = WebAuthenticationPopup;

  T when<T>({
    required T Function(WebAuthenticationSameTab sameTab) sameTab,
    required T Function(WebAuthenticationPopup popup) popup,
  }) {
    if (this is WebAuthenticationSameTab) {
      return sameTab(this as WebAuthenticationSameTab);
    } else if (this is WebAuthenticationPopup) {
      return popup(this as WebAuthenticationPopup);
    } else {
      throw StateError(
        'Instance of WebAuthenticationMode is not a known subtype',
      );
    }
  }
}

class WebAuthenticationSameTab extends WebAuthenticationMode {
  const WebAuthenticationSameTab() : super._();
}

class WebAuthenticationPopup extends WebAuthenticationMode {
  final String windowName;
  final int width;
  final int height;
  final bool? shouldCenter;
  final int? left;
  final int? top;
  final bool? fullscreen;
  final bool? location;
  final bool? menubar;
  final bool? resizable;
  final bool? scrollbars;
  final bool? status;
  final bool? titlebar;
  final bool? toolbar;
  final Map<String, String> additionalParams;

  const WebAuthenticationPopup({
    required this.windowName,
    required this.width,
    required this.height,
    this.shouldCenter,
    this.left,
    this.top,
    this.fullscreen,
    this.location,
    this.menubar,
    this.resizable,
    this.scrollbars,
    this.status,
    this.titlebar,
    this.toolbar,
    this.additionalParams = const {},
  }) : super._();

  String constructSpecs({required ScreenDimensions? screenDimensions}) {
    final specs = <String>[
      'width=$width',
      'height=$height',
    ];

    if (shouldCenter == true && screenDimensions != null) {
      final leftOffset = (screenDimensions.width / 2 - width / 2) + (left ?? 0);
      final topOffset = (screenDimensions.height / 2 - height / 2) + (top ?? 0);

      specs.add('left=$leftOffset');
      specs.add('top=$topOffset');
    } else {
      if (left != null) {
        specs.add('left=${left!}');
      }

      if (top != null) {
        specs.add('top=${top!}');
      }
    }

    if (fullscreen != null) {
      specs.add('fullscreen=${_boolToString(fullscreen!)}');
    }
    if (location != null) {
      specs.add('location=${_boolToString(location!)}');
    }
    if (menubar != null) {
      specs.add('menubar=${_boolToString(menubar!)}');
    }
    if (resizable != null) {
      specs.add('resizable=${_boolToString(resizable!)}');
    }
    if (scrollbars != null) {
      specs.add('scrollbars=${_boolToString(scrollbars!)}');
    }
    if (status != null) {
      specs.add('status=${_boolToString(status!)}');
    }
    if (titlebar != null) {
      specs.add('titlebar=${_boolToString(titlebar!)}');
    }
    if (toolbar != null) {
      specs.add('toolbar=${_boolToString(toolbar!)}');
    }
    specs.addAll(additionalParams.entries.map((e) => '${e.key}=${e.value}'));

    return specs.join(',');
  }

  String _boolToString(bool b) {
    return b ? 'yes' : 'no';
  }
}

class ScreenDimensions {
  final int width;
  final int height;

  const ScreenDimensions({
    required this.width,
    required this.height,
  });
}
