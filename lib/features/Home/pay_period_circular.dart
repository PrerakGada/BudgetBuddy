import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_gauges/gauges.dart';

class PayPeriodCircular extends StatelessWidget {
  const PayPeriodCircular({super.key});
  static const String id = '/pay_period_circular';

  @override
  Widget build(BuildContext context) {
    return SfRadialGauge(axes: <RadialAxis>[
      RadialAxis(
        minimum: 0,
        maximum: 100,
        showLabels: false,
        showTicks: false,
        startAngle: 270,
        endAngle: 270,
        axisLineStyle: AxisLineStyle(
          thickness: 0.15,
          color: Colors.blue.withOpacity(0.3),
          thicknessUnit: GaugeSizeUnit.factor,
        ),
        pointers: const <GaugePointer>[
          RangePointer(
              value: 45,
              width: 0.15,
              sizeUnit: GaugeSizeUnit.factor,
              cornerStyle: CornerStyle.startCurve,
              gradient: SweepGradient(
                  colors: <Color>[Colors.blue, Colors.blue],
                  stops: <double>[0.25, 0.75])),
          MarkerPointer(
            value: 45,
            markerWidth: 20,
            markerHeight: 20,
            markerType: MarkerType.circle,
            color: Colors.blue,
          )
        ],
      )
    ]);
  }
}
