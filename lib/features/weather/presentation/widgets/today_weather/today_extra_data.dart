import 'package:flutter/material.dart';

import '../../../../../core/core.dart';
import '../../../domain/entities/today_weather/today_weather.dart';

class TodayExtraData extends StatelessWidget {
  TodayWeather todayWeather;
  TodayExtraData(this.todayWeather, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all( Dimens.space24),
      decoration: BoxDecoration(
          border: Border.all(width: 0.2, color: Colors.white),
          borderRadius:
              BorderRadius.circular( Dimens.space36)),
      child: Column(
        children: [
          Text(
            todayWeather.current.toString() + "\u00B0",
            style: TextStyle(
                color: Colors.white,
                decoration: TextDecoration.none,
                fontSize:  Dimens.space16,),
          ),
          SizedBox(
            height: Dimens.space6,
          ),
          Image(
            image: AssetImage(todayWeather.image),
            width: Dimens.space50,
            height:  Dimens.space50,
          ),
          SizedBox(
            height: Dimens.space50,
          ),
          Text(
            todayWeather.time,
            style: TextStyle(
                decoration: TextDecoration.none,
                fontSize:  Dimens.space16,
                color: Colors.grey),
          )
        ],
      ),
    );
  }
}
