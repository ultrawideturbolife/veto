/// Enum for specifying different types of busy indicators.
///
/// Types include:
/// [indicator] Shows only the indicator.
/// [indicatorIgnorePointer] Shows the indicator and ignores touch events.
/// [indicatorBackdrop] Shows the indicator with a backdrop.
/// [indicatorBackdropIgnorePointer] Shows the indicator with a backdrop and ignores touch events.
enum BusyType {
  /// Shows no indicator
  none,

  /// Shows only the indicator.
  indicator,

  /// Shows the indicator and ignores touch events.
  indicatorIgnorePointer,

  /// Shows the indicator with a backdrop.
  indicatorBackdrop,

  /// Shows the indicator with a backdrop and ignores touch events.
  indicatorBackdropIgnorePointer;

  /// Default value for `BusyType`.
  static const defaultValue = BusyType.indicator;

  /// Checks if the current `BusyType` should ignore pointer events.
  ///
  /// Returns `true` for `indicatorIgnorePointer` and `indicatorBackdropIgnorePointer`,
  /// and `false` otherwise.
  bool get ignorePointer {
    switch (this) {
      case BusyType.none:
      case BusyType.indicator:
      case BusyType.indicatorBackdrop:
        return false;
      case BusyType.indicatorIgnorePointer:
      case BusyType.indicatorBackdropIgnorePointer:
        return true;
    }
  }

  /// Checks if the current `BusyType` should show a backdrop.
  ///
  /// Returns `true` for `indicatorBackdrop` and `indicatorBackdropIgnorePointer`,
  /// and `false` otherwise.
  bool get showBackdrop {
    switch (this) {
      case BusyType.none:
      case BusyType.indicator:
      case BusyType.indicatorIgnorePointer:
        return false;
      case BusyType.indicatorBackdrop:
      case BusyType.indicatorBackdropIgnorePointer:
        return true;
    }
  }
}
