import 'package:flutter/material.dart';
import 'PurchaseForm.dart';
import 'AllFiledIndents.dart';
import 'SavedIndents.dart';
import 'Inbox.dart';
import '../../utils/sidebar.dart';

class PurchaseMainScreen extends StatefulWidget {
  final int initialTab;

  const PurchaseMainScreen({super.key, this.initialTab = 0});

  @override
  State<PurchaseMainScreen> createState() => _PurchaseMainScreenState();
}

class _PurchaseMainScreenState extends State<PurchaseMainScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  late int selectedIndex;

  final List<Widget> screens = [
    const PurchaseForm(),
    const AllFiledIndents(),
    const InboxScreen(),       // ✅ Added Inbox screen here
    const SavedIndents(),
  ];

  final List<String> tabs = [
    "Indent Form",
    "All Filed",
    "Inbox",                  // ✅ Added Inbox tab here
    "Saved Indents",
  ];

  @override
  void initState() {
    super.initState();
    selectedIndex = widget.initialTab;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      drawer: const Sidebar(),
      appBar: AppBar(
        title: const Text(
          'Purchase',
          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
        ),
        elevation: 0,
        backgroundColor: Colors.blue.shade700,
        leading: IconButton(
          icon: const Icon(Icons.menu, color: Colors.white),
          onPressed: () => _scaffoldKey.currentState!.openDrawer(),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.notifications, color: Colors.white),
            onPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text("No new notifications"),
                  duration: Duration(seconds: 1),
                ),
              );
            },
          ),
        ],
      ),
      body: Column(
        children: [
          Container(
            width: double.infinity,
            decoration: BoxDecoration(
              color: Colors.blue.shade700,
              borderRadius: const BorderRadius.only(
                bottomLeft: Radius.circular(80),
                bottomRight: Radius.circular(80),
              ),
            ),
            padding: const EdgeInsets.only(
              left: 20.0,
              right: 20.0,
              bottom: 16.0,
              top: 12.0,
            ),
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: List.generate(
                  tabs.length,
                      (index) => _buildNavButton(tabs[index], index),
                ),
              ),
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: screens[selectedIndex],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildNavButton(String text, int index) {
    final bool isSelected = selectedIndex == index;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 6),
      child: GestureDetector(
        onTap: () {
          setState(() {
            selectedIndex = index;
          });
        },
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 18),
          decoration: BoxDecoration(
            color: isSelected ? Colors.white : Colors.blue.shade600,
            borderRadius: BorderRadius.circular(20),
            boxShadow: const [
              BoxShadow(
                color: Colors.black26,
                blurRadius: 4,
                offset: Offset(0, 2),
              ),
            ],
          ),
          child: Text(
            text,
            style: TextStyle(
              color: isSelected ? Colors.blue.shade700 : Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 14,
            ),
          ),
        ),
      ),
    );
  }
}
