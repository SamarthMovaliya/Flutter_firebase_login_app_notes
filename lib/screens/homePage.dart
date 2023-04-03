import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_login_pages/ModalClass/globals.dart';
import 'package:firebase_login_pages/helper/Firebase_store_helper.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

import '../components/drawer_component.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.grey.shade50,
        title: const Text(
          'Sticky Notes',
          style: TextStyle(
            fontSize: 25,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: StreamBuilder(
        stream: FireBaseStoreHelper.db.collection("Notes").snapshots(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Center(
              child: Text("${snapshot.error}"),
            );
          } else if (snapshot.hasData) {
            QuerySnapshot<Map<String, dynamic>>? data = snapshot.data;
            List<QueryDocumentSnapshot<Map<String, dynamic>>> alldata =
                data!.docs;
            return (alldata.isNotEmpty)
                ? Center(
                    child: GridView.count(
                      crossAxisCount: 2,
                      padding: const EdgeInsets.all(20),
                      crossAxisSpacing: 20,
                      childAspectRatio: 3 / 4,
                      mainAxisSpacing: 20,
                      children: alldata
                          .map(
                            (e) => GestureDetector(
                              onTap: () async {
                                Updated = e.data();
                                Navigator.pushNamed(context, "Update_Page");
                              },
                              child: Container(
                                decoration: BoxDecoration(
                                  color: Color(
                                    int.parse(
                                      e['ColorCode'],
                                    ),
                                  ),
                                  borderRadius: const BorderRadius.only(
                                    bottomLeft: Radius.circular(10),
                                    bottomRight: Radius.circular(10),
                                    topRight: Radius.circular(30),
                                    topLeft: Radius.circular(10),
                                  ),
                                  boxShadow: const [
                                    BoxShadow(
                                      color: Colors.grey,
                                      offset: Offset(2, 3),
                                      blurRadius: 7,
                                    ),
                                  ],
                                ),
                                child: Stack(
                                  children: [
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        const SizedBox(
                                          height: 12,
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 8.0),
                                          child: Text(
                                            e['NoteTitle'],
                                            maxLines: 1,
                                            overflow: TextOverflow.ellipsis,
                                            style: const TextStyle(
                                                fontWeight: FontWeight.w900,
                                                fontSize: 20,
                                                color: Colors.grey),
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: SingleChildScrollView(
                                            child: Text(
                                              e['NoteBody'],
                                              maxLines: 10,
                                              overflow: TextOverflow.fade,
                                              style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 10,
                                                  color: Colors.grey.shade500),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                    Expanded(
                                      child: Container(
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(20),
                                          gradient: const LinearGradient(
                                            begin: Alignment.topCenter,
                                            end: Alignment.bottomCenter,
                                            colors: [
                                              Colors.transparent,
                                              Colors.transparent,
                                              Colors.black12,
                                              Colors.black45,
                                            ],
                                          ),
                                          color: Colors.grey,
                                        ),
                                      ),
                                    ),
                                    Column(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      children: [
                                        Container(
                                          height: 46,
                                          decoration: BoxDecoration(
                                            color: Colors.grey.shade200,
                                            borderRadius:
                                                const BorderRadius.only(
                                              bottomLeft: Radius.circular(10),
                                              bottomRight: Radius.circular(10),
                                            ),
                                          ),
                                          child: Row(
                                            children: [
                                              Padding(
                                                padding:
                                                    const EdgeInsets.all(8.0),
                                                child: Container(
                                                  alignment:
                                                      Alignment.centerLeft,
                                                  width: 70,
                                                  child: Text(
                                                    e['NoteName'],
                                                    maxLines: 1,
                                                    style: TextStyle(
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        color: Colors
                                                            .grey.shade700),
                                                  ),
                                                ),
                                              ),
                                              const Spacer(),
                                              PopupMenuButton(
                                                elevation: 6,
                                                iconSize: 5,
                                                padding:
                                                    const EdgeInsets.all(0),
                                                constraints:
                                                    const BoxConstraints(
                                                  maxWidth: 130,
                                                ),
                                                shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(10),
                                                ),
                                                icon: Icon(
                                                  Icons.more_vert,
                                                  size: 22,
                                                  color: Colors.grey.shade600,
                                                ),
                                                itemBuilder: (context) => [
                                                  PopupMenuItem(
                                                    enabled: true,
                                                    padding:
                                                        const EdgeInsets.all(0),
                                                    height: 10,
                                                    child: GestureDetector(
                                                      onTap: () {
                                                        Updated = e.data();
                                                        Navigator.pop(context);
                                                        Navigator.pushNamed(
                                                            context,
                                                            "Update_Page");
                                                      },
                                                      child: ListTile(
                                                        leading: const Icon(
                                                          Icons.edit,
                                                        ),
                                                        title: Text(
                                                          'Edit',
                                                          style: TextStyle(
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold,
                                                              fontSize: 14,
                                                              color: Colors.grey
                                                                  .shade500),
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                  PopupMenuItem(
                                                    padding:
                                                        const EdgeInsets.all(0),
                                                    height: 10,
                                                    child: GestureDetector(
                                                      onTap: () {
                                                        setState(() {
                                                          FireBaseStoreHelper
                                                              .fireBaseStoreHelper
                                                              .Delete(
                                                                  data:
                                                                      e.data());
                                                          Navigator.pop(
                                                              context);
                                                        });
                                                      },
                                                      child: ListTile(
                                                        leading: const Icon(
                                                          Icons.delete,
                                                        ),
                                                        title: Text(
                                                          'Delete',
                                                          style: TextStyle(
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold,
                                                              fontSize: 14,
                                                              color: Colors.grey
                                                                  .shade500),
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    )
                                  ],
                                ),
                              ),
                            ),
                          )
                          .toList(),
                    ),
                  )
                : Center(
                    child: Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Container(
                        height: MediaQuery.of(context).size.height / 2,
                        width: MediaQuery.of(context).size.width / 1.1,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                              height: 250,
                              width: 250,
                              decoration: const BoxDecoration(
                                image: DecorationImage(
                                  image: AssetImage('assets/images/brush.png'),
                                  opacity: 0.3,
                                ),
                              ),
                            ),
                            const SizedBox(
                              height: 14,
                            ),
                            Text(
                              '  No Notes Found...',
                              style: TextStyle(
                                  fontWeight: FontWeight.w900,
                                  color: Colors.grey.shade300,
                                  fontSize: 22),
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
          }
          return const Center(
            child: CircularProgressIndicator(),
          );
        },
      ),
      drawerDragStartBehavior: DragStartBehavior.down,
      drawer: myDrawer(),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          Navigator.pushNamed(context, 'NotePage');
        },
        backgroundColor: Colors.amber.shade700,
        icon: const Icon(
          Icons.add,
          color: Colors.white,
        ),
        label: const Text(
          'Add',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}
