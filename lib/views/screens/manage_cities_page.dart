import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../contoller/provider/connectivty_provider.dart';
import '../../contoller/provider/weather_provider.dart';
import '../../models/weather_model.dart';

class ManageCitiesPage extends StatefulWidget {
  const ManageCitiesPage({Key? key}) : super(key: key);

  @override
  State<ManageCitiesPage> createState() => _ManageCitiesPageState();
}

class _ManageCitiesPageState extends State<ManageCitiesPage> {
  @override
  Widget build(BuildContext context) {
    double h = MediaQuery.of(context).size.height;
    double w = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        title: Text("Manage cities"),
        actions: [
          IconButton(
            onPressed: () {},
            icon: Icon(
              Icons.note_alt_outlined,
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).pushNamed('add_city_page');
        },
        child: Icon(Icons.add),
      ),
      body: (Provider.of<ConnectivityProvider>(context)
                  .connectitvityModel
                  .connectivitystatus ==
              "Waiting..")
          ? const Center(
              child: Text("No Data Connection"),
            )
          : FutureBuilder(
              future: Provider.of<WeatherProvider>(context, listen: false)
                  .Weatherdata(locationame: "Ahmedabad"),
              builder: (context, snapshot) {
                if (snapshot.hasError) {
                  return Center(
                    child: Text("ERROR : ${snapshot.error}"),
                  );
                } else if (snapshot.hasData) {
                  WeatherModel? weatherdata = snapshot.data;
                  return (weatherdata == null)
                      ? const Center(
                          child: Text("No Data avilable"),
                        )
                      : Container(
                          alignment: Alignment.center,
                          child: Padding(
                            padding: const EdgeInsets.all(16),
                            child: ListView(
                              physics: BouncingScrollPhysics(),
                              children: [
                                GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      showDialog(
                                        context: context,
                                        builder: (context) => AlertDialog(
                                          title: Text(
                                            "Your History Delete??",
                                          ),
                                          content: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceEvenly,
                                            children: [
                                              GestureDetector(
                                                onTap: () {
                                                  setState(() {
                                                    Navigator.of(context)
                                                        .pushNamedAndRemoveUntil(
                                                            'manage_cities_page',
                                                            (route) => false);
                                                  });
                                                },
                                                child: Container(
                                                  height: 35,
                                                  width: 90,
                                                  alignment: Alignment.center,
                                                  decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            5),
                                                  ),
                                                  child: Text("Dismiss"),
                                                ),
                                              ),
                                              GestureDetector(
                                                onTap: () {
                                                  setState(() {
                                                    Navigator.of(context)
                                                        .pushNamedAndRemoveUntil(
                                                            'home_page',
                                                            (route) => false);
                                                  });
                                                },
                                                child: Container(
                                                  height: 35,
                                                  width: 90,
                                                  alignment: Alignment.center,
                                                  decoration: BoxDecoration(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              5),
                                                      color:
                                                          Colors.grey.shade400,
                                                      border: Border.all(
                                                          width: 2,
                                                          color: Colors.black)),
                                                  child: Text("Delete"),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      );
                                    });
                                  },
                                  child: ListTile(
                                    contentPadding: EdgeInsets.all(20),
                                    splashColor: Colors.grey,
                                    textColor: Colors.black,
                                    title: Text(
                                      "${weatherdata.name}",
                                      style: TextStyle(fontSize: 20),
                                    ),
                                    subtitle: Text(
                                      "Mostly ${weatherdata.text}",
                                    ),
                                    trailing: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Text(
                                          "${weatherdata.temp_c}",
                                          style: TextStyle(
                                            fontSize: 30,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                }
                return const Center(
                  child: CircularProgressIndicator(),
                );
              },
            ),
    );
  }
}
