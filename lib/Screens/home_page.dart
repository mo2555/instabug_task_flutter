import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:instabug_task_flutter/Comp/movies_item.dart';
import 'package:instabug_task_flutter/Consts/consts.dart';
import 'package:instabug_task_flutter/Model/item_view.dart';
import 'package:instabug_task_flutter/Provider/movies_provider.dart';
import 'package:provider/provider.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final ScrollController scrollController = ScrollController();
  int page = 1;

  @override
  void initState() {
    Provider.of<MoviesProvider>(context, listen: false).fetchData(page);
      scrollController.addListener(() {
        if(scrollController.position.pixels>=scrollController.position.maxScrollExtent&&page<100){
          setState(() {
            page++;
        });
          Provider.of<MoviesProvider>(context, listen: false).fetchData(page);
        }
      });
    super.initState();
  }

  @override
  void dispose() {
    scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var data = Provider.of<MoviesProvider>(
      context,
    ).results;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        titleSpacing: 20,
        backgroundColor: Colors.white,
        elevation: 0,
        title: const Text(
          'Instabug',
          style: appBarTextStyle,
        ),
      ),
      body: ConditionalBuilder(
        fallback: (BuildContext context) => const Center(
          child: CircularProgressIndicator(),
        ),
        builder: (BuildContext context) {
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: ListView.separated(
                controller: scrollController,
                itemBuilder: (context, index) {
                  if (index < data.length) {
                    return MoviesItem(
                        itemView: ItemView(
                            title: data[index].title,
                            date: data[index].releaseDate,
                            overview: data[index].overview,
                            poster: data[index].posterPath));
                  } else {
                    if (data.length<page*20) {
                      return const Padding(
                      padding: EdgeInsets.symmetric(vertical: 10),
                      child: Center(
                        child: CircularProgressIndicator(),
                      ),
                    );
                    } else {
                      return const Padding(
                      padding: EdgeInsets.symmetric(vertical: 20),
                      child: Center(
                        child: Text('No more data to load!',
                        style: appBarTextStyle
                        ),
                      ),
                    );
                    }
                  }
                },
                separatorBuilder: (context, index) => Container(
                      color: Colors.black,
                      height: 1,
                      width: double.infinity,
                    ),
                itemCount: data.length + 1),
          );
        },
        condition: data.isNotEmpty,
      ),
    );
  }
}
