import 'package:flutter/material.dart';
import 'package:flutter/gestures.dart';
import 'dart:ui';
// import 'package:google_fonts/google_fonts.dart';
// import 'package:myapp/utils.dart';
import 'package:flutter_calendar_carousel/classes/marked_date.dart';
import 'package:flutter_calendar_carousel/flutter_calendar_carousel.dart'
    show CalendarCarousel, EventList, Event;
import 'package:flutter_calendar_carousel/classes/event.dart';
import 'package:intl/intl.dart' show DateFormat;

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  DateTime _currentDate = DateTime.now();
  String _currentMonth = DateFormat.yMMM().format(DateTime.now());
  late Event? _selectedEvent;
  List<Event> events = [
    Event(
        title: 'Moisturize',
        description: "Let's get your hair moisturized",
        date: DateTime(2023, 1, 2)),
    Event(
        title: 'Nurture',
        description: 'Lets get your hair nurtured',
        date: DateTime(2023, 1, 3)),
    Event(
        title: 'Repair',
        description: 'Lets get your hair repaired',
        date: DateTime(2023, 1, 4)),
  ];
  EventList<Event> markedDatesMap = EventList<Event>(
    events: {
      DateTime.now(): [
        Event(
          date: DateTime.now(),
          icon: Icon(
            Icons.check,
            color: Colors.red,
          ),
        ),
      ],
    },
  );
  bool _isDescriptionVisible = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Color(0xffffb0b0),
          title: Text('Hi, Jessica Pauline'),
        ),
        body: Container(
          child: Column(
            children: <Widget>[
              CalendarCarousel(
                onDayPressed: (DateTime date, List<Event> events) {
                  setState(() {
                    _currentDate = date;
                    _currentMonth = DateFormat.yMMM().format(date);
                    _selectedEvent = events.firstWhere(
                      (event) => event.date == date,
                      orElse: () => Event(
                          title: '', description: '', date: DateTime.now()),
                    );
                    _isDescriptionVisible = true;
                  });
                },
                onDayLongPressed: (DateTime date) {
                  setState(() {
                    _isDescriptionVisible = false;
                  });
                },
                todayBorderColor: Colors.black,
                todayButtonColor: Color(0xffffb0b0),
                todayTextStyle: TextStyle(
                  color: Color.fromARGB(255, 0, 0, 0),
                ),
                selectedDayButtonColor: Color(0xff80bdab),
                selectedDateTime: _currentDate,
                selectedDayTextStyle: TextStyle(color: Colors.white),
                thisMonthDayBorderColor: Colors.grey,
                height: 420.0,
                daysHaveCircularBorder: false,
                markedDatesMap: markedDatesMap,
              ),
              Expanded(
                child: ListView.builder(
                  itemCount: events.length,
                  itemBuilder: (context, index) {
                    if (events[index].date == _currentDate) {
                      return Card(
                        child: ListTile(
                          title: Text(events[index].title as String),
                          subtitle: Text(events[index].description as String),
                          trailing: FloatingActionButton(
                            backgroundColor: Color(0xff80bdab),
                            child: Icon(Icons.arrow_right),
                            onPressed: () {},
                          ),
                        ),
                      );
                    } else {
                      return Container();
                    }
                  },
                ),
              ),
            ],
          ),
        ),
        bottomNavigationBar: BottomNavigationBar(
          backgroundColor: Color(0xff000000),
          unselectedItemColor: Colors.white,
          selectedItemColor: Color(0xffffb0b0),
          items: [
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: ('Home'),
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.notifications),
              label: ('Notifications'),
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.person),
              label: ('Profile'),
            ),
          ],
        ));
  }
}
