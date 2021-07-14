import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:timeline_tile/timeline_tile.dart';

Widget deliveryStatues()=> TimelineTile(

  axis: TimelineAxis.horizontal,
  indicatorStyle: IndicatorStyle(iconStyle: IconStyle(iconData: Icons.ac_unit),color: Colors.purple,),
  hasIndicator: true,
  // afterLineStyle: ,
    lineXY: 0.4,
  alignment: TimelineAlign.manual,
  endChild: Text("Pending")
);