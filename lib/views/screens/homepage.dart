import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../contoller/provider/connectivty_provider.dart';
import '../../contoller/provider/weather_provider.dart';
import '../../models/weather_model.dart';
import '../../utils/helpers.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  TextEditingController textController = TextEditingController();

  WeatherModel? weatherModel;

  late Future<WeatherModel?> weatherdata;

  @override
  void initState() {
    super.initState();
    weatherdata = APIHelper.apiHelper.fetchweather(locationame: "Surat");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: (Provider.of<ConnectivityProvider>(context)
                  .connectitvityModel
                  .connectivitystatus ==
              "Waiting..")
          ? const Center(
              child: Text("No Data Connection"),
            )
          : FutureBuilder(
              future: Provider.of<WeatherProvider>(context, listen: false)
                  .Weatherdata(locationame: "Surat"),
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
                            child: Column(
                              children: [
                                const SizedBox(
                                  height: 50,
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          "${weatherdata.name}",
                                          style: const TextStyle(
                                            fontSize: 2,
                                          ),
                                        ),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text(
                                              "${weatherdata.region}",
                                              style: const TextStyle(
                                                fontSize: 16,
                                              ),
                                            ),
                                            Text(
                                              ", ${weatherdata.country}",
                                              style: const TextStyle(
                                                fontSize: 16,
                                              ),
                                            ),
                                          ],
                                        ),
                                        const SizedBox(
                                          height: 5,
                                        ),
                                        const Icon(
                                          Icons.location_on,
                                        ),
                                      ],
                                    ),
                                    Row(
                                      children: [
                                        IconButton(
                                          onPressed: () {
                                            Navigator.of(context).pushNamed(
                                                'manage_cities_page');
                                          },
                                          icon: const Icon(
                                            CupertinoIcons.building_2_fill,
                                          ),
                                        ),
                                        IconButton(
                                          onPressed: () {
                                            Navigator.of(context)
                                                .pushNamed('setting_page');
                                          },
                                          icon: const Icon(
                                            Icons.more_vert,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                                Container(
                                  height: 200,
                                  width: double.infinity,
                                  // ignore: prefer_const_constructors
                                  decoration: BoxDecoration(
                                    image: const DecorationImage(
                                      image: AssetImage(
                                        'lib/Assets/raining_sun.png',
                                      ),
                                    ),
                                  ),
                                ),
                                Expanded(
                                  flex: 8,
                                  child: SingleChildScrollView(
                                    physics: const BouncingScrollPhysics(),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Row(
                                          children: [
                                            Text(
                                              "${weatherdata.temp_c}",
                                              style: const TextStyle(
                                                fontSize: 70,
                                              ),
                                            ),
                                            const SizedBox(
                                              width: 20,
                                            ),
                                            Column(
                                              children: [
                                                const Text(
                                                  "◦c",
                                                  style: TextStyle(
                                                    fontSize: 25,
                                                  ),
                                                ),
                                                Text(
                                                  "Mostly ${weatherdata.text}",
                                                  style: const TextStyle(
                                                    fontSize: 15,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                        Text(
                                          "${weatherdata.localtime}",
                                          style: const TextStyle(
                                            fontSize: 15,
                                          ),
                                        ),
                                        SingleChildScrollView(
                                          scrollDirection: Axis.horizontal,
                                          child: Row(
                                            children: [
                                              ...weatherdata.hour
                                                  .map(
                                                    (e) => Padding(
                                                      padding:
                                                          const EdgeInsets.all(
                                                              16),
                                                      child: Column(
                                                        children: [
                                                          Text(
                                                            e['time']
                                                                .toString()
                                                                .split(" ")[1],
                                                            style:
                                                                const TextStyle(
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold,
                                                            ),
                                                          ),
                                                          Text(
                                                            e['temp_c']
                                                                .toString(),
                                                            style:
                                                                const TextStyle(
                                                                    fontSize:
                                                                        18),
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                  )
                                                  .toList(),
                                            ],
                                          ),
                                        ),
                                        const SizedBox(
                                          height: 20,
                                        ),
                                        const Divider(
                                          height: 3,
                                        ),
                                        const SizedBox(
                                          height: 20,
                                        ),
                                        const Text(
                                          "Weather Details",
                                          style: TextStyle(fontSize: 18),
                                        ),
                                        const SizedBox(
                                          height: 20,
                                        ),
                                        const Divider(
                                          height: 3,
                                        ),
                                        const SizedBox(
                                          height: 20,
                                        ),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceEvenly,
                                          children: [
                                            Column(
                                              children: [
                                                const Text(
                                                  "Apparent Temperature",
                                                  style: TextStyle(),
                                                ),
                                                Text(
                                                  "${weatherdata.feelslike_c} ◦c"
                                                      .toString(),
                                                  style: const TextStyle(
                                                    fontSize: 25,
                                                  ),
                                                ),
                                              ],
                                            ),
                                            const SizedBox(
                                              width: 100,
                                            ),
                                            Column(
                                              children: [
                                                const Text(
                                                  "Humidity",
                                                  style: TextStyle(),
                                                ),
                                                Text(
                                                  "${weatherdata.humidity} %"
                                                      .toString(),
                                                  style: const TextStyle(
                                                    fontSize: 25,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                        const SizedBox(
                                          height: 40,
                                        ),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceEvenly,
                                          children: [
                                            Column(
                                              children: [
                                                const Text(
                                                  "SW Wind",
                                                  style: TextStyle(),
                                                ),
                                                Text(
                                                  " ${weatherdata.wind_kph} km/h"
                                                      .toString(),
                                                  style: const TextStyle(
                                                    fontSize: 25,
                                                  ),
                                                ),
                                              ],
                                            ),
                                            const SizedBox(
                                              width: 120,
                                            ),
                                            Column(
                                              children: [
                                                const Text(
                                                  "UV",
                                                  style: TextStyle(),
                                                ),
                                                Text(
                                                  "${weatherdata.uv}"
                                                      .toString(),
                                                  style: const TextStyle(
                                                    fontSize: 25,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                        const SizedBox(
                                          height: 40,
                                        ),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceEvenly,
                                          children: [
                                            Column(
                                              children: [
                                                const Text(
                                                  "Visibility",
                                                  style: TextStyle(),
                                                ),
                                                Text(
                                                  "${weatherdata.vis_km} km"
                                                      .toString(),
                                                  style: const TextStyle(
                                                    fontSize: 18,
                                                  ),
                                                ),
                                              ],
                                            ),
                                            const SizedBox(
                                              width: 70,
                                            ),
                                            Column(
                                              children: [
                                                const Text(
                                                  "Air Pressure",
                                                  style: TextStyle(),
                                                ),
                                                Text(
                                                  "${weatherdata.pressure_mb} hPa"
                                                      .toString(),
                                                  style: const TextStyle(
                                                    fontSize: 18,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ],
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

////////country name1
// Text(
// "Country Name1 : ${weatherdata.tz_id}",
// style: const TextStyle(
// fontSize: 24,
// fontWeight: FontWeight.bold,
// ),
// ),

//////hour wise temp
// Text(
// "${weatherdata.time0}",
// style: TextStyle(
// fontSize: 20,
// color: Colors.white,
// ),
// ),
// Text(
// "${weatherdata.temp0}",
// style: TextStyle(
// fontSize: 20,
// color: Colors.white,
// ),
// )

//////time
// Text(
// "${weatherdata.hour[i]['temp_c']}",
// style: const TextStyle(
// color: Colors.white
// ),
// ),

/////// Temp F
// Text(
// "Temp F : ${weatherdata.temp_f}",
// style: const TextStyle(
// fontSize: 24,
// fontWeight: FontWeight.bold,
// ),
// ),

// Row(
// mainAxisAlignment: MainAxisAlignment.spaceAround,
// children: [
// SizedBox(
// width: 40,
// ),
// Text(
// "Weather App",
// style: TextStyle(
// fontSize: 40,
// color: Colors.white,
// ),
// ),
// IconButton(
// onPressed: () {
// Provider.of<AppThemeProvider>(context, listen: false)
//     .ChangeTheme();
// },
// icon: Icon(
// (Provider.of<AppThemeProvider>(context).appThemeModel.isDark)
// ? Icons.light_mode_outlined
//     : Icons.dark_mode,color: Colors.white,
// ),
// ),
//
// ],
// ),
