import 'package:dapps/bloc/dashboard/dashboard_bloc.dart';
import 'package:dapps/ui/deposit_page.dart';
import 'package:dapps/ui/widgets/button.dart';
import 'package:dapps/ui/withdraw_page.dart';
import 'package:flutter/material.dart';

class DashboardPage extends StatefulWidget {
  const DashboardPage({super.key});

  @override
  State<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  final DashboardBloc _dashboardBloc = DashboardBloc();
  @override
  void initState() {
    _dashboardBloc.add(DashboardInitialFetch());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("web 3 bank"),
        backgroundColor: Colors.amberAccent,
      ),
      body: Container(
        margin: EdgeInsets.symmetric(horizontal: 16, vertical: 16),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                  'assets/logo.png',
                  height: 50,
                  width: 50,
                ),
                const SizedBox(
                  width: 12,
                ),
                Text(
                  "10 ETH",
                  style: TextStyle(fontSize: 50, fontWeight: FontWeight.bold),
                ),
              ],
            ),
            const SizedBox(
              width: 12,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                InkWell(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => DebitPage(),
                        ));
                  },
                  child: MyButton(
                    text: "DEBIT",
                    warna: Colors.redAccent,
                    width: 100,
                    height: 70,
                  ),
                ),
                InkWell(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => WithdrawPage(),
                        ));
                  },
                  child: MyButton(
                    text: "CREDIT",
                    warna: Colors.greenAccent,
                    width: 100,
                    height: 70,
                  ),
                )
              ],
            ),
            const SizedBox(
              height: 50,
            ),
            const Text(
              "Latest Transaction",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
            ),
            Container(
              width: MediaQuery.sizeOf(context).width,
              height: 80,
              decoration: BoxDecoration(
                  color: Colors.blueGrey,
                  borderRadius: BorderRadius.circular(15)),
              child: const Padding(
                padding: EdgeInsets.all(9),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Flexible(
                      flex: 2,
                      child: Text(
                        "1 ETH",
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                    Flexible(
                      flex: 1,
                      child: Text(
                        "0xD4C6B01Eb42Ee266fc79cC280e438B1714165ACD",
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                    Flexible(
                        flex: 1,
                        child: Text(
                          "NFT PURCHASE",
                          style: TextStyle(color: Colors.greenAccent),
                        ))
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
