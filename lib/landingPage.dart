import 'dart:async';
import 'dart:math';

import 'package:dhikopitan/utils/auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:dhikopitan/loginPage.dart';
import 'package:dhikopitan/detailPage.dart';
import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';

class LandingPage extends StatefulWidget {
  @override
  _LandingPageState createState() => _LandingPageState();
}

class _LandingPageState extends State<LandingPage> {
  // final Auth auth = Auth();
  bool showMore = false;
  TextEditingController search = TextEditingController();
  FlutterWebviewPlugin flutterWebviewPlugin = new FlutterWebviewPlugin();
  Timer time;

  @override
  void initState() {
    super.initState();
    // startLaunch();
  }

  @override
  Widget build(BuildContext context) {
    var screenSize = MediaQuery.of(context).size;
    var height = screenSize.height;
    var width = screenSize.width;

    return Scaffold(
      backgroundColor: Color(0xFF00A7E1),
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text(
          'Dhi Kopitan',
          style: TextStyle(
            color: Color(0xFF00A7E1),
          ),
        ),
        actions: [
          Center(
            child: Padding(
              padding: EdgeInsets.only(
                right: 16,
              ),
              child: GestureDetector(
                onTap: () {
                  if (Auth().currentUser() == null)
                    Navigator.of(context).pushReplacement(
                      MaterialPageRoute(
                        builder: (context) => LoginPage(),
                      ),
                    );
                  else {
                    Auth().signOut();
                    setState(() {});
                  }
                },
                child: Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 8,
                  ),
                  child: Text(
                    Auth().currentUser() != null ? 'Keluar' : 'Masuk',
                    style: TextStyle(
                      color: Colors.black,
                    ),
                  ),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    border: Border.all(
                      width: 2,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
      body: Container(
        height: height,
        width: width,
        child: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                child: Column(
                  children: [
                    Container(
                      width: width,
                      height: width / 2,
                      child: Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 8,
                        ),
                        width: width,
                        height: width / 2,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Container(
                              child: Text(
                                'Jangan Lupa',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 18,
                                ),
                              ),
                            ),
                            Container(
                              child: Text(
                                'Dhi Kopitan ',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 26,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            Container(
                              child: Text(
                                'Menyediakan List Tempat Test Covid-19, yang Tersedia di Kota Bandung',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 18,
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
                              'https://firebasestorage.googleapis.com/v0/b/retsa-project.appspot.com/o/2020_03_23_90391_1584949138%201.png?alt=media&token=88ad4b64-836e-4587-bd7c-ae75e7faea43'),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.symmetric(
                        vertical: 20,
                        horizontal: 16,
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            'Rekomendasi Tempat yang Menyediakan Test Covid-19',
                            style: TextStyle(
                              fontSize: 24,
                            ),
                          ),
                          Text(
                            'di Kota Bandung',
                            style: TextStyle(
                              fontSize: 16,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 8,
                      ),
                      width: width,
                      child: Column(
                        children: [
                          Container(
                            padding: EdgeInsets.symmetric(
                              vertical: 4,
                            ),
                            width: width,
                            child: Text(
                              'Terbaru',
                            ),
                            decoration: BoxDecoration(
                              border: Border(
                                bottom: BorderSide(
                                  width: 2,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    FutureBuilder<QuerySnapshot>(
                      future: FirebaseFirestore.instance
                          .collection('locations')
                          .limit(3)
                          .get(),
                      builder: (context, snapshot) {
                        if (snapshot.hasData) {
                          List<DocumentSnapshot> locations = snapshot.data.docs;
                          if (locations.length > 0) {
                            return Container(
                              padding: EdgeInsets.symmetric(
                                horizontal: 12,
                                vertical: 8,
                              ),
                              width: width,
                              child: Row(
                                children:
                                    List.generate(locations.length, (index) {
                                  DocumentSnapshot location = locations[index];
                                  return Flexible(
                                    child: InkWell(
                                      onTap: () {
                                        Navigator.of(context).pushReplacement(
                                          MaterialPageRoute(
                                            builder: (context) => DetailPage(
                                              location: location,
                                            ),
                                          ),
                                        );
                                      },
                                      child: Container(
                                        margin: EdgeInsets.symmetric(
                                          horizontal: 4,
                                        ),
                                        width: width / 3,
                                        height: width / 3,
                                        child: ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          child: Column(
                                            children: [
                                              Container(
                                                width: width / 3,
                                                height: (width / 3 * 6 / 10),
                                                child: Container(
                                                  width: width / 3,
                                                  height: (width / 3 * 2 / 3),
                                                  color: Color(0xFF00B4AA)
                                                      .withOpacity(0.2),
                                                ),
                                                decoration: BoxDecoration(
                                                  image: location.data()[
                                                              'gambar'] !=
                                                          null
                                                      ? DecorationImage(
                                                          image: NetworkImage(
                                                              location.data()[
                                                                  'gambar']),
                                                          fit: BoxFit.cover,
                                                        )
                                                      : null,
                                                ),
                                              ),
                                              Expanded(
                                                child: Container(
                                                  padding: EdgeInsets.symmetric(
                                                    horizontal: 8,
                                                    vertical: 8,
                                                  ),
                                                  child: Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      Container(
                                                        width: width,
                                                        child: Text(
                                                          location.data()[
                                                                  'name'] ??
                                                              ' - ',
                                                          maxLines: 2,
                                                          overflow: TextOverflow
                                                              .ellipsis,
                                                          style: TextStyle(
                                                            fontWeight:
                                                                FontWeight.bold,
                                                          ),
                                                        ),
                                                      ),
                                                      Flexible(
                                                        child: SizedBox(
                                                          height: 4,
                                                        ),
                                                      ),
                                                      Flexible(
                                                        child: Container(
                                                          width: width,
                                                          child: Text(
                                                            location.data()[
                                                                    'alamat'] ??
                                                                '',
                                                            maxLines: 2,
                                                            overflow:
                                                                TextOverflow
                                                                    .ellipsis,
                                                            style: TextStyle(),
                                                          ),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          color: Colors.white,
                                          boxShadow: [
                                            BoxShadow(
                                              color: Color(0xFF00B4AA)
                                                  .withOpacity(0.6),
                                              offset: Offset(2, 0),
                                              blurRadius: 4,
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  );
                                }),
                              ),
                            );
                          }
                        } else {
                          return Container(
                            padding: EdgeInsets.symmetric(
                              horizontal: 12,
                              vertical: 8,
                            ),
                            width: width,
                            child: Center(
                              child: Text(
                                'Tidak Ada Lokasi Data Terbaru\n Tunggu Yaa..! Kami sedang menyiapkannya untuk mu',
                                textAlign: TextAlign.center,
                              ),
                            ),
                          );
                        }
                        return Container(
                          padding: EdgeInsets.symmetric(
                            horizontal: 12,
                            vertical: 8,
                          ),
                          width: width,
                          child: Row(
                            children: List.generate(3, (index) {
                              return Flexible(
                                child: Container(
                                  margin: EdgeInsets.symmetric(
                                    horizontal: 4,
                                  ),
                                  width: width / 3,
                                  height: width / 3,
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(10),
                                    child: Column(
                                      children: [
                                        Container(
                                          width: width / 3,
                                          height: (width / 3 * 2 / 3),
                                          color: Color(0xFF00B4AA)
                                              .withOpacity(0.1),
                                        ),
                                      ],
                                    ),
                                  ),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    color: Colors.white,
                                    boxShadow: [
                                      BoxShadow(
                                        color:
                                            Color(0xFF00B4AA).withOpacity(0.2),
                                        offset: Offset(2, 0),
                                        blurRadius: 4,
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            }),
                          ),
                        );
                      },
                    ),
                    Container(
                      width: width,
                      padding: EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 8,
                      ),
                      child: TextField(
                        controller: search,
                        onChanged: (val) {
                          setState(() {});
                        },
                        decoration: InputDecoration(
                          hintText: 'Cari Fasilitas Kesehatan',
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: BorderSide(
                              color: Color(0xFF00A7E1),
                              width: 2,
                            ),
                          ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: BorderSide(
                              width: 2,
                            ),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: BorderSide(
                              color: search.text != null && search.text != ''
                                  ? Color(0xFF00A7E1)
                                  : Colors.black,
                              width: 2,
                            ),
                          ),
                        ),
                      ),
                    ),
                    StreamBuilder<QuerySnapshot>(
                      stream: FirebaseFirestore.instance
                          .collection('locations')
                          .snapshots(),
                      builder: (context, snapshot) {
                        if (snapshot.hasData) {
                          List<DocumentSnapshot> locations = snapshot.data.docs;
                          List<DocumentSnapshot> locs = [];
                          if (locations.length > 0) {
                            if (search.text != null && search.text != '') {
                              locations.forEach((location) {
                                if (location
                                    .data()['name']
                                    .toString()
                                    .toLowerCase()
                                    .contains(search.text.toLowerCase())) {
                                  locs.add(location);
                                }
                              });
                            } else {
                              locs = locations;
                            }
                            return Container(
                              padding: EdgeInsets.symmetric(
                                horizontal: 16,
                                vertical: 8,
                              ),
                              width: width,
                              child: Column(
                                children: List.generate(
                                    search.text != null && search.text != ''
                                        ? locs.length
                                        : showMore
                                            ? locations.length
                                            : (locations.length > 2
                                                ? 2
                                                : locations.length), (index) {
                                  DocumentSnapshot location = locs[index];
                                  return GestureDetector(
                                    onTap: () {
                                      Navigator.of(context).pushReplacement(
                                        MaterialPageRoute(
                                          builder: (context) => DetailPage(
                                            location: location,
                                          ),
                                        ),
                                      );
                                    },
                                    child: Container(
                                      margin: EdgeInsets.symmetric(
                                        vertical: 4,
                                      ),
                                      padding: EdgeInsets.symmetric(
                                        vertical: 8,
                                        horizontal: 8,
                                      ),
                                      width: width,
                                      height: height * 2 / 10,
                                      child: ClipRRect(
                                        borderRadius: BorderRadius.circular(10),
                                        child: Row(
                                          children: [
                                            Container(
                                              width: height < width
                                                  ? height * 3 / 10
                                                  : height * 2 / 10,
                                              height: height * 2 / 10,
                                              child: ClipRRect(
                                                borderRadius:
                                                    BorderRadius.circular(10),
                                                child: Container(
                                                  width: height < width
                                                      ? height * 3 / 10
                                                      : height * 2 / 10,
                                                  height: height * 2 / 10,
                                                  color: Color(0xFF00B4AA)
                                                      .withOpacity(0.1),
                                                ),
                                              ),
                                              decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(10),
                                                image:
                                                    location.data()['gambar'] !=
                                                            null
                                                        ? DecorationImage(
                                                            image: NetworkImage(
                                                                location.data()[
                                                                    'gambar']),
                                                            fit: BoxFit.cover,
                                                          )
                                                        : null,
                                              ),
                                            ),
                                            Expanded(
                                              child: Container(
                                                padding: EdgeInsets.symmetric(
                                                  horizontal: 8,
                                                ),
                                                child: Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Container(
                                                      width: width,
                                                      child: Text(
                                                        location.data()[
                                                                'name'] ??
                                                            ' - ',
                                                        maxLines: 2,
                                                        overflow: TextOverflow
                                                            .ellipsis,
                                                        style: TextStyle(
                                                          fontSize: 18,
                                                          fontWeight:
                                                              FontWeight.bold,
                                                        ),
                                                      ),
                                                    ),
                                                    SizedBox(
                                                      height: 4,
                                                    ),
                                                    Expanded(
                                                      child: Container(
                                                        width: width,
                                                        child: Text(
                                                          location.data()[
                                                                  'alamat'] ??
                                                              '',
                                                          maxLines: 2,
                                                          overflow: TextOverflow
                                                              .ellipsis,
                                                          style: TextStyle(),
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(10),
                                        color: Colors.white,
                                        boxShadow: [
                                          BoxShadow(
                                            color: Color(0xFF00B4AA)
                                                .withOpacity(0.6),
                                            offset: Offset(2, 0),
                                            blurRadius: 4,
                                          ),
                                        ],
                                      ),
                                    ),
                                  );
                                }),
                              ),
                            );
                          }
                        } else {
                          return Container();
                        }
                        return Container();
                      },
                    ),
                    !showMore
                        ? Container(
                            width: width,
                            padding: EdgeInsets.symmetric(
                              horizontal: 8,
                              vertical: 8,
                            ),
                            child: Center(
                              child: InkWell(
                                onTap: () {
                                  setState(() {
                                    showMore = true;
                                  });
                                },
                                child: Container(
                                  padding: EdgeInsets.symmetric(
                                    vertical: 8,
                                    horizontal: 16,
                                  ),
                                  child: Text(
                                    'Lihat Lebih',
                                  ),
                                  decoration: BoxDecoration(
                                    border: Border.all(
                                      width: 2,
                                    ),
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                ),
                              ),
                            ),
                          )
                        : Container(),
                  ],
                ),
                decoration: BoxDecoration(
                  color: Colors.grey[50],
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey[500],
                      offset: Offset(2, 0),
                      blurRadius: 4,
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
    );
  }
}
