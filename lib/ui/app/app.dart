import 'package:financial_planner_mobile/ui/app/screens/assets.dart';
import 'package:financial_planner_mobile/ui/app/screens/expenses.dart';
import 'package:financial_planner_mobile/ui/app/screens/income.dart';
import 'package:financial_planner_mobile/ui/app/screens/liabilities.dart';
import 'package:financial_planner_mobile/util/theme.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class App extends StatefulWidget {
  const App({super.key});

  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> {
  int selected = 0;

  final List<String>  list = [
    'Income',
    'Expenses',
    'Assets',
    'Liabilities'
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: selected,
        children: const [
          IncomePage(),
          ExpensesPage(),
          AssetsPage(),
          LiabilitiesPage(),
        ],
      ),
      appBar: AppBar(
        title: Text(list[selected]),
        backgroundColor: lightTheme.surfaceContainer,
        actions: [
          PopupMenuButton(
            onSelected: (value) async {
              if (value == 'Log out') {
                await FirebaseAuth.instance.signOut();
              }
            },

            offset: const Offset(0, 50),
            itemBuilder: (BuildContext context) {
              return const [

                PopupMenuItem(
                  value: 'Log out',
                  child: Text('Log out'),
                ),
              ];
            },
          ),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        currentIndex: selected,
        items: const [
          BottomNavigationBarItem(
              icon: Icon(Icons.attach_money), label: "Income"),
          BottomNavigationBarItem(
              icon: Icon(Icons.shopping_bag), label: "Expenses"),
          BottomNavigationBarItem(icon: Icon(Icons.house), label: "Assets"),
          BottomNavigationBarItem(
              icon: Icon(Icons.payment), label: "Liabilities")
        ],
        onTap: (index) {
          setState(() {
            selected = index;
          });
        },
      ),
    );
  }
}
