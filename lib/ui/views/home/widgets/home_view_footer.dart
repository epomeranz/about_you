import 'package:flutter/material.dart';

class HomeViewFooter extends StatelessWidget {
  const HomeViewFooter({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      shrinkWrap: true,
      scrollDirection: Axis.horizontal,
      itemCount: 3,
      itemBuilder: (_, index) => ElevatedButton(
        child: Text("Footer $index"),
        onPressed: () {},
      ),
      separatorBuilder: (_, index) => SizedBox(
        width: (index < 3) ? 10 : 0,
      ),
    );
  }
}
