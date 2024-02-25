
import 'package:flutter/material.dart';
import 'database/database.dart';
import 'models/clothes_model.dart';

import 'widgets/clothes_widgets.dart';

class ClothesPage extends StatefulWidget {
  const ClothesPage({Key? key}) : super(key: key);

  @override
  State<ClothesPage> createState() => _ClothesPageState();

}

class _ClothesPageState extends State<ClothesPage>{
  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(
        title: const Text(
            'Clothes',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 24,
            fontFamily: 'Itim',
          )
        ),
        centerTitle: true,
      ),
      
      body: FutureBuilder<List<Clothes>>(
        future: SQLHelper.getItems(),
        builder: (context, snapshot){
          if(snapshot.connectionState == ConnectionState.waiting){
            return const Center(child: CircularProgressIndicator());
          }
          if(snapshot.hasError){
            return Center(child: Text('Error: ${snapshot.error}'));
          }
          if(!snapshot.hasData){
            return const Center(child: Text('No clothes found'));
          }
          return ListView.builder(
            shrinkWrap: true, // Important to prevent issues with nested scrolling
            
            itemCount: snapshot.data!.length,
            itemBuilder : (context, index) => ClothesWidget(
              clothes: snapshot.data![index],
              onTap: (){print('Tapped');},
              onLongPress: (){print('Long Pressed');},
            )
          );
        },
      ),
      
    );
  }
}
    
      


  