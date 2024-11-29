import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';
// import 'package:ngodeyuk/models/event_model.dart';

class CalendarWidget extends StatelessWidget {
  final Map<DateTime, List<String>> events;
  final Function(DateTime) onDateSelected;
  final Color holidayTextColor; // Warna khusus untuk hari Minggu
  final Color previousMonthTextColor;
  final TextStyle? dayNameTextStyle; // Gaya teks nama hari biasa

  CalendarWidget({
    required this.events,
    required this.onDateSelected,
    required this.holidayTextColor,
    required this.previousMonthTextColor,
    this.dayNameTextStyle,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: Color(0xFF383A56),
        borderRadius: BorderRadius.circular(12.0),
      ),
      child: TableCalendar(
        focusedDay: DateTime.now(),
        firstDay: DateTime.utc(2000),
        lastDay: DateTime.utc(2100),
        eventLoader: (day) {
          // Menampilkan event pada tanggal yang dipilih
          return events[day] ?? [];
        },
        calendarStyle: CalendarStyle(
          todayDecoration: BoxDecoration(
            color: Color(0xFFB0A565),
            shape: BoxShape.circle,
          ),
          selectedDecoration: BoxDecoration(
            color: Color(0xFFEDE68A),
            shape: BoxShape.circle,
          ),
          defaultTextStyle: TextStyle(color: Color(0xFFEDE68A)),
          outsideTextStyle: TextStyle(
              color: previousMonthTextColor), // Warna tanggal luar bulan
          holidayTextStyle: TextStyle(
            color: holidayTextColor, // Warna khusus hari Minggu
            fontWeight: FontWeight.bold,
          ),
          weekendTextStyle: TextStyle(
            color: Color(0xFFEDE68A), // Warna untuk Sabtu
          ),
          markerDecoration: BoxDecoration(
            color: Color(0xFFB0A565),
            shape: BoxShape.circle,
          ),
          markersMaxCount: 3,
        ),
        daysOfWeekStyle: DaysOfWeekStyle(
          weekdayStyle: dayNameTextStyle ??
              TextStyle(
                color: Color(0xFFEDE68A), // Default warna hari biasa
                fontWeight: FontWeight.bold,
              ),
          weekendStyle: TextStyle(
            color: Color(0xFFEDE68A), // Warna untuk Sabtu
          ),
        ),
        headerStyle: HeaderStyle(
          titleTextStyle: TextStyle(
            color: Color(0xFFEDE68A),
            fontWeight: FontWeight.bold,
            fontSize: 18,
          ),
          formatButtonVisible: false,
          leftChevronIcon: Icon(Icons.chevron_left, color: Colors.white),
          rightChevronIcon: Icon(Icons.chevron_right, color: Colors.white),
        ),
        holidayPredicate: (day) {
          // Menentukan apakah sebuah hari adalah hari Minggu
          return day.weekday == DateTime.sunday;
        },
        onDaySelected: (selectedDay, focusedDay) {
          // Menangani pemilihan tanggal
          onDateSelected(selectedDay);
        },
      ),
    );
  }
}
