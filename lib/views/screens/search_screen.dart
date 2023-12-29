import 'package:flutter/material.dart';
import 'package:tiktok_tutorial/controllers/search_controller.dart' as sc;
import 'package:get/get.dart';
import 'package:tiktok_tutorial/models/user.dart';
import 'package:tiktok_tutorial/views/screens/profile_screen.dart';

class SearchScreen extends StatelessWidget {
  SearchScreen({Key? key}) : super(key: key);

  final  sc.SearchController searchController = Get.put(sc.SearchController());

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return Scaffold(
        appBar: AppBar(
          backgroundColor: const Color.fromARGB(255, 0, 0, 0),
          title: TextFormField(
            decoration: const InputDecoration(
              filled: false,
              hintText: 'Search for user',
              hintStyle: TextStyle(
                fontSize: 18,
                color: Colors.white,
              ),
            ),
            onFieldSubmitted: (value) => searchController.searchUser(value),
          ),
        ),
        body: searchController.searchedUsers.isEmpty
            ? const Center(
                child: Text(
                  'Search for users!',
                  style: TextStyle(
                    fontSize: 25,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    
                  ),
                  
                ),
              )
            : ListView.builder(
                itemCount: searchController.searchedUsers.length,
                itemBuilder: (context, index) {
                  User user = searchController.searchedUsers[index];
                  return InkWell(
                    onTap: () => Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => ProfileScreen(uid: user.uid),
                      ),
                    ),
                    child: ListTile(
                      
                      title: Text(
                        user.name,
                        style: const TextStyle(
                          fontSize: 18,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  );
                },
              ),
      );
    });
  }
}
