import 'package:flutter/material.dart';
import 'package:restaurant_app/restaurant.dart';
import 'package:restaurant_app/detail_restaurant.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter/cupertino.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: NewsListPage.routeName,
      routes: {
        NewsListPage.routeName: (context) => NewsListPage(),
       RestaurantDetailPage.routeName: (context) => RestaurantDetailPage(restaurant: ModalRoute.of(context)?.settings.arguments as RestaurantElement,),
      },
    );
  }
}

class NewsListPage extends StatelessWidget {
  static const routeName = '/article_list';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Restaurant App')),
      body:FutureBuilder<String>(
        future:
        DefaultAssetBundle.of(context).loadString('assets/local_restaurant.json'),
        builder: (context, snapshot) {
          if(snapshot.connectionState!=ConnectionState.done){
            return const CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(Colors.lightBlue)
            );
          }

          final restaurant = restaurantFromJson(snapshot.data ??"").restaurants ;
          return ListView.builder(
            scrollDirection: Axis.vertical,
            shrinkWrap: true,
            itemCount: restaurant!.length,
            itemBuilder: (context, index) {
              return _buildRestaurantItem(context, restaurant[index]);
            },
          );

        },
      )
    );
  }

  Widget _buildRestaurantItem(BuildContext context, RestaurantElement restaurant) {
    return InkWell(
        onTap: () {Navigator.pushNamed(context, RestaurantDetailPage.routeName, arguments: restaurant);},
        child: Card(
          margin: const EdgeInsets.all(8),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          child: Column(
              children: <Widget>[
                Hero(tag:restaurant.pictureId??"",child:Image.network(restaurant.pictureId??""),),

                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text(
                              restaurant.name??"",
                              style: GoogleFonts.inter(fontSize: 16,fontWeight: FontWeight.w700),
                            ),
                            Row(
                              children: [
                                const Icon(Icons.add_business_rounded),
                                Padding(
                                  padding: const EdgeInsets.only(left : 4.0),

                                  child: Text(restaurant.city??"", style: GoogleFonts.inter(fontSize: 14,fontWeight: FontWeight.w400,)),
                                ),
                              ],
                            )

                            ]
                      ),
                      Column(
                          children: [
                            Row(
                              children: [
                                const Icon(Icons.star),
                                Padding(
                                    padding: const EdgeInsets.only(left: 4),
                                    child: Text(
                                      restaurant.rating.toString(),
                                      style: GoogleFonts.inter(fontSize: 14,fontWeight: FontWeight.w600,),
                                    )
                                ),
                              ],
                            )
                          ],
                      ),
                    ],
                  ),
                )
              ]
          ),
        )

    );
  }



}