import 'package:flutter/material.dart';
import 'package:islamic/Constants/Constants.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:islamic/Presentation/Pages/Home_Page/Home_Page.dart';

class WelcomePage extends StatelessWidget {
  const WelcomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);

    return Scaffold(
      body: ListView(
        physics: NeverScrollableScrollPhysics(),
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Container(
                child: ClipRRect(
                  borderRadius: BorderRadius.only(
                      bottomRight: Radius.circular(40),
                      bottomLeft: Radius.elliptical(20, 80)),
                  child: Image.asset(
                    "Assets/Images/mosque.jpg",
                    fit: BoxFit.cover,
                    filterQuality: FilterQuality.high,
                  ),
                ),
                height: MediaQuery.of(context).size.height * 0.5,
                width: double.infinity,
              ),
              Text(
                AppLocalizations.of(context)!.islamicyard,
                style: TextStyle(
                    fontSize: 40,
                    fontWeight: FontWeight.bold,
                    color: theme.brightness == Brightness.light
                        ? primary_color
                        : Colors.white),
              ),
              Text(
                AppLocalizations.of(context)!.bio,
                textAlign: TextAlign.center,
                style: TextStyle(
                    color: theme.brightness == Brightness.light
                        ? primary_color
                        : Colors.white.withOpacity(0.8),
                    fontSize: 30),
              ),
              HeightSizedBox(),
              Container(
                height: MediaQuery.of(context).size.width * 0.15,
                width: MediaQuery.of(context).size.width * 0.4,
                child: MaterialButton(
                    color: primary_color,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Text(
                          AppLocalizations.of(context)!.getstarted,
                          style: TextStyle(color: Colors.white),
                        ),
                        Icon(
                          Icons.arrow_forward_outlined,
                          color: Colors.white,
                        )
                      ],
                    ),
                    height: 200,
                    minWidth: 100,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30)),
                    onPressed: () {
                      Navigator.of(context)
                          .push(MaterialPageRoute(builder: (context) {
                        return HomePage();
                      }));
                    }),
              )
            ],
          ),
        ],
      ),
    );
  }
}
