// import 'package:flutter/material.dart';
// // import 'drawer_item_model.dart';

// class CustomDrawer extends StatefulWidget {
//   final List<DrawerItem> mainItems;
//   final List<DrawerItem>? settingsItems;
//   final DrawerItem? logoutItem;
//   final String userName;
//   final String userEmail;
//   final String profileImageUrl;

//   const CustomDrawer({
//     super.key,
//     required this.mainItems,
//     this.settingsItems,
//     this.logoutItem,
//     required this.userName,
//     required this.userEmail,
//     required this.profileImageUrl,
//   });

//   @override
//   State<CustomDrawer> createState() => _CustomDrawerState();
// }

// class _CustomDrawerState extends State<CustomDrawer> {
//   int _selectedIndex = -1;

//   Widget _buildDrawerSection(String title, List<DrawerItem> items, {bool highlight = false}) {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         if (title.isNotEmpty)
//           Padding(
//             padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8),
//             child: Text(title.toUpperCase(), style: const TextStyle(color: Colors.grey, fontWeight: FontWeight.bold)),
//           ),
//         ...items.asMap().entries.map((entry) {
//           final index = entry.key;
//           final item = entry.value;

//           final itemIndex = highlight ? widget.mainItems.length + index : index;

//           return ListTile(
//             leading: Icon(item.icon, color: _selectedIndex == itemIndex ? Colors.blue : Colors.black),
//             title: Text(item.title),
//             selected: _selectedIndex == itemIndex,
//             onTap: () {
//               setState(() => _selectedIndex = itemIndex);
//               Navigator.pop(context); // Close drawer
//               item.onTap();
//             },
//           );
//         }),
//         const Divider(),
//       ],
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Drawer(
//       child: SafeArea(
//         child: Column(
//           children: [
//             // User Info
//             UserAccountsDrawerHeader(
//               accountName: Text(widget.userName),
//               accountEmail: Text(widget.userEmail),
//               currentAccountPicture: CircleAvatar(
//                 backgroundImage: NetworkImage(widget.profileImageUrl),
//               ),
//               decoration: const BoxDecoration(color: Colors.blue),
//             ),

//             // Main Section
//             Expanded(
//               child: ListView(
//                 padding: EdgeInsets.zero,
//                 children: [
//                   _buildDrawerSection("Main", widget.mainItems, highlight: true),
//                   if (widget.settingsItems != null) _buildDrawerSection("Settings", widget.settingsItems!),
//                 ],
//               ),
//             ),

//             // Logout
//             if (widget.logoutItem != null)
//               Column(
//                 children: [
//                   const Divider(),
//                   ListTile(
//                     leading: Icon(widget.logoutItem!.icon, color: Colors.red),
//                     title: Text(widget.logoutItem!.title, style: const TextStyle(color: Colors.red)),
//                     onTap: widget.logoutItem!.onTap,
//                   ),
//                 ],
//               ),
//           ],
//         ),
//       ),
//     );
//   }
// }
