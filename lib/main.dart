import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'dart:io';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'dart:ui' as ui;
//import 'package:universal_html/html.dart' as html;
import 'package:universal_html/prefer_sdk/html.dart';

void main() => runApp(MyApp());
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      home: new ImagePickerLabPage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => new _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  String formatted;
  DateTime _fromDateTime = DateTime.now();

  Future<Null> _selectDate(BuildContext context) async {
    final DateTime picked = await showDatePicker(
        context: context,
        initialDate: _fromDateTime,
        firstDate: new DateTime(2018),
        lastDate: new DateTime(2025)
    );

    if(picked != null && picked != _fromDateTime) {
      setState(() {
        _fromDateTime = picked;
        var formatter = new DateFormat('dd-MM-yyyy');
        formatted = formatter.format(picked);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final ui.Size logicalSize = MediaQuery.of(context).size;
    final double _width = logicalSize.width;
    final double _height = logicalSize.height;

    // [height: , 521.3333333333334,   _width: , 320.0]
    print(['height: ', _height, '  _width: ', _width]);

    return new Scaffold(
        appBar: new AppBar(),
        body: Row(mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Icon(Icons.calendar_today),
            InkWell(
              onTap: () {
                _selectDate(context);
              },
              child: new Container(
                padding: EdgeInsets.only(top: 12.0, bottom: 12.0, left: 16.0, right: 16.0),
//                decoration: new BoxDecoration(
//                  borderRadius: new BorderRadius.all(new Radius.circular(4.0)),
//                  border: new Border.all(
//                    color: Colors.black45,
//                    width: 1.0,
//                  ),
//                ),
                child: new Text('${formatted==null ? 'select date': formatted}'),
              ),
            ),
          ],
        )
    );
  }
}


//class CalendarViewApp extends StatefulWidget {
//  @override
//  _CalendarViewAppState createState() => _CalendarViewAppState();
//}
//
//class _CalendarViewAppState extends State<CalendarViewApp> {
//  void handleNewDate(date) {
//    print("handleNewDate ${date}");
//  }
//DateTime selectedDate;
//  Future<File> file;
//
//  String status = '';
//
//  String base64Image;
//
//  File tmpFile;
//
//  String errMessage = 'Error Uploading Image';
//
//  chooseImage() {
//    setState(() {
//      file = ImagePicker.pickImage(source: ImageSource.gallery);
//    });
//    setStatus('');
//  }
//
//  Widget showImage() {
//    return FutureBuilder<File>(
//      future: file,
//      builder: (BuildContext context, AsyncSnapshot<File> snapshot) {
//        if (snapshot.connectionState == ConnectionState.done &&
//            null != snapshot.data) {
//          tmpFile = snapshot.data;
//          base64Image = base64Encode(snapshot.data.readAsBytesSync());
//          return Flexible(
//            child: Image.file(
//              snapshot.data,
//              fit: BoxFit.fill,
//            ),
//          );
//        } else if (null != snapshot.error) {
//          return const Text(
//            'Error Picking Image',
//            textAlign: TextAlign.center,
//          );
//        } else {
//          return const Text(
//            'No Image Selected',
//            textAlign: TextAlign.center,
//          );
//        }
//      },
//    );
//  }
//
//  setStatus(String message) {
//    setState(() {
//      status = message;
//    });
//  }
//
//  startUpload() {
//    setStatus('Uploading Image...');
//    if (null == tmpFile) {
//      setStatus(errMessage);
//      return;
//    }
//    String fileName = tmpFile.path.split('/').last;
////    upload(fileName);
//  }
//
////  upload(String fileName) {
////    http.post(uploadEndPoint, body: {
////      "image": base64Image,
////      "name": fileName,
////    }).then((result) {
////      setStatus(result.statusCode == 200 ? result.body : errMessage);
////    }).catchError((error) {
////      setStatus(error);
////    });
////  }
//
//  DateTime _fromDateTime = new DateTime.now();
//
//  Future<Null> _selectDate(BuildContext context) async {
//    final DateTime picked = await showDatePicker(
//        context: context,
//        initialDate: _fromDateTime,
//        firstDate: new DateTime(2018),
//        lastDate: new DateTime(2020)
//    );
//
//    if(picked != null && picked != _fromDateTime) {
//      setState(() {
//        _fromDateTime = picked;
//      });
//    }
//  }
//  @override
//  Widget build(BuildContext context) {
//    return new MaterialApp(
//      title: 'Flutter Demo',
//      theme: new ThemeData(
//        brightness: Brightness.dark,
//        primarySwatch: Colors.purple,
//      ),
//      home: new Scaffold(
//        appBar: new AppBar(
//          title: new Text('Flutter Calendar'),
//        ),
//        body: new Container(
//          margin: new EdgeInsets.symmetric(
//            horizontal: 5.0,
//            vertical: 10.0,
//          ),
//          child: new ListView(
//            shrinkWrap: true,
//            children: <Widget>[
////              new Text('The Default Calendar:'),
////              new Calendar(
////                onSelectedRangeChange: (range) =>
////                    print("Range is ${range.item1}, ${range.item2}"),
////                onDateSelected: (date) => handleNewDate(date),
////              ),
////              new Divider(
////                height: 50.0,
////              ),
//              new Text('The Expanded Calendar:'),
//              new Calendar(
//                onSelectedRangeChange: (range) =>
//                    print("Range is ${range.item1}, ${range.item2}"),
//                isExpandable: true,
//              ),
//              new Divider(
//                height: 50.0,
//              ),
//              Container(
//                padding: EdgeInsets.all(30.0),
//                child: Column(
//                  crossAxisAlignment: CrossAxisAlignment.stretch,
//                  children: <Widget>[
//
//                    InkWell(child: Text('calender'),onTap: (){_selectDate(context);},),
//                    Text(selectedDate==null ? "choose date": selectedDate.toString()),
//                    Container(
//                      child: RaisedButton (
//                        onPressed: () {_selectDate(context);} ,
//                        child: Text(_fromDateTime.toString()),
//                      ),
//                    ),
//                    OutlineButton(
//                      onPressed: chooseImage,
//                      child: Text('Choose Image'),
//                    ),
////                    SizedBox(
////                      height: 20.0,
////                    ),
////                    showImage(),
//                    SizedBox(
//                      height: 20.0,
//                    ),
//                    OutlineButton(
//                      onPressed: startUpload,
//                      child: Text('Upload Image'),
//                    ),
//                    SizedBox(
//                      height: 20.0,
//                    ),
//                    Text(
//                      status,
//                      textAlign: TextAlign.center,
//                      style: TextStyle(
//                        color: Colors.green,
//                        fontWeight: FontWeight.w500,
//                        fontSize: 20.0,
//                      ),
//                    ),
//                    SizedBox(
//                      height: 20.0,
//                    ),
//                  ],
//                ),
//              ),
////              new Text('A Custom Weekly Calendar:'),
////              new Calendar(
////                onSelectedRangeChange: (range) =>
////                    print("Range is ${range.item1}, ${range.item2}"),
////                isExpandable: true,
////                dayBuilder: (BuildContext context, DateTime day) {
////                  return new InkWell(
////                    onTap: () => print("OnTap ${day}"),
////                    child: new Container(
////                      decoration: new BoxDecoration(
////                          border: new Border.all(color: Colors.black38)),
////                      child: new Text(
////                        day.day.toString(),
////                      ),
////                    ),
////                  );
////                },
////              ),
//            ],
//          ),
//        ),
//      ),
//    );
//  }
//}

//typedef DayBuilder(BuildContext context, DateTime day);
//
//class Range {
//  final DateTime from;
//  final DateTime to;
//  Range(this.from, this.to);
//}
//
//class Calendar extends StatefulWidget {
//  final ValueChanged<DateTime> onDateSelected;
//  final ValueChanged onRangeSelected;
//  final bool isExpandable;
//  final DayBuilder dayBuilder;
//  final bool showArrows;
//  final bool showTodayIcon;
//  final Map events;
//  final Color selectedColor;
//  final Color eventColor;
//  final Color eventDoneColor;
//  final DateTime initialDate;
//  final bool isExpanded;
//
//  Calendar({
//    this.onDateSelected,
//    this.onRangeSelected,
//    this.isExpandable: false,
//    this.events,
//    this.dayBuilder,
//    this.showTodayIcon: true,
//    this.showArrows: true,
//    this.selectedColor,
//    this.eventColor,
//    this.eventDoneColor,
//    this.initialDate,
//    this.isExpanded = false,
//  });
//
//  @override
//  _CalendarState createState() => _CalendarState();
//}
//
//class _CalendarState extends State<Calendar> {
//  final calendarUtils = Utils();
//  List<DateTime> selectedMonthsDays;
//  Iterable<DateTime> selectedWeeksDays;
//  DateTime _selectedDate = DateTime.now();
//  String currentMonth;
//  bool isExpanded = false;
//  String displayMonth;
//  DateTime get selectedDate => _selectedDate;
//
//
//
//  void initState() {
//    super.initState();
//    _selectedDate = widget?.initialDate ?? DateTime.now();
//    isExpanded = widget?.isExpanded ?? false;
//    selectedMonthsDays = Utils.daysInMonth(_selectedDate);
//    var firstDayOfCurrentWeek = Utils.firstDayOfWeek(_selectedDate);
//    var lastDayOfCurrentWeek = Utils.lastDayOfWeek(_selectedDate);
//    selectedWeeksDays =
//        Utils.daysInRange(firstDayOfCurrentWeek, lastDayOfCurrentWeek)
//            .toList()
//            .sublist(0, 7);
//    displayMonth = Utils.formatMonth(_selectedDate);
//  }
//
//  Widget get nameAndIconRow {
//    var todayIcon;
//    var leftArrow;
//    var rightArrow;
//
//    if (widget.showArrows) {
//      leftArrow = IconButton(
//        onPressed: isExpanded ? previousMonth : previousWeek,
//        icon: Icon(Icons.chevron_left),
//      );
//      rightArrow = IconButton(
//        onPressed: isExpanded ? nextMonth : nextWeek,
//        icon: Icon(Icons.chevron_right),
//      );
//    } else {
//      leftArrow = Container();
//      rightArrow = Container();
//    }
//
//    if (widget.showTodayIcon) {
//      todayIcon = InkWell(
//        child: Text('Today'),
//        onTap: resetToToday,
//      );
//    } else {
//      todayIcon = Container();
//    }
//
//    return Row(
//      mainAxisAlignment: MainAxisAlignment.spaceBetween,
//      children: [
//        leftArrow ?? Container(),
//        Column(
//          children: <Widget>[
//            todayIcon ?? Container(),
//            Text(
//              displayMonth,
//              style: TextStyle(
//                fontSize: 20.0,
//              ),
//            ),
//          ],
//        ),
//        rightArrow ?? Container(),
//      ],
//    );
//  }
//
//  Widget get calendarGridView {
//    return Container(
//      child: SimpleGestureDetector(
//        onSwipeUp: _onSwipeUp,
//        onSwipeDown: _onSwipeDown,
//        onSwipeLeft: _onSwipeLeft,
//        onSwipeRight: _onSwipeRight,
//        swipeConfig: SimpleSwipeConfig(
//          verticalThreshold: 10.0,
//          horizontalThreshold: 40.0,
//          swipeDetectionMoment: SwipeDetectionMoment.onUpdate,
//        ),
//        child: Column(children: <Widget>[
//          GridView.count(
//            primary: false,
//            shrinkWrap: true,
//            crossAxisCount: 7,
//            padding: EdgeInsets.only(bottom: 0.0),
//            children: calendarBuilder(),
//          ),
//        ]),
//      ),
//    );
//  }
//
//  List<Widget> calendarBuilder() {
//    List<Widget> dayWidgets = [];
//    List<DateTime> calendarDays =
//    isExpanded ? selectedMonthsDays : selectedWeeksDays;
//
//    Utils.weekdays.forEach(
//          (day) {
//        dayWidgets.add(
//          CalendarTile(
//            selectedColor: widget.selectedColor,
//            eventColor: widget.eventColor,
//            eventDoneColor: widget.eventDoneColor,
//            events: widget.events[day],
//            isDayOfWeek: true,
//            dayOfWeek: day,
//          ),
//        );
//      },
//    );
//
//    bool monthStarted = false;
//    bool monthEnded = false;
//
//    calendarDays.forEach(
//          (day) {
//        if (day.hour > 0) {
//          day = day.toLocal();
//
//          day = day.subtract(new Duration(hours: day.hour));
//        }
//
//        if (monthStarted && day.day == 01) {
//          monthEnded = true;
//        }
//
//        if (Utils.isFirstDayOfMonth(day)) {
//          monthStarted = true;
//        }
//
//        if (this.widget.dayBuilder != null) {
//          dayWidgets.add(
//            CalendarTile(
//              selectedColor: widget.selectedColor,
//              eventColor: widget.eventColor,
//              eventDoneColor: widget.eventDoneColor,
//              events: widget.events[day],
//              child: this.widget.dayBuilder(context, day),
//              date: day,
//              onDateSelected: () => handleSelectedDateAndUserCallback(day),
//            ),
//          );
//        } else {
//          dayWidgets.add(
//            CalendarTile(
//                selectedColor: widget.selectedColor,
//                eventColor: widget.eventColor,
//                eventDoneColor: widget.eventDoneColor,
//                events: widget.events[day],
//                onDateSelected: () => handleSelectedDateAndUserCallback(day),
//                date: day,
//                dateStyles: configureDateStyle(monthStarted, monthEnded),
//                isSelected: Utils.isSameDay(selectedDate, day),
//                inMonth: day.month == selectedDate.month),
//          );
//        }
//      },
//    );
//    return dayWidgets;
//  }
//
//  TextStyle configureDateStyle(monthStarted, monthEnded) {
//    TextStyle dateStyles;
//    final TextStyle body1Style = Theme.of(context).textTheme.body1;
//
//    if (isExpanded) {
//      final TextStyle body1StyleDisabled = body1Style.copyWith(
//          color: Color.fromARGB(
//            100,
//            body1Style.color.red,
//            body1Style.color.green,
//            body1Style.color.blue,
//          ));
//
//      dateStyles =
//      monthStarted && !monthEnded ? body1Style : body1StyleDisabled;
//    } else {
//      dateStyles = body1Style;
//    }
//    return dateStyles;
//  }
//
//  Widget get expansionButtonRow {
//    if (widget.isExpandable) {
//      return GestureDetector(
//        onTap: toggleExpanded,
//        child: Container(
//          color: Color.fromRGBO(0, 0, 0, 0.07),
//          height: 40,
//          margin: EdgeInsets.only(top: 8.0),
//          padding: EdgeInsets.all(0),
//          child: Row(
//            mainAxisAlignment: MainAxisAlignment.spaceBetween,
//            children: <Widget>[
//              SizedBox(width: 40.0),
//              Text(Utils.fullDayFormat(selectedDate)),
//              IconButton(
//                onPressed: () {},
//                iconSize: 20.0,
//                padding: EdgeInsets.symmetric(vertical: 5.0, horizontal: 10.0),
//                icon: isExpanded
//                    ? Icon(Icons.arrow_drop_up)
//                    : Icon(Icons.arrow_drop_down),
//              ),
//            ],
//          ),
//        ),
//      );
//    } else {
//      return Container();
//    }
//  }
//
//  @override
//  Widget build(BuildContext context) {
//    return Container(
//      child: Column(
//        mainAxisAlignment: MainAxisAlignment.start,
//        mainAxisSize: MainAxisSize.min,
//        children: <Widget>[
//          nameAndIconRow,
//          ExpansionCrossFade(
//            collapsed: calendarGridView,
//            expanded: calendarGridView,
//            isExpanded: isExpanded,
//          ),
//          expansionButtonRow
//        ],
//      ),
//    );
//  }
//
//  void resetToToday() {
//    _selectedDate = DateTime.now();
//    var firstDayOfCurrentWeek = Utils.firstDayOfWeek(_selectedDate);
//    var lastDayOfCurrentWeek = Utils.lastDayOfWeek(_selectedDate);
//
//    setState(() {
//      selectedWeeksDays =
//          Utils.daysInRange(firstDayOfCurrentWeek, lastDayOfCurrentWeek)
//              .toList();
//      selectedMonthsDays = Utils.daysInMonth(_selectedDate);
//      displayMonth = Utils.formatMonth(_selectedDate);
//    });
//
//    _launchDateSelectionCallback(_selectedDate);
//  }
//
//  void nextMonth() {
//    setState(() {
//      _selectedDate = Utils.nextMonth(_selectedDate);
//      var firstDateOfNewMonth = Utils.firstDayOfMonth(_selectedDate);
//      var lastDateOfNewMonth = Utils.lastDayOfMonth(_selectedDate);
//      updateSelectedRange(firstDateOfNewMonth, lastDateOfNewMonth);
//      selectedMonthsDays = Utils.daysInMonth(_selectedDate);
//      displayMonth = Utils.formatMonth(_selectedDate);
//    });
//  }
//
//  void previousMonth() {
//    setState(() {
//      _selectedDate = Utils.previousMonth(_selectedDate);
//      var firstDateOfNewMonth = Utils.firstDayOfMonth(_selectedDate);
//      var lastDateOfNewMonth = Utils.lastDayOfMonth(_selectedDate);
//      updateSelectedRange(firstDateOfNewMonth, lastDateOfNewMonth);
//      selectedMonthsDays = Utils.daysInMonth(_selectedDate);
//      displayMonth = Utils.formatMonth(_selectedDate);
//    });
//  }
//
//  void nextWeek() {
//    setState(() {
//      _selectedDate = Utils.nextWeek(_selectedDate);
//      var firstDayOfCurrentWeek = Utils.firstDayOfWeek(_selectedDate);
//      var lastDayOfCurrentWeek = Utils.lastDayOfWeek(_selectedDate);
//      updateSelectedRange(firstDayOfCurrentWeek, lastDayOfCurrentWeek);
//      selectedWeeksDays =
//          Utils.daysInRange(firstDayOfCurrentWeek, lastDayOfCurrentWeek)
//              .toList()
//              .sublist(0, 7);
//      displayMonth = Utils.formatMonth(_selectedDate);
//    });
//    _launchDateSelectionCallback(_selectedDate);
//  }
//
//  void previousWeek() {
//    setState(() {
//      _selectedDate = Utils.previousWeek(_selectedDate);
//      var firstDayOfCurrentWeek = Utils.firstDayOfWeek(_selectedDate);
//      var lastDayOfCurrentWeek = Utils.lastDayOfWeek(_selectedDate);
//      updateSelectedRange(firstDayOfCurrentWeek, lastDayOfCurrentWeek);
//      selectedWeeksDays =
//          Utils.daysInRange(firstDayOfCurrentWeek, lastDayOfCurrentWeek)
//              .toList()
//              .sublist(0, 7);
//      displayMonth = Utils.formatMonth(_selectedDate);
//    });
//    _launchDateSelectionCallback(_selectedDate);
//  }
//
//  void updateSelectedRange(DateTime start, DateTime end) {
//    Range _rangeSelected = Range(start, end);
//    if (widget.onRangeSelected != null) {
//      widget.onRangeSelected(_rangeSelected);
//    }
//  }
//
//  void _onSwipeUp() {
//    if (isExpanded) toggleExpanded();
//  }
//
//  void _onSwipeDown() {
//    if (!isExpanded) toggleExpanded();
//  }
//
//  void _onSwipeRight() {
//    if (isExpanded) {
//      previousMonth();
//    } else {
//      previousWeek();
//    }
//  }
//
//  void _onSwipeLeft() {
//    if (isExpanded) {
//      nextMonth();
//    } else {
//      nextWeek();
//    }
//  }
//
//  void toggleExpanded() {
//    if (widget.isExpandable) {
//      setState(() => isExpanded = !isExpanded);
//    }
//  }
//
//  void handleSelectedDateAndUserCallback(DateTime day) {
//    var firstDayOfCurrentWeek = Utils.firstDayOfWeek(day);
//    var lastDayOfCurrentWeek = Utils.lastDayOfWeek(day);
//    if (_selectedDate.month > day.month) {
//      previousMonth();
//    }
//    if (_selectedDate.month < day.month) {
//      nextMonth();
//    }
//    setState(() {
//      _selectedDate = day;
//      selectedWeeksDays =
//          Utils.daysInRange(firstDayOfCurrentWeek, lastDayOfCurrentWeek)
//              .toList();
//      selectedMonthsDays = Utils.daysInMonth(day);
//    });
//    _launchDateSelectionCallback(day);
//  }
//
//  void _launchDateSelectionCallback(DateTime day) {
//    if (widget.onDateSelected != null) {
//      widget.onDateSelected(day);
//    }
//  }
//}
//
//class ExpansionCrossFade extends StatelessWidget {
//  final Widget collapsed;
//  final Widget expanded;
//  final bool isExpanded;
//
//  ExpansionCrossFade({this.collapsed, this.expanded, this.isExpanded});
//
//  @override
//  Widget build(BuildContext context) {
//    return Flexible(
//      flex: 1,
//      child: AnimatedCrossFade(
//        firstChild: collapsed,
//        secondChild: expanded,
//        firstCurve: const Interval(0.0, 1.0, curve: Curves.fastOutSlowIn),
//        secondCurve: const Interval(0.0, 1.0, curve: Curves.fastOutSlowIn),
//        sizeCurve: Curves.decelerate,
//        crossFadeState:
//        isExpanded ? CrossFadeState.showSecond : CrossFadeState.showFirst,
//        duration: const Duration(milliseconds: 300),
//      ),
//    );
//  }
//}

//class MyApp extends StatelessWidget {
//  final GlobalKey<ScaffoldState> scaffoldState = GlobalKey();
//  @override
//  Widget build(BuildContext context) {
//    Event event = Event(
//      title: 'Test event',
//      description: 'example',
//      location: 'Flutter app',
//      startDate: DateTime.now(),
//      endDate: DateTime.now().add(Duration(days: 1)),
//      allDay: false,
//    );
//
//    return MaterialApp(
//      home: Scaffold(
//        key: scaffoldState,
//        appBar: AppBar(
//          title: const Text('Add event to calendar example'),
//        ),
//        body: Center(
//          child: RaisedButton(
//            child: Text('Add test event to device calendar'),
//            onPressed: () {
//              Add2Calendar.addEvent2Cal(event).then((success) {
//                scaffoldState.currentState.showSnackBar(
//                    SnackBar(content: Text(success ? 'Success' : 'Error')));
//              });
//            },
//          ),
//        ),
//      ),
//    );
//  }
//}

//
//class MyHomePage extends StatefulWidget {
//  MyHomePage({Key key, this.title}) : super(key: key);
//
//  final String title;
//
//  @override
//  _MyHomePageState createState() => new _MyHomePageState();
//}
//
//class _MyHomePageState extends State<MyHomePage> {
//  DateTime _currentDate = DateTime(2019, 2, 3);
//  DateTime _currentDate2 = DateTime(2019, 2, 3);
//  String _currentMonth = DateFormat.yMMM().format(DateTime(2019, 2, 3));
//  DateTime _targetDateTime = DateTime(2019, 2, 3);
////  List<DateTime> _markedDate = [DateTime(2018, 9, 20), DateTime(2018, 10, 11)];
//  static Widget _eventIcon = new Container(
//    decoration: new BoxDecoration(
//        color: Colors.white,
//        borderRadius: BorderRadius.all(Radius.circular(1000)),
//        border: Border.all(color: Colors.blue, width: 2.0)),
//    child: new Icon(
//      Icons.person,
//      color: Colors.amber,
//    ),
//  );
//
//  EventList<Event> _markedDateMap = new EventList<Event>(
//    events: {
//      new DateTime(2019, 2, 10): [
//        new Event(
//          date: new DateTime(2019, 2, 10),
//          title: 'Event 1',
//          icon: _eventIcon,
//          dot: Container(
//            margin: EdgeInsets.symmetric(horizontal: 1.0),
//            color: Colors.red,
//            height: 5.0,
//            width: 5.0,
//          ),
//        ),
//        new Event(
//          date: new DateTime(2019, 2, 10),
//          title: 'Event 2',
//          icon: _eventIcon,
//        ),
//        new Event(
//          date: new DateTime(2019, 2, 10),
//          title: 'Event 3',
//          icon: _eventIcon,
//        ),
//      ],
//    },
//  );
//
//  CalendarCarousel _calendarCarousel, _calendarCarouselNoHeader;
//
//  @override
//  void initState() {
//    /// Add more events to _markedDateMap EventList
//    _markedDateMap.add(
//        new DateTime(2019, 2, 25),
//        new Event(
//          date: new DateTime(2019, 2, 25),
//          title: 'Event 5',
//          icon: _eventIcon,
//        ));
//
//    _markedDateMap.add(
//        new DateTime(2019, 2, 10),
//        new Event(
//          date: new DateTime(2019, 2, 10),
//          title: 'Event 4',
//          icon: _eventIcon,
//        ));
//
//    _markedDateMap.addAll(new DateTime(2019, 2, 11), [
//      new Event(
//        date: new DateTime(2019, 2, 11),
//        title: 'Event 1',
//        icon: _eventIcon,
//      ),
//      new Event(
//        date: new DateTime(2019, 2, 11),
//        title: 'Event 2',
//        icon: _eventIcon,
//      ),
//      new Event(
//        date: new DateTime(2019, 2, 11),
//        title: 'Event 3',
//        icon: _eventIcon,
//      ),
//      new Event(
//        date: new DateTime(2019, 2, 11),
//        title: 'Event 4',
//        icon: _eventIcon,
//      ),
//      new Event(
//        date: new DateTime(2019, 2, 11),
//        title: 'Event 23',
//        icon: _eventIcon,
//      ),
//      new Event(
//        date: new DateTime(2019, 2, 11),
//        title: 'Event 123',
//        icon: _eventIcon,
//      ),
//    ]);
//    super.initState();
//  }
//
//  @override
//  Widget build(BuildContext context) {
//    /// Example with custom icon
//    _calendarCarousel = CalendarCarousel<Event>(
//      onDayPressed: (DateTime date, List<Event> events) {
//        this.setState(() => _currentDate = date);
//        events.forEach((event) => print(event.title));
//      },
//      weekendTextStyle: TextStyle(
//        color: Colors.red,
//      ),
//      thisMonthDayBorderColor: Colors.grey,
////          weekDays: null, /// for pass null when you do not want to render weekDays
//      headerText: 'Custom Header',
////          markedDates: _markedDate,
//      weekFormat: true,
//      markedDatesMap: _markedDateMap,
//      height: 200.0,
//      selectedDateTime: _currentDate2,
//      showIconBehindDayText: true,
////          daysHaveCircularBorder: false, /// null for not rendering any border, true for circular border, false for rectangular border
//      customGridViewPhysics: NeverScrollableScrollPhysics(),
//      markedDateShowIcon: true,
//      markedDateIconMaxShown: 2,
//      selectedDayTextStyle: TextStyle(
//        color: Colors.yellow,
//      ),
//      todayTextStyle: TextStyle(
//        color: Colors.blue,
//      ),
//      markedDateIconBuilder: (event) {
//        return event.icon;
//      },
//      minSelectedDate: _currentDate.subtract(Duration(days: 360)),
//      maxSelectedDate: _currentDate.add(Duration(days: 360)),
//      todayButtonColor: Colors.transparent,
//      todayBorderColor: Colors.green,
//      markedDateMoreShowTotal:
//      false, // null for not showing hidden events indicator
////          markedDateIconMargin: 9,
////          markedDateIconOffset: 3,
//    );
//
//    /// Example Calendar Carousel without header and custom prev & next button
//    _calendarCarouselNoHeader = CalendarCarousel<Event>(
//      todayBorderColor: Colors.green,
//      onDayPressed: (DateTime date, List<Event> events) {
//        this.setState(() => _currentDate2 = date);
//        events.forEach((event) => print(event.title));
//      },
//      daysHaveCircularBorder: true,
//      showOnlyCurrentMonthDate: false,
//      weekendTextStyle: TextStyle(
//        color: Colors.red,
//      ),
//      thisMonthDayBorderColor: Colors.grey,
//      weekFormat: false,
////      firstDayOfWeek: 4,
//      markedDatesMap: _markedDateMap,
//      height: 420.0,
//      selectedDateTime: _currentDate2,
//      targetDateTime: _targetDateTime,
//      customGridViewPhysics: NeverScrollableScrollPhysics(),
//      markedDateCustomShapeBorder: CircleBorder(
//          side: BorderSide(color: Colors.yellow)
//      ),
//      markedDateCustomTextStyle: TextStyle(
//        fontSize: 18,
//        color: Colors.blue,
//      ),
//      showHeader: false,
//      // markedDateIconBuilder: (event) {
//      //   return Container(
//      //     color: Colors.blue,
//      //   );
//      // },
//      todayTextStyle: TextStyle(
//        color: Colors.blue,
//      ),
//      todayButtonColor: Colors.yellow,
//      selectedDayTextStyle: TextStyle(
//        color: Colors.yellow,
//      ),
//      minSelectedDate: _currentDate.subtract(Duration(days: 360)),
//      maxSelectedDate: _currentDate.add(Duration(days: 360)),
//      prevDaysTextStyle: TextStyle(
//        fontSize: 16,
//        color: Colors.pinkAccent,
//      ),
//      inactiveDaysTextStyle: TextStyle(
//        color: Colors.tealAccent,
//        fontSize: 16,
//      ),
//      onCalendarChanged: (DateTime date) {
//        this.setState(() {
//          _targetDateTime = date;
//          _currentMonth = DateFormat.yMMM().format(_targetDateTime);
//        });
//      },
//      onDayLongPressed: (DateTime date) {
//        print('long pressed date $date');
//      },
//    );
//
//    return new Scaffold(
//        appBar: new AppBar(
//          title: new Text(widget.title),
//        ),
//        body: SingleChildScrollView(
//          child: Column(
//            crossAxisAlignment: CrossAxisAlignment.start,
//            mainAxisAlignment: MainAxisAlignment.start,
//            children: <Widget>[
//              //custom icon
//              Container(
//                margin: EdgeInsets.symmetric(horizontal: 16.0),
//                child: _calendarCarousel,
//              ), // This trailing comma makes auto-formatting nicer for build methods.
//              //custom icon without header
//              Container(
//                margin: EdgeInsets.only(
//                  top: 30.0,
//                  bottom: 16.0,
//                  left: 16.0,
//                  right: 16.0,
//                ),
//                child: new Row(
//                  children: <Widget>[
//                    Expanded(
//                        child: Text(
//                          _currentMonth,
//                          style: TextStyle(
//                            fontWeight: FontWeight.bold,
//                            fontSize: 24.0,
//                          ),
//                        )),
//                    FlatButton(
//                      child: Text('PREV'),
//                      onPressed: () {
//                        setState(() {
//                          _targetDateTime = DateTime(_targetDateTime.year, _targetDateTime.month -1);
//                          _currentMonth = DateFormat.yMMM().format(_targetDateTime);
//                        });
//                      },
//                    ),
//                    FlatButton(
//                      child: Text('NEXT'),
//                      onPressed: () {
//                        setState(() {
//                          _targetDateTime = DateTime(_targetDateTime.year, _targetDateTime.month +1);
//                          _currentMonth = DateFormat.yMMM().format(_targetDateTime);
//                        });
//                      },
//                    )
//                  ],
//                ),
//              ),
//              Container(
//                margin: EdgeInsets.symmetric(horizontal: 16.0),
//                child: _calendarCarouselNoHeader,
//              ), //
//            ],
//          ),
//        ));
//  }
//}



//
//class UploadImageDemo extends StatefulWidget {
//  UploadImageDemo() : super();
//
//  final String title = "Upload Image Demo";
//
//  @override
//  UploadImageDemoState createState() => UploadImageDemoState();
//}
//
//class UploadImageDemoState extends State<UploadImageDemo> {
//  //
//  static final String uploadEndPoint =
//      'http://localhost/flutter_test/upload_image.php';
//  Future<File> file;
//  String status = '';
//  String base64Image;
//  File tmpFile;
//  String errMessage = 'Error Uploading Image';
//
//  chooseImage() {
//    setState(() {
//      file = ImagePicker.pickImage(source: ImageSource.gallery);
//    });
//    setStatus('');
//  }
//
//  setStatus(String message) {
//    setState(() {
//      status = message;
//    });
//  }
//
//  startUpload() {
//    setStatus('Uploading Image...');
//    if (null == tmpFile) {
//      setStatus(errMessage);
//      return;
//    }
//    String fileName = tmpFile.path.split('/').last;
//    upload(fileName);
//  }
//
//  upload(String fileName) {
//    http.post(uploadEndPoint, body: {
//      "image": base64Image,
//      "name": fileName,
//    }).then((result) {
//      setStatus(result.statusCode == 200 ? result.body : errMessage);
//    }).catchError((error) {
//      setStatus(error);
//    });
//  }
//
//  Widget showImage() {
//    return FutureBuilder<File>(
//      future: file,
//      builder: (BuildContext context, AsyncSnapshot<File> snapshot) {
//        if (snapshot.connectionState == ConnectionState.done &&
//            null != snapshot.data) {
//          tmpFile = snapshot.data;
//          base64Image = base64Encode(snapshot.data.readAsBytesSync());
//          return Flexible(
//            child: Image.file(
//              snapshot.data,
//              fit: BoxFit.fill,
//            ),
//          );
//        } else if (null != snapshot.error) {
//          return const Text(
//            'Error Picking Image',
//            textAlign: TextAlign.center,
//          );
//        } else {
//          return const Text(
//            'No Image Selected',
//            textAlign: TextAlign.center,
//          );
//        }
//      },
//    );
//  }
//
//  @override
//  Widget build(BuildContext context) {
//    return Scaffold(
//      appBar: AppBar(
//        title: Text("Upload Image Demo"),
//      ),
//      body: Container(
//        padding: EdgeInsets.all(30.0),
//        child: Column(
//          crossAxisAlignment: CrossAxisAlignment.stretch,
//          children: <Widget>[
//            OutlineButton(
//              onPressed: chooseImage,
//              child: Text('Choose Image'),
//            ),
//            SizedBox(
//              height: 20.0,
//            ),
//            showImage(),
//            SizedBox(
//              height: 20.0,
//            ),
//            OutlineButton(
//              onPressed: startUpload,
//              child: Text('Upload Image'),
//            ),
//            SizedBox(
//              height: 20.0,
//            ),
//            Text(
//              status,
//              textAlign: TextAlign.center,
//              style: TextStyle(
//                color: Colors.green,
//                fontWeight: FontWeight.w500,
//                fontSize: 20.0,
//              ),
//            ),
//            SizedBox(
//              height: 20.0,
//            ),
//          ],
//        ),
//      ),
//    );
//  }
//}

class ImagePickerLabPage extends StatefulWidget {
  @override
  _ImagePickerLabPageState createState() => _ImagePickerLabPageState();
}

class _ImagePickerLabPageState extends State<ImagePickerLabPage> {
  String name = '';
  String error;
  Uint8List data;

  pickImage() {
    final InputElement input = document.createElement('input');
    input
      ..type = 'file'
      ..accept = 'image/*';

    input.onChange.listen((e) {
      if (input.files.isEmpty) return;
      final reader = FileReader();
      reader.readAsDataUrl(input.files[0]);
      reader.onError.listen((err) => setState(() {
        error = err.toString();
      }));
      reader.onLoad.first.then((res) {
        final encoded = reader.result as String;
        // remove data:image/*;base64 preambule
        final stripped =
        encoded.replaceFirst(RegExp(r'data:image/[^;]+;base64,'), '');

        setState(() {
          name = input.files[0].name;
          data = base64.decode(stripped);
          error = null;
        });
      });
    });

    input.click();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(name),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.open_in_browser),
        onPressed: () {
          pickImage();
        },
      ),
      body: Center(
        child: error != null
            ? Text(error)
            : data != null ? Image.memory(data) : Text('No data...'),
      ),
    );
  }
}
//Future<void> _setImage() async {
//  final completer = Completer<List<String>>();
//  InputElement uploadInput = FileUploadInputElement();
//  uploadInput.multiple = true;
//  uploadInput.accept = 'image/*';
//  uploadInput.click();
//  //* onChange doesn't work on mobile safari
//  uploadInput.addEventListener('change', (e) async {
//    // read file content as dataURL
//    final files = uploadInput.files;
//    Iterable<Future<String>> resultsFutures = files.map((file) {
//      final reader = FileReader();
//      reader.readAsDataUrl(file);
//      reader.onError.listen((error) => completer.completeError(error));
//      return reader.onLoad.first.then((_) => reader.result as String);
//    });
//
//    final results = await Future.wait(resultsFutures);
//    completer.complete(results);
//  });
//  //* need to append on mobile safari
//  document.body.append(uploadInput);
//  final List<String> images = await completer.future;
//  setState(() {
//    _uploadedImages = images;
//  });
//  uploadInput.remove();
//
//  //* this also works
//  // final completer = Completer<List<String>>();
//  // final InputElement input = document.createElement('input');
//  // input
//  //   ..type = 'file'
//  //   ..multiple = true
//  //   ..accept = 'image/*';
//  // input.click();
//  //* onChange doesn't work in mobile safari
//  // input.addEventListener('change', (e) async {
//  //   final List<File> files = input.files;
//  //   Iterable<Future<String>> resultsFutures = files.map((file) {
//  //     final reader = FileReader();
//  //     reader.readAsDataUrl(file);
//  //     reader.onError.listen((error) => completer.completeError(error));
//  //     return reader.onLoad.first.then((_) => reader.result as String);
//  //   });
//  //   final results = await Future.wait(resultsFutures);
//  //   completer.complete(results);
//  // });
//  // document.body.append(input);
//  // // input.click(); can be here
//  // final List<String> images = await completer.future;
//  // setState(() {
//  //   _uploadedImages = images;
//  // });
//  // input.remove();
//}



//class ProviderForm extends ChangeNotifier {
//  Uint8List logoEmpresa;
//  void setLogoEmpresa(Uint8List newFile) {
//    logoEmpresa = newFile;
//    notifyListeners();
//  }
//}
