import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:koodiarana_chauffeur/providers/scroll_manager.dart';
import 'package:provider/provider.dart';

class Page1 extends StatefulWidget {
  const Page1({super.key});

  @override
  State<Page1> createState() => _Page1State();
}

class _Page1State extends State<Page1> {
  late ScrollController _scrollController;
  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
    _scrollController.addListener(() {
      if (_scrollController.position.userScrollDirection ==
          ScrollDirection.reverse) {
        Provider.of<ScrollManager>(context, listen: false).hideBottomBar();
      }
      if (_scrollController.position.userScrollDirection ==
          ScrollDirection.forward) {
        Provider.of<ScrollManager>(context, listen: false).showBottomBar();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    // final textTheme = Theme.of(context).textTheme;
    return
        //  Padding(
        //   padding: EdgeInsets.all(16),
        //   child:
        ListView.builder(
            controller: _scrollController,
            itemBuilder: (context, i) {
              return ListTile(
                leading: Icon(Icons.notifications_none),
                title: Text('title'),
                subtitle: Text('subTitle'),
                onTap: () {},
              );
            },
            itemCount: 50);
    //);
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }
}
