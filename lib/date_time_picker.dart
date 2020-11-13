// Copyright 2014 The m3uzz Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

library date_time_picker;

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';

export 'package:intl/intl.dart';

enum DateTimePickerType { date, time, dateTime, dateTimeSeparate }

/// A [DateTimePicker] that contains a [TextField].
///
/// This is a convenience widget that wraps a [TextField] widget in a
/// [DateTimePicker].
///
/// A [Form] ancestor is not required. The [Form] simply makes it easier to
/// save, reset, or validate multiple fields at once. To use without a [Form],
/// pass a [GlobalKey] to the constructor and use [GlobalKey.currentState] to
/// save or reset the form field.
///
/// When a [controller] is specified, its [TextEditingController.text]
/// defines the [initialValue]. If this [FormField] is part of a scrolling
/// container that lazily constructs its children, like a [ListView] or a
/// [CustomScrollView], then a [controller] should be specified.
/// The controller's lifetime should be managed by a stateful widget ancestor
/// of the scrolling container.
///
/// If a [controller] is not specified, [initialValue] can be used to give
/// the automatically generated controller an initial value.
///
/// Remember to [dispose] of the [TextEditingController] when it is no longer needed.
/// This will ensure we discard any resources used by the object.
///
/// For a documentation about the various parameters, see [TextField].
///
/// {@tool snippet}
///
/// Creates a [DateTimePicker] with an [InputDecoration] and validator function.
///
/// ![If the user enters valid text, the TextField appears normally without any warnings to the user](https://flutter.github.io/assets-for-api-docs/assets/material/text_form_field.png)
///
/// ![If the user enters invalid text, the error message returned from the validator function is displayed in dark red underneath the input](https://flutter.github.io/assets-for-api-docs/assets/material/text_form_field_error.png)
///
/// ```dart
/// DateTimePicker(
///   decoration: const InputDecoration(
///     icon: Icon(Icons.person),
///     hintText: 'What do people call you?',
///     labelText: 'Name *',
///   ),
///   onSaved: (String value) {
///     // This optional block of code can be used to run
///     // code when the user saves the form.
///   },
///   validator: (String value) {
///     return value.contains('@') ? 'Do not use the @ char.' : null;
///   },
/// )
/// ```
/// {@end-tool}
///
/// {@tool dartpad --template=stateful_widget_material}
/// This example shows how to move the focus to the next field when the user
/// presses the ENTER key.
///
/// ```dart imports
/// import 'package:flutter/services.dart';
/// ```
///
/// ```dart
/// Widget build(BuildContext context) {
///   return Material(
///     child: Center(
///       child: Shortcuts(
///         shortcuts: <LogicalKeySet, Intent>{
///           // Pressing enter on the field will now move to the next field.
///           LogicalKeySet(LogicalKeyboardKey.enter):
///               Intent(NextFocusAction.key),
///         },
///         child: FocusTraversalGroup(
///           child: Form(
///             autovalidate: true,
///             onChanged: () {
///               Form.of(primaryFocus.context).save();
///             },
///             child: Wrap(
///               children: List<Widget>.generate(5, (int index) {
///                 return Padding(
///                   padding: const EdgeInsets.all(8.0),
///                   child: ConstrainedBox(
///                     constraints: BoxConstraints.tight(Size(200, 50)),
///                     child: DateTimePicker(
///                       initialValue: DateTime.now().toString(),
///                       firstDate: DateTime(2000),
///                       lastDate: DateTime(2100),
///                       onSaved: (String value) {
///                         print('Value for field $index saved as "$value"');
///                       },
///                     ),
///                   ),
///                 );
///               }),
///             ),
///           ),
///         ),
///       ),
///     ),
///   );
/// }
/// ```
/// {@end-tool}
///
/// See also:
///
///  * <https://material.io/design/components/text-fields.html>
///  * [TextField], which is the underlying text field without the [Form]
///    integration.
///  * [InputDecorator], which shows the labels and other visual elements that
///    surround the actual text editing widget.
///  * Learn how to use a [TextEditingController] in one of our [cookbook recipe]s.(https://flutter.dev/docs/cookbook/forms/text-field-changes#2-use-a-texteditingcontroller)
class DateTimePicker extends FormField<String> {
  /// Creates a [DateTimePicker] that contains a [TextField].
  ///
  /// When a [controller] is specified, [initialValue] must be null (the
  /// default). If [controller] is null, then a [TextEditingController]
  /// will be constructed automatically and its `text` will be initialized
  /// to [initialValue] or the empty string.
  ///
  /// For documentation about the various parameters, see the [TextField] class
  /// and [new TextField], the constructor.
  DateTimePicker({
    Key key,
    this.type = DateTimePickerType.date,
    this.controller,
    this.firstDate,
    this.lastDate,
    this.dateMask,
    this.icon,
    this.dateLabelText,
    this.timeLabelText,
    this.dateHintText,
    this.timeHintText,
    this.calendarTitle,
    this.cancelText,
    this.confirmText,
    this.fieldLabelText,
    this.fieldHintText,
    this.errorFormatText,
    this.errorInvalidText,
    this.initialEntryMode,
    this.initialDatePickerMode,
    this.selectableDayPredicate,
    this.textDirection,
    this.locale,
    this.useRootNavigator,
    this.routeSettings,
    this.use24HourFormat = true,
    this.timeFieldWidth,
    String initialValue,
    FocusNode focusNode,
    InputDecoration decoration,
    //TextInputType keyboardType,
    TextCapitalization textCapitalization = TextCapitalization.none,
    TextInputAction textInputAction,
    TextStyle style,
    StrutStyle strutStyle,
    TextAlign textAlign = TextAlign.start,
    TextAlignVertical textAlignVertical,
    bool autofocus = false,
    bool readOnly = false,
    ToolbarOptions toolbarOptions,
    bool showCursor,
    bool obscureText = false,
    bool autocorrect = true,
    SmartDashesType smartDashesType,
    SmartQuotesType smartQuotesType,
    bool enableSuggestions = true,
    bool autovalidate = false,
    bool maxLengthEnforced = true,
    int maxLines = 1,
    int minLines,
    bool expands = false,
    int maxLength,
    this.onChanged,
    VoidCallback onEditingComplete,
    ValueChanged<String> onFieldSubmitted,
    FormFieldSetter<String> onSaved,
    FormFieldValidator<String> validator,
    List<TextInputFormatter> inputFormatters,
    bool enabled = true,
    double cursorWidth = 2.0,
    Radius cursorRadius,
    Color cursorColor,
    Brightness keyboardAppearance,
    EdgeInsets scrollPadding = const EdgeInsets.all(20.0),
    bool enableInteractiveSelection = true,
    InputCounterWidgetBuilder buildCounter,
    ScrollPhysics scrollPhysics,
  })  : assert(initialValue == null || controller == null),
        assert(type == DateTimePickerType.time || firstDate != null),
        assert(type == DateTimePickerType.time || lastDate != null),
        assert(textAlign != null),
        assert(autofocus != null),
        assert(readOnly != null),
        assert(obscureText != null),
        assert(autocorrect != null),
        assert(enableSuggestions != null),
        assert(autovalidate != null),
        assert(maxLengthEnforced != null),
        assert(scrollPadding != null),
        assert(maxLines == null || maxLines > 0),
        assert(minLines == null || minLines > 0),
        assert(
          (maxLines == null) || (minLines == null) || (maxLines >= minLines),
          "minLines can't be greater than maxLines",
        ),
        assert(expands != null),
        assert(
          !expands || (maxLines == null && minLines == null),
          'minLines and maxLines must be null when expands is true.',
        ),
        assert(
          !obscureText || maxLines == 1,
          'Obscured fields cannot be multiline.',
        ),
        assert(maxLength == null || maxLength > 0),
        assert(enableInteractiveSelection != null),
        super(
          key: key,
          initialValue:
              controller != null ? controller.text : (initialValue ?? ''),
          onSaved: onSaved,
          validator: validator,
          //autovalidate: autovalidate,
          enabled: enabled,
          builder: (FormFieldState<String> field) {
            final _DateTimePickerState state = field as _DateTimePickerState;

            void onChangedHandler(String value) {
              if (onChanged != null) {
                onChanged(value);
              }
              field.didChange(value);
            }

            Widget buildField(DateTimePickerType peType) {
              Function lfOnTap;
              TextEditingController loCtrl;
              InputDecoration loDecoration;

              switch (peType) {
                case DateTimePickerType.time:
                  lfOnTap = state._showTimePickerDialog;
                  loCtrl = state._timeLabelController;
                  loDecoration = InputDecoration(
                    labelText: timeLabelText,
                    icon: icon,
                    hintText: timeHintText,
                  );

                  if (type == DateTimePickerType.dateTimeSeparate) {
                    loDecoration = InputDecoration(
                      labelText: timeLabelText,
                      hintText: timeHintText,
                    );
                  }
                  break;
                case DateTimePickerType.dateTime:
                  lfOnTap = state._showDateTimePickerDialog;
                  loCtrl = state._dateLabelController;
                  loDecoration = InputDecoration(
                    labelText: dateLabelText,
                    icon: icon,
                    hintText: dateHintText,
                  );
                  break;
                default:
                  lfOnTap = state._showDatePickerDialog;
                  loCtrl = state._dateLabelController;
                  loDecoration = InputDecoration(
                    labelText: dateLabelText,
                    icon: icon,
                    hintText: dateHintText,
                  );
              }

              loDecoration = (decoration ?? loDecoration);
              loDecoration.applyDefaults(
                Theme.of(field.context).inputDecorationTheme,
              );

              return TextField(
                readOnly: true,
                onTap: readOnly ? null : lfOnTap,
                controller: loCtrl,
                decoration: loDecoration.copyWith(
                  errorText: field.errorText,
                ),
                focusNode: focusNode,
                keyboardType: TextInputType.datetime,
                textInputAction: textInputAction,
                style: style,
                strutStyle: strutStyle,
                textAlign: textAlign,
                textAlignVertical: textAlignVertical,
                //textDirection: textDirection,
                textCapitalization: textCapitalization,
                autofocus: autofocus,
                toolbarOptions: toolbarOptions,
                showCursor: showCursor,
                obscureText: obscureText,
                autocorrect: autocorrect,
                smartDashesType: smartDashesType ??
                    (obscureText
                        ? SmartDashesType.disabled
                        : SmartDashesType.enabled),
                smartQuotesType: smartQuotesType ??
                    (obscureText
                        ? SmartQuotesType.disabled
                        : SmartQuotesType.enabled),
                enableSuggestions: enableSuggestions,
                maxLengthEnforced: maxLengthEnforced,
                maxLines: maxLines,
                minLines: minLines,
                expands: expands,
                maxLength: maxLength,
                onChanged: onChangedHandler,
                onEditingComplete: onEditingComplete,
                onSubmitted: onFieldSubmitted,
                inputFormatters: inputFormatters,
                enabled: enabled,
                cursorWidth: cursorWidth,
                cursorRadius: cursorRadius,
                cursorColor: cursorColor,
                scrollPadding: scrollPadding,
                scrollPhysics: scrollPhysics,
                keyboardAppearance: keyboardAppearance,
                enableInteractiveSelection: enableInteractiveSelection,
                buildCounter: buildCounter,
              );
            }

            switch (type) {
              case DateTimePickerType.time:
                return buildField(DateTimePickerType.time);
                break;
              case DateTimePickerType.dateTime:
                return buildField(DateTimePickerType.dateTime);
                break;
              case DateTimePickerType.dateTimeSeparate:
                return Row(children: <Widget>[
                  Expanded(child: buildField(DateTimePickerType.date)),
                  SizedBox(width: 15),
                  SizedBox(
                    width: timeFieldWidth ?? 100,
                    child: buildField(DateTimePickerType.time),
                  )
                ]);
                break;
              default:
                return buildField(DateTimePickerType.date);
            }
          },
        );

  /// The DateTimePicker type:
  /// [date], [time], [dateTime] or [dateTimeSeparate].
  final DateTimePickerType type;

  /// Controls the text being edited.
  ///
  /// If null, this widget will create its own [TextEditingController] and
  /// initialize its [TextEditingController.text] with [initialValue].
  /// The value need to be a DateTime String or null
  final TextEditingController controller;

  /// The earliest allowable [DateTime] that the user can select.
  final DateTime firstDate;

  /// The latest allowable [DateTime] that the user can select.
  final DateTime lastDate;

  /// For forms that match one of our predefined skeletons, we look up the
  /// corresponding pattern in [locale] (or in the default locale if none is
  /// specified) and use the resulting full format string. This is the
  /// preferred usage, but if [newPattern] does not match one of the skeletons,
  /// then it is used as a format directly, but will not be adapted to suit the
  /// locale.
  final String dateMask;

  /// An icon to show before the input field and outside of the decoration's
  /// container.
  ///
  /// The size and color of the icon is configured automatically using an
  /// [IconTheme] and therefore does not need to be explicitly given in the
  /// icon widget.
  ///
  /// The trailing edge of the icon is padded by 16dps.
  ///
  /// The decoration's container is the area which is filled if [filled] is
  /// true and bordered per the [border]. It's the area adjacent to
  /// [decoration.icon] and above the widgets that contain [helperText],
  /// [errorText], and [counterText].
  ///
  /// See [Icon], [ImageIcon].
  final Widget icon;

  /// Text that describes the date input field.
  ///
  /// When the date input field is empty and unfocused, the label is displayed on
  /// top of the input field (i.e., at the same location on the screen where
  /// text may be entered in the input field). When the input field receives
  /// focus (or if the field is non-empty), the label moves above (i.e.,
  /// vertically adjacent to) the input field.
  final String dateLabelText;

  /// Text that describes the time input field.
  ///
  /// When the time input field is empty and unfocused, the label is displayed on
  /// top of the input field (i.e., at the same location on the screen where
  /// text may be entered in the input field). When the input field receives
  /// focus (or if the field is non-empty), the label moves above (i.e.,
  /// vertically adjacent to) the input field.
  final String timeLabelText;

  /// Text that suggests what sort of date input the field accepts.
  ///
  /// Displayed on top of the date input [child] (i.e., at the same location on the
  /// screen where text may be entered in the input [child]) when the input
  /// [isEmpty] and either (a) [labelText] is null or (b) the input has the focus.
  final String dateHintText;

  /// Text that suggests what sort of time input the field accepts.
  ///
  /// Displayed on top of the time input [child] (i.e., at the same location on the
  /// screen where text may be entered in the input [child]) when the input
  /// [isEmpty] and either (a) [labelText] is null or (b) the input has the focus.
  final String timeHintText;

  /// Optional strings for the [cancelText] to override the default text.
  final String calendarTitle;

  /// Optional strings for the [cancelText] to override the default text.
  final String cancelText;

  /// Optional strings for the [confirmText] to override the default text.
  final String confirmText;

  /// Optional strings for the [fieldLabelText] to override the default text.
  final String fieldLabelText;

  /// Optional strings for the [fieldHintText] to override the default text.
  final String fieldHintText;

  /// Optional strings for the [errorFormatText] to override the default text.
  final String errorFormatText;

  /// Optional strings for the [errorInvalidText] to override the default text.
  final String errorInvalidText;

  /// An optional [textDirection] argument can be used to set the text direction
  /// ([TextDirection.ltr] or [TextDirection.rtl]) for the date picker. It
  /// defaults to the ambient text direction provided by [Directionality]. If both
  /// [locale] and [textDirection] are non-null, [textDirection] overrides the
  /// direction chosen for the [locale].
  final TextDirection textDirection;

  /// An optional [locale] argument can be used to set the locale for the date
  /// picker. It defaults to the ambient locale provided by [Localizations].
  final Locale locale;

  /// The [context], [useRootNavigator] and [routeSettings] arguments are passed to
  /// [showDialog], the documentation for which discusses how it is used. [context]
  /// and [useRootNavigator] must be non-null.
  final bool useRootNavigator;

  /// Creates data used to construct routes.
  final RouteSettings routeSettings;

  /// An optional [initialEntryMode] argument can be used to display the date
  /// picker in the [DatePickerEntryMode.calendar] (a calendar month grid)
  /// or [DatePickerEntryMode.input] (a text input field) mode.
  /// It defaults to [DatePickerEntryMode.calendar] and must be non-null.
  final DatePickerEntryMode initialEntryMode;

  /// An optional [initialDatePickerMode] argument can be used to have the
  /// calendar date picker initially appear in the [DatePickerMode.year] or
  /// [DatePickerMode.day] mode. It defaults to [DatePickerMode.day], and
  /// must be non-null.
  final DatePickerMode initialDatePickerMode;

  /// An optional [selectableDayPredicate] function can be passed in to only allow
  /// certain days for selection. If provided, only the days that
  /// [selectableDayPredicate] returns true for will be selectable. For example,
  /// this can be used to only allow weekdays for selection. If provided, it must
  /// return true for [initialDate].
  final bool Function(DateTime) selectableDayPredicate;

  /// Show a dialog with time unconditionally displayed in 24 hour format.
  final bool use24HourFormat;

  /// The width for time text field when DateTimePickerType is dateTimeSeparated.
  final double timeFieldWidth;

  final ValueChanged<String> onChanged;

  @override
  _DateTimePickerState createState() => _DateTimePickerState();
}

class _DateTimePickerState extends FormFieldState<String> {
  TextEditingController _stateController;
  TextEditingController _dateLabelController = TextEditingController();
  TextEditingController _timeLabelController = TextEditingController();
  DateTime _dDate = DateTime.now();
  TimeOfDay _tTime = TimeOfDay.now();
  String _sValue;
  String _sDate = '';
  String _sTime = '';
  String _sPeriod = '';
  String _sLanguageCode;

  @override
  DateTimePicker get widget => super.widget as DateTimePicker;

  TextEditingController get _effectiveController =>
      widget.controller ?? _stateController;

  @override
  void initState() {
    super.initState();

    if (widget.controller == null) {
      _stateController = TextEditingController(text: widget.initialValue);
    } else {
      widget.controller.addListener(_handleControllerChanged);
    }

    String lsValue = _effectiveController.text.trim();

    if (widget.locale != null) {
      _sLanguageCode = widget.locale.languageCode;
    }

    if (lsValue != null && lsValue != '' && lsValue != 'null') {
      if (widget.type != DateTimePickerType.time) {
        _dDate = DateTime.tryParse(lsValue);
        _tTime = TimeOfDay.fromDateTime(_dDate);

        _sDate = DateFormat('yyyy-MM-dd', _sLanguageCode).format(_dDate);
        _sTime = DateFormat('HH:mm', _sLanguageCode).format(_dDate);

        if (!widget.use24HourFormat) {
          _sTime = DateFormat('hh:mm a', _sLanguageCode).format(_dDate);
        }

        _timeLabelController.text = _sTime;
        _dateLabelController.text = _sDate;

        if (widget.dateMask != null && widget.dateMask != '') {
          _dateLabelController.text =
              DateFormat(widget.dateMask, _sLanguageCode).format(_dDate);
        } else {
          String lsMask = 'MMM d, yyyy';

          if (widget.type == DateTimePickerType.dateTime && _sTime != '') {
            lsMask = 'MMM d, yyyy - HH:mm';

            if (!widget.use24HourFormat) {
              lsMask = 'MMM d, yyyy - hh:mm a';
            }
          }

          _dateLabelController.text =
              DateFormat(lsMask, _sLanguageCode).format(_dDate);
        }
      } else {
        List<String> llTime = lsValue.split(':');
        _tTime =
            TimeOfDay(hour: int.parse(llTime[0]), minute: int.parse(llTime[1]));
        _sTime = lsValue;

        if (!widget.use24HourFormat) {
          _sPeriod = _tTime.period.index == 0 ? ' AM' : ' PM';
        }

        _timeLabelController.text = _sTime + _sPeriod;
      }
    }
  }

  @override
  void didUpdateWidget(DateTimePicker oldWidget) {
    super.didUpdateWidget(oldWidget);

    if (widget.controller != oldWidget.controller) {
      oldWidget.controller?.removeListener(_handleControllerChanged);
      widget.controller?.addListener(_handleControllerChanged);

      if (oldWidget.controller != null && widget.controller == null) {
        _stateController =
            TextEditingController.fromValue(oldWidget.controller.value);
      }

      if (widget.controller != null) {
        setValue(widget.controller.text);

        if (oldWidget.controller == null) {
          _stateController = null;
        }
      }
    }

    if (_effectiveController.text != null && _effectiveController.text != '') {
      String lsValue = _effectiveController.text.trim();

      if (lsValue != null && lsValue != '' && lsValue != 'null') {
        if (widget.type != DateTimePickerType.time) {
          String lsOldDate = _sDate;
          String lsOldTime = _sTime;
          _dDate = DateTime.tryParse(lsValue);

          if (_dDate != null) {
            _sDate = DateFormat('yyyy-MM-dd', _sLanguageCode).format(_dDate);

            if (lsOldTime != '') {
              _tTime = TimeOfDay.fromDateTime(_dDate);
              _sTime = DateFormat('HH:mm', _sLanguageCode).format(_dDate);

              if (!widget.use24HourFormat) {
                _sTime = DateFormat('hh:mm a', _sLanguageCode).format(_dDate);
              }
            }
          }

          _dateLabelController.text = lsOldDate != '' ? _sDate : '';
          _timeLabelController.text = lsOldTime != '' ? _sTime : '';

          if (_dDate != null) {
            if (widget.dateMask != null && widget.dateMask != '') {
              _dateLabelController.text =
                  DateFormat(widget.dateMask, _sLanguageCode).format(_dDate);
            } else {
              String lsMask = 'MMM d, yyyy';

              if (widget.type == DateTimePickerType.dateTime && _sTime != '') {
                lsMask = 'MMM d, yyyy - HH:mm';

                if (!widget.use24HourFormat) {
                  lsMask = 'MMM d, yyyy - hh:mm a';
                }
              }

              _dateLabelController.text =
                  DateFormat(lsMask, _sLanguageCode).format(_dDate);
            }
          }
        } else {
          List<String> llTime = lsValue.split(':');
          _tTime = TimeOfDay(
              hour: int.parse(llTime[0]), minute: int.parse(llTime[1]));
          _sTime = lsValue;
          _timeLabelController.text = _sTime + _sPeriod;
        }
      }
    }
  }

  @override
  void dispose() {
    widget.controller?.removeListener(_handleControllerChanged);

    super.dispose();
  }

  @override
  void reset() {
    super.reset();

    setState(() {
      _effectiveController.text = widget.initialValue;
    });
  }

  void _handleControllerChanged() {
    if (_effectiveController.text != value) {
      didChange(_effectiveController.text);
    }
  }

  void onChangedHandler(String value) {
    if (widget.onChanged != null) {
      widget.onChanged(value);
    }

    didChange(value);
  }

  Future<void> _showDatePickerDialog() async {
    DateTime ldDatePicked = await showDatePicker(
      context: context,
      initialDate: _dDate ?? DateTime.now(),
      firstDate: widget.firstDate,
      lastDate: widget.lastDate,
      helpText: widget.calendarTitle,
      cancelText: widget.cancelText,
      confirmText: widget.confirmText,
      initialDatePickerMode: widget.initialDatePickerMode ?? DatePickerMode.day,
      initialEntryMode: widget.initialEntryMode ?? DatePickerEntryMode.calendar,
      selectableDayPredicate: widget.selectableDayPredicate,
      fieldLabelText: widget.fieldLabelText,
      fieldHintText: widget.fieldHintText,
      errorFormatText: widget.errorFormatText,
      errorInvalidText: widget.errorInvalidText,
      //textDirection: widget.textDirection,
      locale: widget.locale,
      useRootNavigator: widget.useRootNavigator ?? false,
      routeSettings: widget.routeSettings,
    );

    if (ldDatePicked != null) {
      _sDate = DateFormat('yyyy-MM-dd', _sLanguageCode).format(ldDatePicked);
      _dDate = ldDatePicked;
      String lsOldValue = _sValue;
      _sValue = _sDate;
      String lsFormatedDate;

      if (widget.dateMask != null && widget.dateMask != '') {
        lsFormatedDate = DateFormat(widget.dateMask, _sLanguageCode)
            .format(DateTime.tryParse(_sDate));
      } else {
        lsFormatedDate = DateFormat('MMM dd, yyyy', _sLanguageCode)
            .format(DateTime.tryParse(_sDate));
      }

      if (widget.type == DateTimePickerType.dateTimeSeparate && _sTime != '') {
        _sValue = '$_sDate $_sTime';
      }

      _sValue = _sValue.trim();
      _dateLabelController.text = lsFormatedDate;
      _effectiveController.text = _sValue;

      if (_sValue != lsOldValue) {
        onChangedHandler(_sValue);
      }
    }
  }

  Future<void> _showTimePickerDialog() async {
    TimeOfDay ltTimePicked = await showTimePicker(
      context: context,
      initialTime: _tTime ?? TimeOfDay.now(),
      useRootNavigator: widget.useRootNavigator ?? false,
      routeSettings: widget.routeSettings,
      builder: (BuildContext context, Widget child) {
        return MediaQuery(
          data: MediaQuery.of(context)
              .copyWith(alwaysUse24HourFormat: widget.use24HourFormat),
          child: child,
        );
      },
    );

    if (ltTimePicked != null) {
      String lsHour = ltTimePicked.hour.toString().padLeft(2, '0');
      String lsMinute = ltTimePicked.minute.toString().padLeft(2, '0');

      if (ltTimePicked.period.index == 0 && lsHour == '12') {
        lsHour = '00';
      }

      if (!widget.use24HourFormat) {
        _sPeriod = ltTimePicked.period.index == 0 ? ' AM' : ' PM';
      }

      _sTime = '$lsHour:$lsMinute';
      _tTime = ltTimePicked;

      _timeLabelController.text = _sTime;
      String lsOldValue = _sValue;
      _sValue = _sTime;

      if (widget.type == DateTimePickerType.dateTimeSeparate && _sDate != '') {
        _sValue = '$_sDate $_sTime';
      }

      _sValue = _sValue.trim();
      _effectiveController.text = _sValue;

      if (_sValue != lsOldValue) {
        onChangedHandler(_sValue);
      }
    }
  }

  Future<void> _showDateTimePickerDialog() async {
    String lsFormatedDate;

    DateTime ldDatePicked = await showDatePicker(
      context: context,
      initialDate: _dDate ?? DateTime.now(),
      firstDate: widget.firstDate,
      lastDate: widget.lastDate,
      helpText: widget.calendarTitle,
      cancelText: widget.cancelText,
      confirmText: widget.confirmText,
      initialDatePickerMode: widget.initialDatePickerMode ?? DatePickerMode.day,
      initialEntryMode: widget.initialEntryMode ?? DatePickerEntryMode.calendar,
      selectableDayPredicate: widget.selectableDayPredicate,
      fieldLabelText: widget.fieldLabelText,
      fieldHintText: widget.fieldHintText,
      errorFormatText: widget.errorFormatText,
      errorInvalidText: widget.errorInvalidText,
      //textDirection: widget.textDirection,
      locale: widget.locale,
      useRootNavigator: widget.useRootNavigator ?? false,
      routeSettings: widget.routeSettings,
    );

    if (ldDatePicked != null) {
      _sDate = DateFormat('yyyy-MM-dd', _sLanguageCode).format(ldDatePicked);
      _dDate = ldDatePicked;

      TimeOfDay ltTimePicked = await showTimePicker(
        context: context,
        initialTime: _tTime ?? TimeOfDay.now(),
        useRootNavigator: widget.useRootNavigator ?? false,
        routeSettings: widget.routeSettings,
        builder: (BuildContext context, Widget child) {
          return MediaQuery(
            data: MediaQuery.of(context)
                .copyWith(alwaysUse24HourFormat: widget.use24HourFormat),
            child: child,
          );
        },
      );

      if (ltTimePicked != null) {
        String lsHour = ltTimePicked.hour.toString().padLeft(2, '0');
        String lsMinute = ltTimePicked.minute.toString().padLeft(2, '0');

        if (ltTimePicked.period.index == 0 && lsHour == '12') {
          lsHour = '00';
        }

        if (!widget.use24HourFormat) {
          _sPeriod = ltTimePicked.period.index == 0 ? ' AM' : ' PM';
        }

        _sTime = '$lsHour:$lsMinute';
        _tTime = ltTimePicked;
      } else {
        String lsHour = _tTime.hour.toString().padLeft(2, '0');
        String lsMinute = _tTime.minute.toString().padLeft(2, '0');

        if (_tTime.period.index == 0 && lsHour == '12') {
          lsHour = '00';
        }

        if (!widget.use24HourFormat) {
          _sPeriod = _tTime.period.index == 0 ? ' AM' : ' PM';
        }

        _sTime = '$lsHour:$lsMinute';
      }

      String lsOldValue = _sValue;
      _sValue = '$_sDate $_sTime';
      _sValue = _sValue.trim();

      if (widget.dateMask != null && widget.dateMask != '') {
        lsFormatedDate =
            DateFormat(widget.dateMask).format(DateTime.tryParse(_sValue));
      } else {
        String lsMask = _sTime != '' ? 'MMM dd, yyyy - HH:mm' : 'MMM dd, yyyy';
        lsFormatedDate = DateFormat(lsMask, _sLanguageCode)
            .format(DateTime.tryParse(_sValue));
      }

      _dateLabelController.text = lsFormatedDate;
      _effectiveController.text = _sValue;

      if (_sValue != lsOldValue) {
        onChangedHandler(_sValue);
      }
    }
  }
}
