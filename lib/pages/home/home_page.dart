import 'package:flutter/material.dart';
import 'package:finalproject/pages/home/widgets/house.dart';
import 'package:finalproject/pages/home/widgets/time_table.dart';
import 'package:finalproject/pages/home/widgets/characters.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0;

  void _handleClickButton(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  var kBottomBarBackgroundColor = Color.fromARGB(255, 237, 197, 0);
  var kBottomBarForegroundActiveColor = const Color.fromARGB(255, 245, 0, 0);
  var kBottomBarForegroundInactiveColor = Colors.white60;
  var kSplashColor = Color.fromARGB(248, 255, 34, 0);

  @override
  Widget build(BuildContext context) {
    Widget buildPageBody() {
      switch (_selectedIndex) {
        case 0:
          return const TimeTable();
        case 1:
          return const HouseTable();
        case 2:
          return const AppCharacters();
        default:
          return const TimeTable();
      }
    }

    return Scaffold(
      backgroundColor: Colors.black,
      floatingActionButton: SizedBox(
        width: 80.0,
        height: 80.0,
        child: FloatingActionButton(
          backgroundColor: kBottomBarBackgroundColor,
          shape: CircleBorder(),
          onPressed: () {},
          child: AppBottomMenuItem(
            iconData: Icons.whatshot,
            text: 'BOOK',
            isSelected: _selectedIndex == 0,
            onClick: () => _handleClickButton(0),
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: BottomAppBar(
        height: 64.0,
        padding: EdgeInsets.zero,
        color: kBottomBarBackgroundColor,
        shape: const CircularNotchedRectangle(),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Expanded(
              child: AppBottomMenuItem(
                iconData: Icons.home,
                text: 'HOUSE',
                isSelected: _selectedIndex == 1,
                onClick: () {
                  _handleClickButton(1);
                },
              ),
            ),
            SizedBox(width: 100.0),
            Expanded(
              child: AppBottomMenuItem(
                iconData: Icons.face,
                text: 'CHARACTERS',
                isSelected: _selectedIndex == 2,
                onClick: () => _handleClickButton(2),
              ),
            ),
          ],
        ),
      ),
      body: buildPageBody(),
    );
  }
}

var kBottomBarForegroundActiveColor = const Color.fromARGB(255, 10, 10, 10);
var kBottomBarForegroundInactiveColor = Color.fromARGB(153, 173, 101, 0);

class AppBottomMenuItem extends StatelessWidget {
  const AppBottomMenuItem({
    required this.iconData,
    required this.text,
    required this.isSelected,
    required this.onClick,
  });

  final IconData iconData;
  final String text;
  final bool isSelected;
  final VoidCallback onClick;

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    var color = isSelected
        ? kBottomBarForegroundActiveColor
        : kBottomBarForegroundInactiveColor;

    return ClipOval(
      child: Material(
        color: Colors.transparent, // button color
        child: InkWell(
          onTap: onClick, // button pressed
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Icon(iconData, color: color),
              SizedBox(height: 4.0),
              Text(
                text,
                textAlign: TextAlign.center,
                style: theme.textTheme.labelMedium!.copyWith(
                  color: color,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
