import 'package:dog_breed_app/Blocs/os_info_bloc.dart';
import 'package:flutter/material.dart';

class CustomBottomNavBar extends StatefulWidget {
  const CustomBottomNavBar({super.key});

  @override
  State<CustomBottomNavBar> createState() => _CustomBottomNavBarState();
}

class _CustomBottomNavBarState extends State<CustomBottomNavBar> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 85,
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.elliptical(50, 24),
          topRight: Radius.elliptical(50, 24),
          bottomLeft: Radius.zero,
          bottomRight: Radius.zero,
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: <Widget>[
          const SizedBox(),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              IconButton(
                icon: const Icon(Icons.home, size:33),
                onPressed: () {
                  // Home page cannot be change, therefore onPressed method is empty
                },
                color: Colors.blueAccent,
              ),
              const Text("Home", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 11, color: Colors.blueAccent),)
            ],
          ),
          const VerticalDivider(color: Colors.grey, indent: 30, endIndent: 30,),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              IconButton(
                icon: const Icon(Icons.settings, size:33),
                onPressed: () {
                  showModalBottomSheet<void>(
                    context: context,
                    isScrollControlled: true,
                    builder: (BuildContext context) {
                      return Padding(
                        padding: EdgeInsets.zero,
                        child: Container(
                          height: MediaQuery.of(context).size.height,
                          color: const Color(0x00f2f2f7),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisSize: MainAxisSize.min,
                            children: <Widget>[
                              const SizedBox(height: 60,),
                              const ListTile(
                                leading: Icon(Icons.info_outline_rounded, size: 32,),
                                title: Text("Help", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 22),),
                                trailing: Icon(Icons.open_in_new, color: Colors.grey, size: 16,),
                              ),
                              const Divider(indent: 20, endIndent: 20,),
                              const ListTile(
                                leading: Icon(Icons.star_border_rounded, size: 32,),
                                title: Text("Rate Us", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 22),),
                                trailing: Icon(Icons.open_in_new, color: Colors.grey, size: 16,),
                              ),
                              const Divider(indent: 20, endIndent: 20,),
                              const ListTile(
                                leading: Icon(Icons.ios_share_rounded, size: 32,),
                                title: Text("Share with Friends", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 22),),
                                trailing: Icon(Icons.open_in_new, color: Colors.grey, size: 16,),
                              ),
                              const Divider(indent: 20, endIndent: 20,),
                              const ListTile(
                                leading: Icon(Icons.text_snippet_outlined, size: 32,),
                                title: Text("Terms of Use", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 22),),
                                trailing: Icon(Icons.open_in_new, color: Colors.grey, size: 16,),
                              ),
                              const Divider(indent: 20, endIndent: 20,),
                              const ListTile(
                                leading: Icon(Icons.beenhere_outlined, size: 32,),
                                title: Text("Privacy Policy", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 22),),
                                trailing: Icon(Icons.open_in_new, color: Colors.grey, size: 16,),
                              ),
                              const Divider(indent: 20, endIndent: 20,),
                              ListTile(
                                leading: const Icon(Icons.account_tree_outlined, size: 32,),
                                title: const Text("OS Version", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 22),),
                                trailing: StreamBuilder(
                                  stream: osVersionBloc.osVersionStream,
                                  builder: (context, snapshot) {
                                    if (snapshot.hasData) {
                                      return Text(snapshot.data ?? "No Data", style: const TextStyle(fontSize: 16),);
                                    } else {
                                      return const Text("Loading...");
                                    }
                                  },
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  );
                },
                color: Colors.black,
              ),
              const Text("Settings", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 11, color: Colors.black),)
            ]
          ),
          const SizedBox(),
        ],
      ),
    );
  }
}