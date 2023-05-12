import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter/widgets.dart';
import 'package:shimmer/shimmer.dart';

import '../Services/states_service.dart';
import 'detail_screen.dart';

class CountriesList extends StatefulWidget {
  const CountriesList({super.key});

  @override
  State<CountriesList> createState() => _CountriesListState();
}

class _CountriesListState extends State<CountriesList> {
  TextEditingController searchController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    StateServices stateservices = StateServices();

    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      ),
      body: SafeArea(
          child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8),
            child: TextFormField(
              onChanged: (value) {
                setState(() {});
              },
              controller: searchController,
              decoration: InputDecoration(
                  contentPadding: const EdgeInsets.symmetric(horizontal: 20),
                  hintText: "Search With Country Name",
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(50))),
            ),
          ),
          Expanded(
            child: FutureBuilder(
                future: stateservices.getCountryStat(),
                builder: (context, AsyncSnapshot<List<dynamic>> snapshot) {
                  if (!snapshot.hasData) {
                    return ListView.builder(
                        itemCount: 10,
                        itemBuilder: (context, index) {
                          return Shimmer.fromColors(
                              baseColor: Colors.grey.shade700,
                              highlightColor: Colors.grey.shade100,
                              child: Column(
                                children: [
                                  ListTile(
                                    leading: Container(
                                      height: 50,
                                      width: 50,
                                      color: Colors.white,
                                    ),
                                    title: Container(
                                      height: 10,
                                      width: 80,
                                      color: Colors.white,
                                    ),
                                    subtitle: Container(
                                      height: 10,
                                      width: 80,
                                      color: Colors.white,
                                    ),
                                  )
                                ],
                              ));
                        });
                  } else {
                    return ListView.builder(
                        itemCount: snapshot.data!.length,
                        itemBuilder: (context, index) {
                          String name = snapshot.data![index]['country'];
                          if (searchController.text.isEmpty) {
                            return Column(
                              children: [
                                InkWell(
                                  onTap: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                DetailScreen(
                                                image:snapshot.data![index]['countryInfo']['flag'] ,
                                                name: snapshot.data![index]['country'], 
                                                active: snapshot.data![index]['active'],
                                                critical: snapshot.data![index]['critical'],
                                                test: snapshot.data![index]['tests'], 
                                                todayRecovered: snapshot.data![index]['recovered'], 
                                                totalCases: snapshot.data![index]['cases'], 
                                                totalDeaths: snapshot.data![index]['deaths'], 
                                                totalRecovered: snapshot.data![index]['todayRecovered'],

                                                )));
                                  },
                                  child: ListTile(
                                    leading: Image(
                                        height: 50,
                                        width: 50,
                                        image: NetworkImage(
                                            snapshot.data![index]['countryInfo']
                                                ['flag'])),
                                    title:
                                        Text(snapshot.data![index]['country']),
                                    subtitle: Text(snapshot.data![index]
                                            ['cases']
                                        .toString()),
                                  ),
                                )
                              ],
                            );
                          } else if (name
                              .toLowerCase()
                              .contains(searchController.text.toLowerCase())) {
                            return Column(
                              children: [
                                InkWell(
                                  onTap: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                DetailScreen(
                                                image:snapshot.data![index]['countryInfo']['flag'] ,
                                                name: snapshot.data![index]['country'], 
                                                active: snapshot.data![index]['active'],
                                                critical: snapshot.data![index]['critical'],
                                                test: snapshot.data![index]['tests'], 
                                                todayRecovered: snapshot.data![index]['recovered'], 
                                                totalCases: snapshot.data![index]['cases'], 
                                                totalDeaths: snapshot.data![index]['deaths'], 
                                                totalRecovered: snapshot.data![index]['todayRecovered'],

                                                )));
                                  },
                                  child: ListTile(
                                    leading: Image(
                                        height: 50,
                                        width: 50,
                                        image: NetworkImage(snapshot.data![index]
                                            ['countryInfo']['flag'])),
                                    title: Text(snapshot.data![index]['country']),
                                    subtitle: Text(snapshot.data![index]['cases']
                                        .toString()),
                                  ),
                                )
                              ],
                            );
                          } else {
                            return Container();
                          }
                        });
                  }
                }),
          )
        ],
      )),
    );
  }
}
