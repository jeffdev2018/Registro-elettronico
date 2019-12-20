import 'package:flutter/material.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:registro_elettronico/utils/entity/overall_stats.dart';
import 'package:registro_elettronico/utils/global_utils.dart';

class GradesOverallStats extends StatelessWidget {
  final OverallStats stats;
  const GradesOverallStats({Key key, @required this.stats}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(5.0),
        ),
        child: Container(
          padding: EdgeInsets.all(16.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  CircularPercentIndicator(
                    radius: 80.0,
                    lineWidth: 6.0,
                    percent: stats.average / 10,
                    animation: true,
                    animationDuration: 300,
                    center: new Text(stats.average.toStringAsFixed(2)),
                    progressColor: GlobalUtils.getColorFromGrade(stats.average),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 8.0),
                    child: Text('Average'),
                  )
                ],
              ),
              Wrap(
                alignment: WrapAlignment.center,
                crossAxisAlignment: WrapCrossAlignment.start,
                direction: Axis.vertical,
                children: <Widget>[
                  Text('Sufficienze: ${stats.sufficienze}',
                      style: TextStyle(fontSize: 15)),
                  Text(
                    'Insufficienze: ${stats.insufficienze}',
                    style: TextStyle(fontSize: 15),
                  ),
                  Text('Voto minimo: ${stats.votoMin}',
                      style: TextStyle(fontSize: 15)),
                  Text('Voto massimo: ${stats.votoMin}',
                      style: TextStyle(fontSize: 15)),
                  Text('Voto max: ${stats.bestSubject.name}',
                      style: TextStyle(fontSize: 15)),
                  Text(
                      'Miglior materia:  ${GlobalUtils.reduceSubjectTitle(stats.worstSubject.name)}',
                      style: TextStyle(fontSize: 15)),
                  Text('Crediti:  ${stats.votoMax}',
                      style: TextStyle(fontSize: 15)),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
