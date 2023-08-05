import 'package:flutter/material.dart';
import 'package:project_structure/constants/route_path.dart';
import 'package:project_structure/controller/app_provider.dart';
import 'package:project_structure/utils/utils.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late AppProvider _appProvider;

  @override
  void initState() {
    _appProvider = Provider.of<AppProvider>(context, listen: false);
    _appProvider.fetchPosts();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(Utils.getString('home_screen')),
        backgroundColor: Colors.blue,
        leading: const SizedBox(),
        centerTitle: true,
      ),
      body: Consumer<AppProvider>(builder: (context, appProvider, child) {
        if (appProvider.isLoading) {
          return const Center(child: CircularProgressIndicator());
        }
        return ListView.builder(
          itemCount: _appProvider.posts.length,
          itemBuilder: (context, index) {
            return InkWell(
              onTap: () {
                Navigator.pushNamed(context, RoutePath.postDetail,
                    arguments: _appProvider.posts[index]);
              },
              child: Container(
                margin: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: Colors.grey[300],
                  borderRadius: BorderRadius.circular(8),
                ),
                child: ListTile(
                  title: Text(_appProvider.posts[index].title),
                  subtitle: Text(_appProvider.posts[index].body),
                ),
              ),
            );
          },
        );
      }),
    );
  }
}
