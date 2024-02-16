import 'package:auto_route/auto_route.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:workouts/app/database/database.dart';
import 'package:workouts/app/runner.dart';
import 'package:workouts/core/widgets/styled_text.dart';
import 'package:workouts/features/workouts/widgets/calendar.dart';
import 'package:workouts/features/workouts/widgets/workouts_list.dart';
import 'package:workouts/core/widgets/spacers.dart';

@RoutePage()
class WorkoutsScreen extends StatefulWidget {
  const WorkoutsScreen({super.key});

  @override
  State<WorkoutsScreen> createState() => _WorkoutsScreenState();
}

class _WorkoutsScreenState extends State<WorkoutsScreen> {
  late AppDatabase db;
  bool sheetOpened = true;
  DateTime selectedDate = DateTime.now();
  List<CalendarEvent> _events = [];

  @override
  void initState() {
    db = getIt.get();
    db.watchAllWorkouts().listen((events) {
      if (mounted) {
        setState(() {
          _events = events.map((e) => CalendarEvent(date: e.created)).toList();
        });
      }
    });
    super.initState();
  }

  void openSheet(BuildContext context, DateTime date) {
    setSelectedDate(date);
    setSheetOpened(true);
  }

  void closeSheet() {
    setSheetOpened(false);
  }

  setSelectedDate(DateTime value) {
    if (value == selectedDate) return;
    selectedDate = value;
    setState(() {});
  }

  setSheetOpened(bool value) {
    if (value == sheetOpened) return;
    sheetOpened = value;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final screenHight = MediaQuery.of(context).size.height;
    final minOffset = MediaQuery.of(context).padding.top + 50 + 12;
    final maxOffset = screenHight - MediaQuery.of(context).padding.bottom - 100;

    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      body: Stack(
        children: [
          Positioned.fill(
            child: Calendar(
              scrollEnabled: !sheetOpened,
              showHiddenDays: sheetOpened,
              events: _events,
              onDayTap: (date) => openSheet(context, date),
              topPadding: MediaQuery.of(context).padding.top,
            ),
          ),
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: AnimatedOpacity(
              opacity: sheetOpened ? 1 : 0,
              duration: const Duration(milliseconds: 300),
              child: Container(
                height: MediaQuery.of(context).padding.top,
                color: Theme.of(context).colorScheme.surface,
              ),
            ),
          ),
          AnimatedPositioned(
            left: 0,
            right: 0,
            top: sheetOpened ? minOffset : maxOffset,
            bottom: 0,
            curve: Curves.ease,
            duration: const Duration(seconds: 1),
            child: Container(
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.surface,
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(30),
                  topRight: Radius.circular(30),
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: StyledText(
                            DateFormat('EEEE, d MMMM').format(selectedDate),
                            style: TypographyStyle.headlineSmall,
                            bold: true,
                          ),
                        ),
                        IconButton(
                          onPressed: sheetOpened ? closeSheet : null,
                          icon: Icon(
                            Icons.calendar_month,
                            color: sheetOpened ? Theme.of(context).colorScheme.primary : Theme.of(context).colorScheme.onSurface.withOpacity(.2),
                          ),
                        )
                      ],
                    ),
                    Expanded(
                      child: ListView(
                        padding: EdgeInsets.zero,
                        physics: const ClampingScrollPhysics(),
                        children: [
                          VerticalSpacer.h20(),
                          WorkoutsList(
                            date: selectedDate,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
