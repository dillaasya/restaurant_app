import 'package:flutter/material.dart';
import 'package:restaurant_app/restaurant.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter/cupertino.dart';


class RestaurantDetailPage extends StatelessWidget {
  static const routeName = '/article_detail';

  final RestaurantElement restaurant;

  const RestaurantDetailPage({required this.restaurant});


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(restaurant.name ??""),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Hero(tag:restaurant.pictureId??"",child:Image.network(restaurant.pictureId??""),),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top:8.0),
                    child: Text(restaurant.name ??"" ,style: const TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: 24,
                    ),),
                  ),

                  Row(
                    children: [
                      const Icon(Icons.add_business_rounded),
                      Padding(
                        padding: const EdgeInsets.only(left:4.0),
                        child: Text(restaurant.city??"",style: const TextStyle(
                          fontSize: 18,
                        ),),
                      ),
                      const Divider(color: Colors.grey),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 16),
                    child: Text(
                      restaurant.description ??"",

                    ),
                  ),
                ],
              ),

            //title - food menu
            Column(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(top: 8.0),
                  child: Text('Food Menu',style: GoogleFonts.inter(fontSize: 18,fontWeight: FontWeight.w700),),
                )
              ],
            ),

            //food menu
            SizedBox(
              height: 100,
              child: FutureBuilder<String>(
                future:
                DefaultAssetBundle.of(context).loadString('assets/local_restaurant.json'),
                builder: (context, snapshot) {
                  if(snapshot.connectionState!=ConnectionState.done){
                    return const CircularProgressIndicator(
                        valueColor: AlwaysStoppedAnimation<Color>(Colors.lightBlue)
                    );
                  }

                  final menu = restaurant.menus!.foods ;
                  return ListView.builder(
                      scrollDirection: Axis.horizontal,
                    shrinkWrap: true,
                    itemCount: menu!.length,
                    itemBuilder: (context, index) {
                      return _buildMenuItem(context, menu[index]);
                    },
                  );

                },
              )
            ),

            //title - drink menu
            Column(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(left: 8.0),
                  child: Text('Drinks Menu', style: GoogleFonts.inter(fontSize: 18,fontWeight: FontWeight.w700),),
                )
              ],
            ),

            //drink menu
            SizedBox(
                height: 100,
                child: FutureBuilder<String>(
                  future:
                  DefaultAssetBundle.of(context).loadString('assets/local_restaurant.json'),
                  builder: (context, snapshot) {
                    if(snapshot.connectionState!=ConnectionState.done){
                      return const CircularProgressIndicator(
                          valueColor: AlwaysStoppedAnimation<Color>(Colors.lightBlue)
                      );
                    }

                    final menu = restaurant.menus!.drinks ;
                    return ListView.builder(
                      scrollDirection: Axis.horizontal,
                      shrinkWrap: true,
                      itemCount: menu!.length,
                      itemBuilder: (context, index) {
                        return _buildMenuItem(context, menu[index]);
                      },
                    );

                  },
                )
            ),
          ],
        ),
      ),
    );
  }
}

Widget _buildMenuItem(BuildContext context, Drink menu) {
  return InkWell(
      child: Card(
        margin: const EdgeInsets.only(bottom: 8,top:8, right:8),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        child: Container(
          width: 150,
          padding: const EdgeInsets.all(8),
            child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text(menu.name??"", style: GoogleFonts.inter(fontSize: 16,fontWeight: FontWeight.w300)),
                  ]

              ),

        ),
      )

  );
}