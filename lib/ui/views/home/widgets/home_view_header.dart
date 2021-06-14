import 'package:flutter/material.dart';

class HomeViewHeader extends StatelessWidget {
  const HomeViewHeader({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      shrinkWrap: true,
      scrollDirection: Axis.horizontal,
      itemCount: 8,
      itemBuilder: (_, index) => ElevatedButton(
        child: Text("Header $index"),
        onPressed: () {},
      ),
      separatorBuilder: (_, index) => SizedBox(
        width: (index < 8) ? 10 : 0,
      ),
    );
  }
}
