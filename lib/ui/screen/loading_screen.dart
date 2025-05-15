import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:notrenetflix/constance.dart';
import 'package:notrenetflix/repositories/data_repository.dart';
import 'package:notrenetflix/ui/screen/home_screen.dart';
import 'package:provider/provider.dart';

class LoadingScreen extends StatefulWidget {
  const LoadingScreen({super.key});

  @override
  State<LoadingScreen> createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> {
  @override
  void initState() {
    super.initState();
    initData();
  }

  void initData() async {
    final dataProvider = Provider.of<DataRepository>(context, listen: false);
    await dataProvider.iniData();
    Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (context) => HomeScreen()));
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        color: kBackgroundColor,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const SizedBox(
              height: 200,
            ),
            Image.asset(
              'assets/images/netflix_logo_1.png',
              fit: BoxFit.cover,
            ),
            const SizedBox(
              height: 20,
            ),
            SpinKitFadingCircle(
              color: kPrimaryColor,
              size: 50.0,
            )
          ],
        ));
  }
}
