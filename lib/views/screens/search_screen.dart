import 'package:flutter/material.dart';
import 'package:tiktok_tutorial/controllers/search_controller.dart' as sc;
import 'package:get/get.dart';
import 'package:tiktok_tutorial/models/user.dart';
import 'package:tiktok_tutorial/views/screens/profile_screen.dart';

class SearchScreen extends StatelessWidget {
  SearchScreen({Key? key}) : super(key: key);

  final  sc.SearchController searchController = Get.put(sc.SearchController());
  TextEditingController _controller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Obx(() {
      
      return Scaffold(
        appBar: AppBar(
          backgroundColor: const Color.fromARGB(255, 0, 0, 0),
          title: TextFormField(
            controller: _controller,
            decoration: const InputDecoration(
              filled: true,
              border: InputBorder.none,
              fillColor: Color.fromRGBO(22, 22, 22, 1),
              hintText: 'Search for user',

              hintStyle: TextStyle(
                fontSize: 18,
                color: Color.fromRGBO(135, 135, 135, 1),
                
              ),
            ),
            onFieldSubmitted: (value) => searchController.searchUser(value),
          ),
          actions: [TextButton(onPressed: null, child: Text('Search',style: TextStyle(color:Color.fromRGBO(57, 219, 255, 1)),))],
        ),
        body: 
        
        searchController.searchedUsers.isEmpty
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
                      
                      title: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                         
                          
                          Text(
                            user.name,
                            style: const TextStyle(
                              fontSize: 18,
                              color: Color.fromRGBO(57, 219, 255, 1),
                            ),
                          ),
                        GestureDetector(
                          child: Icon(Icons.close ,color: Color.fromRGBO(57, 219, 255, 1),
                          )
                          ,onTap:() {
                            searchController.searchedUsers.remove(user.name);
                          }, )],
                      ),
                    ),
                  );
                },
              ),
      );
    });
  }
}
