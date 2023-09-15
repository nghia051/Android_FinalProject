import 'package:flutter/material.dart';

class CustomerBottomNavigationBar extends StatelessWidget {
  const CustomerBottomNavigationBar(
      {super.key, required this.selectedPageIndex, required this.onIconTap});
  final int selectedPageIndex;
  final Function onIconTap;

  @override
  Widget build(BuildContext context) {
    final barHeight = MediaQuery.of(context).size.height * 0.06;
    final style = Theme.of(context)
        .textTheme
        .bodyLarge!
        .copyWith(fontSize: 15, fontWeight: FontWeight.w600);

    return BottomAppBar(
      color: selectedPageIndex == 0 ? Colors.black : Colors.white,
      child: Container(
        height: barHeight,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            _bottomBarNavItem(0, 'Reels', style, Icons.home),
            _bottomBarNavItem(1, 'Posts', style, Icons.store),
            _bottomBarNavItem(2, 'Map', style, Icons.map),
            _bottomBarNavItem(3, 'Check-in', style, Icons.location_on),
            _bottomBarNavItem(4, 'Profile', style, Icons.account_circle),
          ],
        ),
      ),
    );
  }

  _bottomBarNavItem(
      int index, String label, TextStyle textStyle, IconData iconData) {
    bool isSelected = selectedPageIndex == index;
    Color iconAndTextColor = isSelected ? Colors.black : Colors.grey;

    if (isSelected && selectedPageIndex == 0) {
      iconAndTextColor = Colors.white;
    }

    return GestureDetector(
      onTap: () => {onIconTap(index)},
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            iconData,
            color: iconAndTextColor,
            size: 25,
          ),
          SizedBox(
            height: 3,
          ),
          Text(label, style: textStyle.copyWith(color: iconAndTextColor)),
        ],
      ),
    );
  }

  _addVideoNavItem(double height) {
    return Container(
      height: height - 15,
      width: 48,
      margin: EdgeInsets.only(bottom: 4),
      decoration: BoxDecoration(
        gradient: LinearGradient(colors: [Colors.blueAccent, Colors.redAccent]),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Center(
        child: Container(
          width: 41,
          height: height - 15,
          decoration: BoxDecoration(
            color: selectedPageIndex == 0 ? Colors.white : Colors.black,
            borderRadius: BorderRadius.circular(8),
          ),
          child: Icon(Icons.add,
              color: selectedPageIndex == 0 ? Colors.black : Colors.white),
        ),
      ),
    );
  }
}
