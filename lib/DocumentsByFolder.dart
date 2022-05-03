import 'package:flutter/material.dart';
import 'package:istakip/DbHelper.dart';
import 'package:istakip/PdfViewer.dart';

class DocumentsByFolder extends StatefulWidget {
  final String folder;
  const DocumentsByFolder({ Key? key , required this.folder}) : super(key: key);

  @override
  State<DocumentsByFolder> createState() => DocumentsByFolderState();
}

class DocumentsByFolderState extends State<DocumentsByFolder> {
  late Future<List<Document>> folders;
  void initState() {
    super.initState();
    
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    var folderName = widget.folder;
    folders = DbHelper().getDocumentsByFolder(folderName);
    return Scaffold(
      body: Center(
          child: FutureBuilder<List<Document>>(
            future: folders,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return ListView.builder(
                    itemCount: snapshot.data!.length,
                    itemBuilder: (BuildContext context, int index) {
                      return demoTopRatedDr(context, snapshot.data![index]);
                    });
              } else if (snapshot.hasError) {
                return Text('${snapshot.error}');
              }

              // By default, show a loading spinner.
              return const CircularProgressIndicator();
            },
          ),
        ),
    );}


  Widget demoTopRatedDr(BuildContext context, Document folder) {
    var size = MediaQuery.of(context).size;
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => PdfViewer(
              path: folder.path,
            ),
          ),
        );
        
      },
      child: Container(
        height: 90,
        // width: size.width,
        margin: EdgeInsets.only(top: 10),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(5),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              margin: EdgeInsets.only(left: 20),
              height: 90,
              width: 50,
              child: Icon(
                Icons.picture_as_pdf,
                color: Color(0xff363636),
                size: 30,
              ),
            ),
            Container(
              margin: EdgeInsets.only(left: 20, top: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Container(
                    margin: EdgeInsets.only(top: 10),
                    child: Text(
                      folder.name,
                      textDirection: TextDirection.ltr,
                      textAlign: TextAlign.justify,
                      maxLines: 3,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        color: Color(0xff363636),
                        fontSize: 17,
                        fontFamily: 'Roboto',
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                  
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}