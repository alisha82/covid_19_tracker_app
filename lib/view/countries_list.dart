import 'package:covid_19/view/detail_screen.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
import 'package:provider/provider.dart';
import '../Services/covid_provider.dart';


class CountriesList extends StatefulWidget {
  const CountriesList({super.key});

  @override
  State<CountriesList> createState() => _CountriesListState();
}

class _CountriesListState extends State<CountriesList> {
  TextEditingController searchcontroller = TextEditingController();

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      ),
      body: SafeArea(child: Column(
        children: [
          Padding(
            padding: EdgeInsets.all(8.0),
            child: TextFormField(
              controller: searchcontroller,
              onChanged: (value){
                Provider.of<CovidProvider>(context, listen: false).setSearchQuery(value);
              },
              decoration: InputDecoration(
                contentPadding: EdgeInsets.symmetric(horizontal: 20),
                hintText: 'Search with Country name',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(50.0),
                )
              ),
            ),
          ),
          Expanded(child: FutureBuilder(
              future: Provider.of<CovidProvider>(context, listen: false).countryListApi(),
              builder: (context, AsyncSnapshot<List<dynamic>> snapshot){

                if(!snapshot.hasData){
                  return ListView.builder(
                      itemCount: 4,
                      itemBuilder: (context, index){
                        return Shimmer.fromColors(

                            baseColor: Colors.grey.shade700,
                            highlightColor: Colors.grey.shade100,
                          child: Column(
                            children: [
                              ListTile(
                                title: Container(
                                  height: 10, width: 89, color: Colors.white,

                          ),
                                subtitle:Container(
                                  height: 10, width: 89, color: Colors.white,

                                ),
                                leading:Container(
                                  height: 50, width: 50, color: Colors.white,

                                ),

                              ), ],
                          ),
                        );

                      });

                }else{
                  return Consumer<CovidProvider>(
                    builder: (context, provider, childe){
                      return ListView.builder(
                          itemCount: snapshot.data!.length,
                          itemBuilder: (context, index){
                            String name = snapshot.data![index]['country'].toString();
                            if(searchcontroller.text.isEmpty){
                              return Column(
                                children: [
                                  InkWell(
                                    onTap: (){
                                      Navigator.push(context, MaterialPageRoute(
                                          builder: (context) => DetailScreen(
                                            image:  snapshot.data![index]['countryInfo']['flag'],
                                            name: snapshot.data![index]['country'].toString(),
                                            totalCases: snapshot.data![index]['cases']??0,
                                            todayRecovered: snapshot.data![index]['todayRecovered']??0,
                                            totalDeaths: snapshot.data![index]['deaths']??0,
                                            active: snapshot.data![index]['active']??0,
                                            test: snapshot.data![index]['tests']??0,
                                            critical : snapshot.data![index]['critical']??0,
                                            totalRecovered : snapshot.data![index]['recovered']??0,

                                          )));
                                    },
                                    child: ListTile(
                                      title: Text(
                                        snapshot.data![index]['country'].toString(),
                                      ),
                                      subtitle: Text(
                                        snapshot.data![index]['cases'].toString(),
                                      ),
                                      leading: Image(
                                        image: NetworkImage(
                                            snapshot.data![index]['countryInfo']['flag']),),
                                    ),
                                  ),

                                ],
                              );
                            }else if(name.toLowerCase().contains(provider.searchQuery.toLowerCase())){
                              return Column(
                                children: [
                                  InkWell(
                                    onTap: (){
                                      Navigator.push(context, MaterialPageRoute(
                                          builder: (context) => DetailScreen(
                                            image:  snapshot.data![index]['countryInfo']['flag'],
                                            name: snapshot.data![index]['country'].toString(),
                                            totalCases: snapshot.data![index]['cases']??0,
                                            todayRecovered: snapshot.data![index]['todayRecovered']??0,
                                            totalDeaths: snapshot.data![index]['deaths']??0,
                                            active: snapshot.data![index]['active']??0,
                                            test: snapshot.data![index]['tests']??0,
                                            critical : snapshot.data![index]['critical']??0,
                                            totalRecovered : snapshot.data![index]['recovered']??0,

                                          )));
                                    },
                                    child: ListTile(
                                      title: Text(
                                        snapshot.data![index]['country'].toString(),
                                      ),
                                      subtitle: Text(
                                        snapshot.data![index]['cases'].toString(),
                                      ),
                                      leading: Image(
                                        image: NetworkImage(
                                            snapshot.data![index]['countryInfo']['flag']),),
                                    ),
                                  ),

                                ],
                              );
                            }else{
                              return Container();
                            }

                          },
                          );

                    },



                  );
                }

              }))
        ],
      )),
    );
  }
}

