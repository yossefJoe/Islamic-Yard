import 'package:flutter/material.dart';
import 'package:islamic/Constants/Constants.dart';
import 'package:islamic/Constants/Provider_Methods.dart';
import 'package:islamic/Presentation/Widgets/CustomAppBar.dart';
import 'package:provider/provider.dart';
import 'package:sleek_circular_slider/sleek_circular_slider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class ChosenTasbeeh extends StatelessWidget {
  ChosenTasbeeh({super.key, this.tasbeeh});
  final String? tasbeeh;
  int num = 0;
  @override
  Widget build(BuildContext context) {
    return Consumer<IslamYardModel>(
      builder: (context, v, child) {
        final ThemeData theme = Theme.of(context);

        return Scaffold(
          appBar: MyCustomAppbar(
              AppLocalizations.of(context)!.tasbeehcounter, context, [
            IconButton(
                onPressed: () {
                  v.start_over();
                },
                icon: Icon(
                  Icons.refresh,
                  color: Colors.white,
                ))
          ]),
          body: Center(
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                Text(
                  tasbeeh!,
                  style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                ),
                SleekCircularSlider(
                  innerWidget: (percentage) {
                    return Center(
                        child: Text(
                      "${percentage.toInt()}",
                      style: TextStyle(
                          color: theme.brightness == Brightness.light
                              ? primary_color
                              : Colors.white,
                          fontSize: 30,
                          fontWeight: FontWeight.bold),
                    ));
                  },
                  initialValue: v.progress_value,
                  onChangeStart: (value) {},
                  min: 0,
                  max: 33,
                  appearance: CircularSliderAppearance(
                      counterClockwise: true,
                      startAngle: 120,
                      angleRange: 360,
                      customColors: CustomSliderColors(
                          trackColor: theme.brightness == Brightness.light
                              ? Colors.grey
                              : Colors.white,
                          dotColor: Colors.white,
                          progressBarColor: theme.brightness == Brightness.light
                              ? primary_color
                              : Colors.amber)),
                  onChange: (double value) {
                    print('Current value: $value');
                  },
                ),
                MaterialButton(
                    color: third_color,
                    minWidth: MediaQuery.of(context).size.width * 0.6,
                    height: 100,
                    onPressed: () {
                      v.count_tasbeeh();
                    },
                    child: Text(
                      AppLocalizations.of(context)!.sabah,
                      style: TextStyle(fontSize: 20, color: Colors.black),
                    )),
              ])),
        );
      },
    );
  }
}
