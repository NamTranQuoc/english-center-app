import 'package:english_center/components/background/background.dart';
import 'package:english_center/domain/Member.dart';
import 'package:english_center/domain/Score.dart';
import 'package:english_center/providers/MemberProvider.dart';
import 'package:english_center/util/ParseUtil.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:provider/provider.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class ReportScore extends StatefulWidget {
  static const routeName = '/report_score';

  ReportScore();

  @override
  _ReportScore createState() => _ReportScore();
}

class _ReportScore extends State<ReportScore> {
  List<Score> get() {
    List<Score> result = [];
    Member member =
        Provider.of<MemberProvider>(context, listen: false).currentMember;
    if (null != member.logScore) {
      for (var element in member.logScore!) {
        Score score = Score.fromJson(element);
        result.add(score);
      }
    }
    return result;
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Member member =
        Provider.of<MemberProvider>(context, listen: false).currentMember;
    print(member.logScore);
    if (null != member.logScore) {
      for (var element in member.logScore!) {
        Score score = Score.fromJson(element);
        chartData.add(score);
        setState(() {});
      }
    }
  }

  final List<Score> chartData = [];

  @override
  Widget build(BuildContext context) {
    return Background(
      isShowIcon: true,
      child: Padding(
        padding: const EdgeInsets.fromLTRB(10, 50, 10, 10),
        child: ListView(
          children: [
            Container(
              alignment: Alignment.centerLeft,
              padding: const EdgeInsets.symmetric(horizontal: 30),
              child: Text(
                AppLocalizations.of(context).labelScore,
                style: const TextStyle(
                  fontSize: 32,
                  color: Color(0xFF2661FA),
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.left,
              ),
            ),
            const SizedBox(height: 40.0),
            Row(
              children: [
                const SizedBox(
                  width: 60,
                ),
                Container(
                    width: 12.0,
                    height: 12.0,
                    decoration: const BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(2)),
                        color: Colors.blue)),
                Container(
                  padding: const EdgeInsets.only(left: 10),
                  child: Text(AppLocalizations.of(context).total),
                )
              ],
            ),
            Row(
              children: [
                const SizedBox(
                  width: 60,
                ),
                Container(
                    width: 12.0,
                    height: 12.0,
                    decoration: const BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(2)),
                        color: Colors.red)),
                Container(
                  padding: const EdgeInsets.only(left: 10),
                  child: Text(AppLocalizations.of(context).readScore),
                )
              ],
            ),
            Row(
              children: [
                const SizedBox(
                  width: 60,
                ),
                Container(
                    width: 12.0,
                    height: 12.0,
                    decoration: const BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(2)),
                        color: Colors.green)),
                Container(
                  padding: const EdgeInsets.only(left: 10),
                  child: Text(AppLocalizations.of(context).listenScore),
                )
              ],
            ),
            const SizedBox(height: 20.0),
            SizedBox(
                height: 450,
                child: SfCartesianChart(
                    enableAxisAnimation: true,
                    title:
                        ChartTitle(text: AppLocalizations.of(context).report),
                    primaryXAxis: CategoryAxis(
                        title: AxisTitle(
                            text: AppLocalizations.of(context).examDate)),
                    primaryYAxis: NumericAxis(
                        title:
                            AxisTitle(text: AppLocalizations.of(context).score),
                        rangePadding: ChartRangePadding.additional,
                        // Assigned a name for the y-axis for customization purposes
                        name: 'primaryYAxis'),
                    series: <ChartSeries>[
                      SplineSeries<Score, String>(
                          dataSource: chartData,
                          xValueMapper: (Score data, _) => timestampToString(
                              data.date!,
                              format: "dd/MM/yyyy"),
                          yValueMapper: (Score data, _) => data.total!,
                          dataLabelSettings: DataLabelSettings(
                              isVisible: true, color: Colors.blue),
                          markerSettings: MarkerSettings(isVisible: true),
                          color: Colors.blue),
                      SplineSeries<Score, String>(
                          dataSource: chartData,
                          xValueMapper: (Score data, _) => timestampToString(
                              data.date!,
                              format: "dd/MM/yyyy"),
                          yValueMapper: (Score data, _) => data.read!,
                          dataLabelSettings: DataLabelSettings(
                              isVisible: true, color: Colors.red),
                          markerSettings: MarkerSettings(isVisible: true),
                          color: Colors.red),
                      SplineSeries<Score, String>(
                          dataSource: chartData,
                          xValueMapper: (Score data, _) => timestampToString(
                              data.date!,
                              format: "dd/MM/yyyy"),
                          yValueMapper: (Score data, _) => data.listen!,
                          dataLabelSettings: DataLabelSettings(
                              isVisible: true, color: Colors.green),
                          markerSettings: MarkerSettings(isVisible: true),
                          color: Colors.green)
                    ]))
          ],
        ),
      ),
    );
  }
}
