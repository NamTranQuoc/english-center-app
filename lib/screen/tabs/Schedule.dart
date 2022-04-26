import 'package:english_center/domain/Schedule.dart';
import 'package:english_center/screen/tabs/schedules/DetalSchedule.dart';
import 'package:english_center/services/ScheduleService.dart';
import 'package:english_center/util/ParseUtil.dart';
import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';

import '../../util/Utils.dart';

class ScheduleScreen extends StatefulWidget {
  static const routeName = '/schedule';

  @override
  _ScheduleScreen createState() => _ScheduleScreen();
}

class _ScheduleScreen extends State<ScheduleScreen> {
  late final ValueNotifier<List<Event>> _selectedEvents;
  CalendarFormat _calendarFormat = CalendarFormat.month;
  RangeSelectionMode _rangeSelectionMode = RangeSelectionMode.toggledOff;
  DateTime _focusedDay = DateTime.now();
  DateTime? _selectedDay;
  DateTime? _rangeStart;
  DateTime? _rangeEnd;
  late final ValueNotifier<List<Schedule>> _schedules;
  Map<String, List<Schedule>> schedules = <String, List<Schedule>>{};

  @override
  void initState() {
    super.initState();

    _selectedDay = _focusedDay;
    _schedules = ValueNotifier(_getEventsForDay(_selectedDay!));
    gets(DateTime.now());
  }

  void gets(DateTime dateTime) {
    print('a: ${dateTime}');
    schedules = <String, List<Schedule>>{};
    DateTime start;
    DateTime end;
    if (_calendarFormat == CalendarFormat.month) {
      DateTime _start = DateTime(dateTime.year, dateTime.month, 1);
      DateTime _end = DateTime(dateTime.year, dateTime.month + 1, 0);
      start =
          DateTime(_start.year, _start.month, _start.day - _start.weekday + 1);
      end = DateTime(_end.year, _end.month, _end.day + (7 - _end.weekday));
    } else if (_calendarFormat == CalendarFormat.week) {
      start = DateTime(
          dateTime.year, dateTime.month, dateTime.day - dateTime.weekday + 1);
      end = DateTime(
          dateTime.year, dateTime.month, dateTime.day + (7 - dateTime.weekday));
    } else {
      start = DateTime(dateTime.year, dateTime.month, dateTime.day - 14);
      end = DateTime(dateTime.year, dateTime.month, dateTime.day + 14);
    }
    getSchedule(start, end).then((value) {
      if (value.code == 9999) {
        List<Map<String, dynamic>> list = List.from(value.payload);
        for (var element in list) {
          Schedule schedule = Schedule.fromJson(element);
          DateTime datetime =
              DateTime.fromMillisecondsSinceEpoch(schedule.start!);
          String key = '${datetime.year}-${datetime.month}-${datetime.day}';
          List<Schedule> a = schedules[key] ?? [];
          a.add(schedule);
          schedules.putIfAbsent(key, () => a);
          setState(() {});
        }
      }
    });
  }

  @override
  void dispose() {
    _schedules.dispose();
    super.dispose();
  }

  List<Schedule> _getEventsForDay(DateTime day) {
    // Implementation example

    return schedules['${day.year}-${day.month}-${day.day}'] ?? [];
  }

  List<Schedule> _getEventsForRange(DateTime start, DateTime end) {
    // Implementation example
    final days = daysInRange(start, end);

    return [
      for (final d in days) ..._getEventsForDay(d),
    ];
  }

  void _onDaySelected(DateTime selectedDay, DateTime focusedDay) {
    if (!isSameDay(_selectedDay, selectedDay)) {
      setState(() {
        _selectedDay = selectedDay;
        _focusedDay = focusedDay;
        _rangeStart = null; // Important to clean those
        _rangeEnd = null;
        _rangeSelectionMode = RangeSelectionMode.toggledOff;
      });

      _schedules.value = _getEventsForDay(selectedDay);
    }
  }

  void _onRangeSelected(DateTime? start, DateTime? end, DateTime focusedDay) {
    setState(() {
      _selectedDay = null;
      _focusedDay = focusedDay;
      _rangeStart = start;
      _rangeEnd = end;
      _rangeSelectionMode = RangeSelectionMode.toggledOn;
    });

    if (start != null && end != null) {
      _schedules.value = _getEventsForRange(start, end);
    } else if (start != null) {
      _schedules.value = _getEventsForDay(start);
    } else if (end != null) {
      _schedules.value = _getEventsForDay(end);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
      padding: const EdgeInsets.all(10),
      child: Column(
        children: [
          Container(
            decoration: BoxDecoration(
                border: Border.all(color: Colors.black),
                borderRadius: BorderRadius.circular(13)),
            child:
            TableCalendar<Schedule>(
              calendarStyle: const CalendarStyle(
                weekendTextStyle: TextStyle(color: Colors.redAccent),
                todayDecoration: BoxDecoration(
                  color: Colors.green,
                  shape: BoxShape.circle,
                ),
                selectedDecoration: BoxDecoration(
                  color: Colors.blue,
                  shape: BoxShape.circle,
                ),
              ),
              daysOfWeekStyle: const DaysOfWeekStyle(
                weekendStyle: TextStyle(color: Colors.red),
              ),
              headerStyle: const HeaderStyle(
                titleTextStyle: TextStyle(color: Colors.white, fontSize: 20.0),
                decoration: BoxDecoration(
                  color: Colors.blue,
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(13),
                      topRight: Radius.circular(13)),
                ),
                formatButtonVisible: false,
                leftChevronIcon: Icon(
                  Icons.chevron_left,
                  color: Colors.white,
                  size: 28,
                ),
                rightChevronIcon: Icon(
                  Icons.chevron_right,
                  color: Colors.white,
                  size: 28,
                ),
              ),
              firstDay: kFirstDay,
              lastDay: kLastDay,
              focusedDay: _focusedDay,
              selectedDayPredicate: (day) => isSameDay(_selectedDay, day),
              rangeStartDay: _rangeStart,
              rangeEndDay: _rangeEnd,
              calendarFormat: _calendarFormat,
              rangeSelectionMode: _rangeSelectionMode,
              eventLoader: _getEventsForDay,
              startingDayOfWeek: StartingDayOfWeek.monday,
              onDaySelected: _onDaySelected,
              onRangeSelected: _onRangeSelected,
              onFormatChanged: (format) {
                if (_calendarFormat != format) {
                  setState(() {
                    _calendarFormat = format;
                  });
                  gets(_selectedDay ?? DateTime.now());
                }
              },
              onPageChanged: (focusedDay) {
                _focusedDay = focusedDay;
                gets(focusedDay);
              },
            ),
          ),
          const SizedBox(height: 8.0),
          Expanded(
            child: ValueListenableBuilder<List<Schedule>>(
              valueListenable: _schedules,
              builder: (context, value, _) {
                return ListView.builder(
                  itemCount: value.length,
                  itemBuilder: (context, index) {
                    return Container(
                      margin: const EdgeInsets.symmetric(
                        horizontal: 12.0,
                        vertical: 4.0,
                      ),
                      decoration: BoxDecoration(
                        border: Border.all(),
                        borderRadius: BorderRadius.circular(13.0),
                      ),
                      child: ListTile(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => DetailSchedule(value[index])),
                          );
                        },
                        title: Text('${value[index].title} - ${value[index].room} (${timestampToString(value[index].start!)})'),
                      ),
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    ));
  }
}
