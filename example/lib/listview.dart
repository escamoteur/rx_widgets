import 'package:flutter/material.dart';
import 'detail_page.dart';
import 'weather_viewmodel.dart';

class WeatherListView extends StatelessWidget {
  List<WeatherEntry> data;



  WeatherListView(List<WeatherEntry> this.data);

    @override
    Widget build(BuildContext context) {
      if (data.length > 0)
      {
          return new ListView.builder(
                      itemCount: data.length,
                      itemBuilder : (BuildContext context, int index) => 
                                        buildRow(context,index,data)                                            
        );
      }
      else
      {
        return new Text("No items");
      }                            
    }            
                  
    Widget buildRow(BuildContext context, int index, List<WeatherEntry> listData) {
      return 
        new GestureDetector(
            child: 
              new Wrap(spacing: 40.0,
                    children: <Widget>
                    [
                      new Image(image: new NetworkImage(listData[index].iconURL)),
                      
                      new Text(listData[index].cityName, style: new TextStyle(fontSize: 20.0))
                    ],
                  ),

            onTap: () => Navigator.push(context, 
                            new MaterialPageRoute( builder: (BuildContext context) => new DetailPage(listData[index])
                    ))
        );
        
      
    }
}
      
  
 