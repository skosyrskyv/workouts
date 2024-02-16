import 'package:dart_date/dart_date.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:workouts/extensions/iterable_extension.dart';
import 'package:workouts/core/widgets/spacers.dart';

const double _monthLabelHeight = 40;
const double _dayCellSized = 50;
const double _weekSpacing = 4;

class Calendar extends StatefulWidget {
  final double topPadding;
  final Function(DateTime date) onDayTap;
  final bool scrollEnabled;
  final bool showHiddenDays;
  final List<CalendarEvent> events;
  const Calendar({
    super.key,
    required this.topPadding,
    required this.onDayTap,
    required this.scrollEnabled,
    required this.showHiddenDays,
    required this.events,
  });

  @override
  State<Calendar> createState() => _CalendarState();
}

class _CalendarState extends State<Calendar> {
  late final ScrollController _scrollController;
  DateTime selectedDate = DateTime.now();
  List<_MonthModel> _months = [];

  double todayOffset = 0;

  scrollTo(int monthIndex, int weekIndex) {
    _scrollController.animateTo(
      calculateOffset(monthIndex, weekIndex),
      duration: const Duration(milliseconds: 1000),
      curve: Curves.ease,
    );
  }

  List<_MonthModel> generateMonths(DateTime start, DateTime finish) {
    final today = DateTime.now();
    final diff = start.differenceInDays(finish).abs();
    final days = List.generate(diff, (index) => start.add(Duration(days: index)));

    int todayMontIndex = 0;
    int todayWeekIndex = 0;

    List<DateTime> week = [];
    List<_WeekModel> weeks = [];
    List<_MonthModel> months = [];

    int monthIndex = 0;
    int weekIndex = 0;

    days.mapWithIndex((day, index) {
      final next = index == days.length - 1 ? day : days[index + 1];
      week.add(day);

      if (day.isToday) {
        todayOffset = calculateOffset(todayMontIndex, todayWeekIndex);
      }

      if (next.month != day.month) {
        if (day.isBefore(today)) {
          todayMontIndex++;
          todayWeekIndex++;
        }
        weeks.add(_WeekModel(index: weekIndex, number: day.getWeek, days: feelWeek(week.toList())));
        months.add(_MonthModel(index: monthIndex, number: day.month, year: day.year, weeks: weeks.toList()));
        week.clear();
        weeks.clear();
        weekIndex++;
        monthIndex++;
        return;
      }

      if (day.getWeekday == 7) {
        if (day.isBefore(today)) {
          todayWeekIndex++;
        }
        weeks.add(_WeekModel(index: weekIndex, number: day.getWeek, days: feelWeek(week.toList())));
        week.clear();
        weekIndex++;
      }
    }).toList();

    return months;
  }

  double calculateOffset(int monthIndex, int weekIndex) {
    return ((_monthLabelHeight * (monthIndex + 1)) + ((_dayCellSized + 2 * _weekSpacing) * (weekIndex)));
  }

  List<DateTime> feelWeek(List<DateTime> week) {
    if (week.length == 7 || week.isEmpty) return week;
    if (week.first.day <= 15) {
      final days = List<DateTime>.generate(7 - week.length, (index) => week.first.subtract(Duration(days: index + 1)));
      return [...days.reversed, ...week];
    } else {
      final days = List<DateTime>.generate(7 - week.length, (index) => week.last.add(Duration(days: index + 1)));
      return [...week, ...days];
    }
  }

  @override
  void initState() {
    final start = DateTime(DateTime.now().year, DateTime.now().month).subMonths(20);
    final finish = DateTime(DateTime.now().year, DateTime.now().month).addMonths(20);
    _months = generateMonths(start, finish);
    _scrollController = ScrollController(initialScrollOffset: todayOffset);
    super.initState();
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return _CalendarStateProvider(
      events: widget.events,
      selectedDate: selectedDate,
      showHidden: widget.showHiddenDays,
      child: ListView(
        controller: _scrollController,
        physics: widget.scrollEnabled ? const AlwaysScrollableScrollPhysics() : const NeverScrollableScrollPhysics(),
        children: [
          ..._months.mapWithIndex(
            (month, index) {
              return _Month(
                month: month,
                onDayTap: (date, monthIndex, weekIndex) {
                  scrollTo(monthIndex, weekIndex);
                  widget.onDayTap(date);
                  setState(() {
                    selectedDate = date;
                  });
                },
              );
            },
          ).toList(),
          if (!widget.scrollEnabled) VerticalSpacer(MediaQuery.of(context).size.height),
          const VerticalSpacer(100)
        ],
      ),
    );
  }
}

//
// MONTH
//
class _Month extends StatelessWidget {
  final _MonthModel month;
  final void Function(DateTime date, int monthIndex, int weekIndex) onDayTap;

  const _Month({
    required this.month,
    required this.onDayTap,
  });

  void _onDayTap(DateTime date, int weekIndex) {
    onDayTap(date, month.index, weekIndex);
  }

  Widget _buildMonthName() {
    final someDay = DateTime(month.year, month.number);

    return Container(
      height: _monthLabelHeight,
      padding: const EdgeInsets.only(left: 20),
      alignment: Alignment.bottomLeft,
      child: Text(
        DateFormat('MMMM ${month.number == 1 ? 'yyyy' : ''}').format(
          DateTime(someDay.year, someDay.month),
        ),
        style: const TextStyle(
          fontSize: 20,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _buildMonthName(),
        ...month.weeks
            .mapWithIndex(
              (week, index) => _Week(
                week: week,
                month: month.number,
                onDayTap: _onDayTap,
              ),
            )
            .toList(),
      ],
    );
  }
}

//
// WEEK
//
class _Week extends StatelessWidget {
  final _WeekModel week;
  final int month;
  final void Function(DateTime date, int index) onDayTap;
  const _Week({
    required this.week,
    required this.month,
    required this.onDayTap,
  });

  void _onDateTap(DateTime date) {
    onDayTap(date, week.index);
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: _weekSpacing),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: week.days
            .mapWithIndex((day, index) => _Day(
                  index: index,
                  date: day,
                  hasEvent: _CalendarStateProvider.of(context)!.events.any((event) => event.date.isSameDay(day)),
                  showDay: month == day.month || _CalendarStateProvider.of(context)!.showHidden,
                  selected: day.isSameDay(_CalendarStateProvider.of(context)!.selectedDate),
                  onTap: _onDateTap,
                ))
            .toList(),
      ),
    );
  }
}

//
// DAY
//
class _Day extends StatelessWidget {
  final int index;
  final DateTime date;
  final bool selected;
  final bool hasEvent;
  final bool showDay;
  final Function(DateTime date) onTap;

  const _Day({
    required this.index,
    required this.date,
    required this.selected,
    required this.hasEvent,
    required this.showDay,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    _CalendarStateProvider.of(context)!.events.any((element) => element.date.isSameDay(date));
    return AnimatedOpacity(
      duration: Duration(milliseconds: 150 * index + 1),
      opacity: showDay ? 1 : 0,
      child: InkWell(
        onTap: showDay ? () => onTap(date) : null,
        borderRadius: BorderRadius.circular(_dayCellSized / 2),
        child: Container(
          height: _dayCellSized,
          width: _dayCellSized,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            border: selected
                ? Border.all(
                    color: Theme.of(context).colorScheme.primary,
                  )
                : null,
            shape: BoxShape.circle,
            color: Theme.of(context).colorScheme.primary.withOpacity(DateTime.now().isSameDay(date) ? .3 : .05),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(DateFormat('d').format(date)),
              if (hasEvent)
                Icon(
                  Icons.circle,
                  size: 10,
                  color: Theme.of(context).colorScheme.primary,
                )
            ],
          ),
        ),
      ),
    );
  }
}

class _CalendarStateProvider extends InheritedWidget {
  final List<CalendarEvent> events;
  final DateTime selectedDate;
  final bool showHidden;
  const _CalendarStateProvider({
    required this.events,
    required this.selectedDate,
    required this.showHidden,
    required Widget child,
  }) : super(child: child);

  @override
  bool updateShouldNotify(covariant InheritedWidget oldWidget) {
    return oldWidget != this;
  }

  static _CalendarStateProvider? of(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<_CalendarStateProvider>();
  }
}

class _MonthModel {
  /// Total index of month
  final int index;

  /// Month number [1..12] 12 - December
  final int number;

  /// Year
  final int year;

  /// Weeks of the month
  final List<_WeekModel> weeks;

  _MonthModel({
    required this.index,
    required this.number,
    required this.year,
    required this.weeks,
  });
}

class _WeekModel {
  /// Total index of week
  final int index;

  /// Number inside month;
  final int number;

  /// Dates of the week
  final List<DateTime> days;

  const _WeekModel({
    required this.index,
    required this.number,
    required this.days,
  });
}

class CalendarEvent {
  final DateTime date;
  CalendarEvent({required this.date});
}
