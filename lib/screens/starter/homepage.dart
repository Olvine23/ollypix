import 'dart:convert';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:lottie/lottie.dart';
import 'package:ollypix/services/networkRequests.dart';
import 'package:http/http.dart' as http;
import 'package:transparent_image/transparent_image.dart';
import '../../models/searchModel.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<String> imageList = [
    'https://cdn.pixabay.com/photo/2019/03/15/09/49/girl-4056684_960_720.jpg',
    'https://cdn.pixabay.com/photo/2020/12/15/16/25/clock-5834193__340.jpg',
    'https://cdn.pixabay.com/photo/2020/09/18/19/31/laptop-5582775_960_720.jpg',
    'https://media.istockphoto.com/photos/woman-kayaking-in-fjord-in-norway-picture-id1059380230?b=1&k=6&m=1059380230&s=170667a&w=0&h=kA_A_XrhZJjw2bo5jIJ7089-VktFK0h0I4OWDqaac0c=',
    'https://cdn.pixabay.com/photo/2019/11/05/00/53/cellular-4602489_960_720.jpg',
    'https://cdn.pixabay.com/photo/2017/02/12/10/29/christmas-2059698_960_720.jpg',
    'https://cdn.pixabay.com/photo/2020/01/29/17/09/snowboard-4803050_960_720.jpg',
    'https://cdn.pixabay.com/photo/2020/02/06/20/01/university-library-4825366_960_720.jpg',
    'https://cdn.pixabay.com/photo/2020/11/22/17/28/cat-5767334_960_720.jpg',
    'https://cdn.pixabay.com/photo/2020/12/13/16/22/snow-5828736_960_720.jpg',
    'https://cdn.pixabay.com/photo/2020/12/09/09/27/women-5816861_960_720.jpg',
  ];
   List<ImageModel>? images;
   var isLoading = true;

   ImageModel? dataFromAPI;

  _getData() async {
    try {
      String url = "https://pixabay.com/api/?key=24492969-ba7c05868d9509686fb182a52&q=red+flowers&image_type=photo&pretty=true&per_page=100";
      http.Response res = await http.get(Uri.parse(url));
      if (res.statusCode == 200) {
        dataFromAPI = ImageModel.fromJson(json.decode(res.body));
        isLoading = false;
        print(dataFromAPI!.hits[0].webformatUrl);
        setState(() {});
      }
    } catch (e) {
      debugPrint(e.toString());
    }
  }

   @override
  void initState() {
     
    super.initState();
    _getData();
     
  }

   
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("Pixabay API"),),
        body: isLoading ? Center(child: CircularProgressIndicator(),): MasonryGridView.builder(
            itemCount: dataFromAPI!.hits.length,
            gridDelegate: SliverSimpleGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2),
            itemBuilder: ((context, index) {
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(12),
                      child:  CachedNetworkImage(
                  // height: 300,
                  // width:500,
                  fit:BoxFit.cover ,
                  imageUrl:dataFromAPI!.hits[index].webformatUrl,
                  placeholder: ((context, url) => Center(child: Lottie.network('https://lottie.host/3448995c-40ef-4f08-8cc8-c98457ff5b47/fCQ6O8aFA7.json'))),

                )
                      
                      
                      // FadeInImage.memoryNetwork(placeholder: kTransparentImage, image:dataFromAPI!.hits[index].webformatUrl ),
                      // child: Image.network(dataFromAPI!.hits[index].webformatUrl)
                      
                      
                      ),
                      Text(dataFromAPI!.hits[index].user)
                  ],
                ),
              );
            })));
  }
}
