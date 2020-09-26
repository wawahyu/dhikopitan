import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dhikopitan/landingPage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong/latlong.dart';
import 'package:url_launcher/url_launcher.dart';

class DetailPage extends StatefulWidget {
  DetailPage({@required this.location});
  final DocumentSnapshot location;
  @override
  _DetailPageState createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  DocumentSnapshot get location {
    return widget.location;
  }

  LatLng get latlng {
    if (location.data()['lat'] != null && location.data()['lon'] != null) {
      return LatLng(location.data()['lat'], location.data()['lon']);
    } else {
      return null;
    }
  }

  String get redirect {
    if (location.data()['redirect'] != null &&
        location.data()['redirect'] != '') {
      return location.data()['redirect'];
    } else {
      return null;
    }
  }

  @override
  void initState() {
    super.initState();
  }

  Widget detailLocation() {
    var screenSize = MediaQuery.of(context).size;
    var height = screenSize.height;
    var width = screenSize.width;
    return Container(
      child: Column(
        children: [
          Container(
            width: width,
            height: width * 4 / 10,
            child: location.data()['gambar'] != null
                ? Image.network(
                    location.data()['gambar'],
                    fit: BoxFit.cover,
                  )
                : Container(),
            decoration: BoxDecoration(
              color: Color(0xFF00B4AA).withOpacity(0.6),
            ),
          ),
          Container(
            width: width,
            padding: EdgeInsets.symmetric(
              vertical: 8,
            ),
            child: height < width
                ? Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        flex: 3,
                        child: Container(
                          padding: EdgeInsets.only(
                            right: 4,
                          ),
                          child: Column(
                            children: [
                              Container(
                                child: Text(location.data()['alamat'] ?? ''),
                              ),
                              Container(
                                child: Text(location.data()['telepon'] ?? ''),
                              ),
                              Container(
                                child: Text(location.data()['jenis'] ?? ''),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Expanded(
                        flex: 7,
                        child: Container(
                          padding: EdgeInsets.only(
                            left: 4,
                          ),
                          width: width,
                          child: Text(
                            location.data()['detail'] ?? '',
                            style: TextStyle(
                              fontSize: 15,
                            ),
                          ),
                        ),
                      ),
                    ],
                  )
                : Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        padding: EdgeInsets.only(
                          bottom: 4,
                        ),
                        child: Column(
                          children: [
                            Container(
                              child: Text(location.data()['alamat'] ?? ''),
                            ),
                            Container(
                              child: Text(location.data()['telepon'] ?? ''),
                            ),
                            Container(
                              child: Text(location.data()['jenis'] ?? ''),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.only(
                          top: 4,
                        ),
                        width: width,
                        child: Text(
                          location.data()['detail'] ?? '',
                          style: TextStyle(
                            fontSize: 15,
                          ),
                        ),
                      ),
                    ],
                  ),
          ),
        ],
      ),
    );
  }

  Widget aboutLocation() {
    var screenSize = MediaQuery.of(context).size;
    var height = screenSize.height;
    var width = screenSize.width;
    return Container(
      margin: EdgeInsets.symmetric(
        horizontal: 8,
      ),
      padding: EdgeInsets.symmetric(
        horizontal: 8,
        vertical: 8,
      ),
      width: width,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Container(
            height: 40,
            child: Text(
              location.data()['covidtest'] ?? '-',
              style: TextStyle(
                fontSize: 28,
              ),
            ),
          ),
          Container(
            child: Text(
              'Pasien Positif Covid-19',
              style: TextStyle(
                fontSize: 16,
              ),
            ),
          ),
          SizedBox(
            height: 20,
          ),
          latlng != null
              ? AspectRatio(
                  aspectRatio: width / width,
                  child: Container(
                    width: width,
                    child: FlutterMap(
                      options: MapOptions(
                        center: latlng,
                        zoom: 13,
                      ),
                      layers: [
                        TileLayerOptions(
                          urlTemplate:
                              "https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png",
                          subdomains: ['a', 'b', 'c'],
                        ),
                        MarkerLayerOptions(
                          markers: [
                            Marker(
                              width: 30.0,
                              height: 30.0,
                              point: latlng,
                              builder: (ctx) => Container(
                                child: Icon(
                                  Icons.location_on,
                                  color: Color(0xFF00B4AA),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    decoration: BoxDecoration(
                      color: Color(0xFF00A7E1).withOpacity(0.6),
                    ),
                  ),
                )
              : Container(),
          SizedBox(
            height: 16,
          ),
          redirect != null
              ? InkWell(
                  onTap: () async {
                    if (await canLaunch(redirect)) {
                      launch(redirect);
                    }
                  },
                  child: Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: 8,
                      vertical: 8,
                    ),
                    width: width,
                    alignment: Alignment.center,
                    child: Text(
                      'Cari Lokasi',
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    ),
                    decoration: BoxDecoration(
                      color: Color(0xFF00A7E1).withOpacity(0.6),
                    ),
                  ),
                )
              : Container(),
        ],
      ),
      decoration: BoxDecoration(
        border: Border.all(
          width: 1,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    var screenSize = MediaQuery.of(context).size;
    var height = screenSize.height;
    var width = screenSize.width;
    return Scaffold(
      backgroundColor: Color(0xFF00A7E1),
      body: Container(
        height: height,
        width: width,
        child: NestedScrollView(
          headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
            return <Widget>[
              SliverAppBar(
                leading: Container(),
                leadingWidth: 0,
                floating: false,
                pinned: false,
                backgroundColor: Colors.white,
                title: InkWell(
                  onTap: () {
                    Navigator.of(context).pushReplacement(
                      MaterialPageRoute(
                        builder: (context) => LandingPage(),
                      ),
                    );
                  },
                  child: Text(
                    'Dhi Kopitan',
                    style: TextStyle(
                      color: Color(0xFF00A7E1),
                    ),
                  ),
                ),
              ),
              SliverAppBar(
                leading: Container(),
                leadingWidth: 0,
                expandedHeight: width / 5,
                centerTitle: true,
                flexibleSpace: Container(
                  width: width,
                  height: width / 5,
                  child: Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 8,
                    ),
                    width: width,
                    height: width / 5,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Container(
                          child: Text(
                            'Detail',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 26,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    ),
                    decoration: BoxDecoration(
                      color: Color(0xFF00B4AA).withOpacity(0.6),
                    ),
                  ),
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: NetworkImage(
                          'https://firebasestorage.googleapis.com/v0/b/retsa-project.appspot.com/o/1585736646%201.png?alt=media&token=d039407f-9849-4fbf-a2aa-215e9f35ee22'),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
              SliverAppBar(
                actions: [],
                leadingWidth: 0,
                floating: false,
                pinned: true,
                leading: Container(),
                backgroundColor: Colors.white,
                title: Text(
                  location.data()['name'] ?? ' - ',
                  maxLines: 2,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
              ),
            ];
          },
          body: Container(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Container(
                    color: Colors.grey[50],
                    child: Column(
                      children: [
                        height < width
                            ? Container(
                                padding: EdgeInsets.symmetric(
                                  horizontal: 16,
                                ),
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Expanded(
                                      flex: 7,
                                      child: Container(
                                        child: detailLocation(),
                                      ),
                                    ),
                                    Expanded(
                                      flex: 3,
                                      child: Container(
                                        child: aboutLocation(),
                                      ),
                                    ),
                                  ],
                                ),
                              )
                            : Container(
                                padding: EdgeInsets.symmetric(
                                  horizontal: 16,
                                ),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Container(
                                      child: detailLocation(),
                                    ),
                                    SizedBox(
                                      height: 8,
                                    ),
                                    Container(
                                      child: aboutLocation(),
                                    ),
                                  ],
                                ),
                              ),
                        SizedBox(
                          height: 16,
                        ),
                      ],
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.symmetric(
                      vertical: 8,
                      horizontal: 16,
                    ),
                    width: width,
                    child: Text(
                      'Copyright ©2020 All rights reserved | Dhi Kopitan',
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
