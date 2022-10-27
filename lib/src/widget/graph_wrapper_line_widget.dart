import 'package:flutter/material.dart';
import 'package:map_fields/map_fields.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

import '../graph_wrapper_widget.dart';

class GraphWrapperLineWidget extends GraphWrapperWidget {
  final String title;
  final String labelFormat;
  final List<GraphWrapperLineDataValue> values;
  GraphWrapperLineWidget({
    required this.title,
    required this.labelFormat,
    required this.values,
  });

  factory GraphWrapperLineWidget.fromMap(Map<String, dynamic> map) {
    final f = MapFields.load(map);
    return GraphWrapperLineWidget(
      title: f.getString('title', ''),
      labelFormat: f.getString('label_format', '{value}'),
      values: f
          .getList<Map<String, dynamic>>('values', [])
          .map((e) => GraphWrapperLineDataValue.fromMap(e))
          .toList(),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'title': title,
      'values': values.map((e) => e.toMap()).toList(),
    };
  }

  List<LineSeries<GraphWrapperLineDataValue, T>> _getDefaultLineSeries<T>() {
    final subTitles = values.map((e) => e.subtitle).toList().toSet().toList();
    return subTitles
        .map(
          (subTitle) => LineSeries<GraphWrapperLineDataValue, T>(
            animationDuration: 2500,
            dataSource: values.where((e) => e.subtitle == subTitle).toList(),
            xValueMapper: (GraphWrapperLineDataValue data, _) {
              if (data.type == 'date_time_year') {
                return data.division.year;
              }
              if (data.type == 'date_time') {
                return data.division.year;
              }
              return data.division;
            },
            yValueMapper: (GraphWrapperLineDataValue data, _) => data.value,
            width: 2,
            name: subTitle,
            markerSettings: const MarkerSettings(isVisible: true),
          ),
        )
        .toList();
  }

  @override
  Widget build() {
    return SfCartesianChart(
      plotAreaBorderWidth: 0,
      title: ChartTitle(text: title),
      legend: Legend(
        isVisible: true,
        overflowMode: LegendItemOverflowMode.wrap,
      ),
      primaryXAxis: NumericAxis(
        edgeLabelPlacement: EdgeLabelPlacement.shift,
        interval: 2,
        majorGridLines: const MajorGridLines(width: 0),
      ),
      primaryYAxis: NumericAxis(
        labelFormat: labelFormat,
        axisLine: const AxisLine(width: 0),
        majorTickLines: const MajorTickLines(color: Colors.transparent),
      ),
      series: _getDefaultLineSeries(),
      tooltipBehavior: TooltipBehavior(enable: true),
    );
  }
}

class GraphWrapperLineDataValue {
  final String subtitle;
  final dynamic division;
  final double value;
  final String type;
  GraphWrapperLineDataValue({
    required this.subtitle,
    required this.division,
    required this.value,
    required this.type,
  });

  factory GraphWrapperLineDataValue.fromMap(Map<String, dynamic> map) {
    final f = MapFields.load(map);

    return GraphWrapperLineDataValue(
      subtitle: f.getString('subtitle', ''),
      division: getDivision(map, f.getString('type', 'int')),
      value: f.getDouble('value', 0),
      type: f.getString('type', 'int'),
    );
  }

  static dynamic getDivision(
    Map<String, dynamic> map,
    String type,
  ) {
    final f = MapFields.load(map);
    switch (type) {
      case 'date_time':
        return f.getDateTime('division', DateTime(0));
      case 'date_time_year':
        return f.getDateTime('division', DateTime(0));
      default:
        return f.getInt('division', 0);
    }
  }

  Map<String, dynamic> toMap() {
    return {
      'subtitle': subtitle,
      'division': division,
      'value': value,
    };
  }
}
