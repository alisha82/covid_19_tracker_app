import 'package:covid_19/Model/worldStateModel.dart';
import 'package:covid_19/Services/state_services.dart';
import 'package:covid_19/view/countries_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'dart:math' as math;

import 'package:pie_chart/pie_chart.dart';

    class WorldState extends StatefulWidget {
      const WorldState({super.key});
    
      @override
      State<WorldState> createState() => _WorldStateState();
    }
    
    class _WorldStateState extends State<WorldState> with TickerProviderStateMixin{
      late final AnimationController _controller = AnimationController(
          duration: const Duration(seconds: 3),
          vsync: this)..repeat();
      @override
      void dispose(){
        super.dispose();
        _controller.dispose();
      }

      final colorList = <Color> [
        Color(0xff4285f4),
        Color(0xff1aa260),
        Color(0xffde5246),

      ];
      @override
      Widget build(BuildContext context) {
        StateServices stateServices = StateServices();
        return Scaffold(

          body: Padding(
            padding: EdgeInsets.all(15.0),
            child: Column(
              children: [
                SizedBox(height: MediaQuery.of(context).size.height * .01,),
                Expanded(
                  child: FutureBuilder(
                      future: stateServices.fetchWorldStateRecord(),
                      builder:(context, AsyncSnapshot<WorldStateModel> snapshot){
                        if(!snapshot.hasData){
                          return Expanded(
                            flex: 1,
                              child: SpinKitFadingCircle(
                                color: Colors.grey,
                                size: 50,
                                controller: _controller,
                              ),
                  
                          );
                        }else{
                          return SingleChildScrollView(
                            child: Column(
                              children: [
                                PieChart(
                                  // dataMap: {
                                  //   'Total' : double.parse(snapshot.data!.cases!.toString()),
                                  //   'Recovered' : double.parse(snapshot.data!.recovered.toString()),
                                  //   'Deaths' : double.parse(snapshot.data!.deaths.toString()),
                                  // },
                                  dataMap: {
                                    "Total": double.parse(snapshot.data!.cases!.toString()),
                                    "Recovered": double.parse(snapshot.data!.recovered.toString()),
                                    "Deaths": double.parse(snapshot.data!.deaths.toString()),
                  
                                  },
                                  chartValuesOptions: ChartValuesOptions(
                                    showChartValuesInPercentage: true,
                                  ),
                                  animationDuration: Duration(milliseconds: 1200),
                                  chartRadius: MediaQuery.of(context).size.width / 3.2,
                                  legendOptions: LegendOptions(
                                      legendPosition: LegendPosition.left
                                  ),
                                  chartType: ChartType.ring,
                                  colorList: colorList,
                                ),
                                Padding(
                                  padding: EdgeInsets.symmetric(vertical: MediaQuery.of(context).size.height * .06),
                                  child: Card(
                                    child: SingleChildScrollView(
                                      child: Column(
                                        children: [
                                          SizedBox(height: MediaQuery.of(context).size.height * 0.02),
                                          ReusableRow(title: 'Total', value: snapshot.data!.cases.toString()),
                                          ReusableRow(title: 'Recovered', value: snapshot.data!.recovered.toString(),),
                                          ReusableRow(title: 'Deaths', value: snapshot.data!.deaths.toString(),),
                                          ReusableRow(title: 'Active', value: snapshot.data!.active.toString(),),
                                          ReusableRow(title: 'Critical', value: snapshot.data!.critical.toString(),),
                                          ReusableRow(title: 'Today Deaths', value: snapshot.data!.todayDeaths.toString(),),
                                          ReusableRow(title: 'Today Recovered', value: snapshot.data!.todayRecovered.toString(),),
                                          SizedBox(height: MediaQuery.of(context).size.height * 0.02),


                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                                GestureDetector(
                                  onTap: (){
                                    Navigator.push(context, MaterialPageRoute(
                                        builder: (context) => CountriesList()));
                                  },
                                  child: Container(
                                    height: 50,
                                    decoration: BoxDecoration(
                                      color: Color(0Xff1aa260),
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    child: Center(
                                      child: Text('Track Countries', style: TextStyle(
                                          color: Colors.white
                                      ),
                                      ),
                                    ),
                                  ),
                                )
                  
                              ],
                            ),
                          );
                        }
                      }
                  ),
                )
              ],
            ),
          ),
        );
      }
    }

    class ReusableRow extends StatelessWidget {
      String title, value;
      ReusableRow({super.key, required this.title, required this.value});

      @override
      Widget build(BuildContext context) {
        return Padding(
          padding: EdgeInsets.only(left: 10, right: 10, top: 10, bottom: 10),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(title),
                  Text(value),
                ],
              ),
              SizedBox(height: 5,),
              Divider(),
            ],
          ),
        );
      }
    }
