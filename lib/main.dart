import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:post_app/src/entidades/Post.dart';

void main() => runApp(MyApp());

Future<Post> createPost(String url, {Map body}) async {
  return http.post(url, body: body,
      headers: {"Accept": "application/json"})
      .then((http.Response response){
        final int statusCode = response.statusCode;
        print(response.body);
        if(statusCode < 200 || statusCode > 400 || json==null){
          throw Exception("Hubo un error al enviar los datos $statusCode");
        }
        print("La solicitud fue resulta correctamente, creado $statusCode");


        return Post.fromJson(json.decode(response.body));
  });
}


class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "POST",
      theme: ThemeData(primaryColor: Colors.blueAccent),
      home: BodyWidget(),
    );
  }
}

class BodyWidget extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _CreateState();
  }
}

class _CreateState extends State<BodyWidget> {
  //static final CREATE_POST_URL = 'http://192.168.43.12:8000/getAllProducts/';
  static final CREATE_POST_URL = 'https://jsonplaceholder.typicode.com/posts';
  TextEditingController titleControler = TextEditingController();
  TextEditingController bodyControler = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Metodo POST"),
      ),
      body: Center(
        child: Padding(
          padding: EdgeInsets.all(8.0),
          child: Card(
            elevation: 20.0,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20.0)),
            child: Padding(
              padding: EdgeInsets.all(20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Image.network(
                    "https://brandmark.io/logo-rank/random/beats.png",
                    width: 200.0,
                    height: 200.0,
                  ),
                  SizedBox(height: 20.0),
                  TextField(
                    controller: titleControler,
                    decoration: InputDecoration(
                        prefixIcon: Icon(Icons.access_alarm),
                        hintText: "Escriba el titulo del POST",
                        labelText: 'Titulo de post',
                        border: OutlineInputBorder(
                            borderRadius:
                            BorderRadius.all(Radius.circular(10.0)))),
                  ),
                  SizedBox(height: 10.0),
                  TextField(
                    controller: bodyControler,
                    decoration: InputDecoration(
                        hintText: "Escribe algo",
                        labelText: 'Cuerpo del Post',
                        border: OutlineInputBorder(
                            borderRadius:
                            BorderRadius.all(Radius.circular(10.0)))),
                  ),
                  SizedBox(height: 20.0),
                  RaisedButton(
                    textColor: Colors.white,
                    color: Colors.blue,
                    child: Text("Enviar solicitud"),
                    onPressed: () async {
                      Post postRequest = new Post(
                        userId: "String",
                        id: 1,
                        title: titleControler.text,
                        body: bodyControler.text,
                      );


                      Post postResponse =
                      await createPost(CREATE_POST_URL,
                          body: postRequest.toJson());

                       print(postResponse.id);
                    },
                  )


                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
