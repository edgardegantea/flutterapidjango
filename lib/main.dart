import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:async';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: '/',
      routes: {
        '/first': (context) => const FirstScreen(),
        '/second': (context) => const SecondScreen(),
      },
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              'You have pushed the button this many times:',
            ),
            Text(
              '$_counter',
              style: Theme.of(context).textTheme.headline4,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ),
      drawer: Drawer(
        child: ListView(
          children: <Widget>[
            const DrawerHeader(
              decoration: BoxDecoration(color: Colors.indigo),
              child: Text(
                'Ebook',
                style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w900,
                    fontSize: 30),
              ),
            ),


            ListTile(
              title: const Text('Autores'),
              leading: const Icon(
                Icons.group,
                color: Color.fromARGB(255, 200, 100, 100),
              ),
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => const ClaseAutor()));
              },
            ),


            ListTile(
              title: const Text('Claseprueba'),
              leading: const Icon(
                Icons.account_balance_sharp,
                color: Color.fromARGB(255, 200, 100, 100),
              ),
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => const ClasePrueba()));
              },
            ),


            ListTile(
              title: const Text('Favoritos'),
              leading: const Icon(
                Icons.favorite,
                color: Color.fromARGB(255, 200, 100, 100),
              ),
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => const Favoritos()));
              },
            ),
            ListTile(
              title: const Text('Autores'),
              leading: const Icon(
                Icons.group,
                color: Colors.indigo,
              ),
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const Autores())
                );
              },
            ),
            ListTile(
              title: const Text('Categorías'),
              leading: const Icon(
                Icons.category,
                color: Colors.indigo,
              ),
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const Categorias()));
              },
            ),
            ListTile(
              title: const Text('Libros'),
              leading: const Icon(
                Icons.book,
                color: Color.fromARGB(255, 0, 0, 255),
              ),
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => Libros()));
              },
            ),
            ListTile(
              title: const Text('Apartados'),
              leading: const Icon(
                Icons.bookmark,
                color: Colors.deepOrange,
              ),
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => const Apartados()));
              },
            ),
          ],
        ),
      ),
    );
  }
}

class FirstScreen extends StatelessWidget {
  const FirstScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('First Screen'),
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            Navigator.pushNamed(context, '/second');
          },
          child: const Text('Launch screen'),
        ),
      ),
    );
  }
}

class SecondScreen extends StatelessWidget {
  const SecondScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Second Screen'),
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            Navigator.pop(context);
          },
          child: const Text('Go back!'),
        ),
      ),
    );
  }
}

class Favoritos extends StatelessWidget {
  const Favoritos({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Favoritos')),
      body: const Center(
        child: Text('Página de favoritos'),
      ),
    );
  }
}

class Autores extends StatelessWidget {
  const Autores({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Autores')),
      body: const Center(
        child: Text('Página de autores'),
      ),
    );
  }
}

class Categorias extends StatelessWidget {
  const Categorias({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Categorías'),
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            Navigator.pop(context);
          },
          child: const Text('Regresar'),
        ),
      ),
    );
  }
}


class Libros extends StatelessWidget {
  const Libros({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Libros'),
      ),
      body: const Center(
        child: Text('Página de Libros'),
      ),
    );
  }
}


class Apartados extends StatelessWidget {
  const Apartados({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Apartados'),
      ),
      body: const Center(
        child: Text('Página de apartados'),
      ),
    );
  }
}


// ////////////////////////////////////
// método fetchAlbum
// ////////////////////////////////////

Future<Album> fetchAlbum() async {
  final response = await http
      .get(Uri.parse('https://jsonplaceholder.typicode.com/albums/1'));

  if (response.statusCode == 200) {
    // If the server did return a 200 OK response,
    // then parse the JSON.
    return Album.fromJson(jsonDecode(response.body));
  } else {
    // If the server did not return a 200 OK response,
    // then throw an exception.
    throw Exception('Failed to load album');
  }
}


class Album {
  final int userId;
  final int id;
  final String title;

  const Album({
    required this.userId,
    required this.id,
    required this.title,
  });

  factory Album.fromJson(Map<String, dynamic> json) {
    return Album(
      userId: json['userId'],
      id: json['id'],
      title: json['title'],
    );
  }
}



class ClasePrueba extends StatefulWidget {
  const ClasePrueba({super.key});

  @override
  State<ClasePrueba> createState() => _ClasePruebaState();
}

class _ClasePruebaState extends State<ClasePrueba> {
  late Future<Album> futureAlbum;

  @override
  void initState() {
    super.initState();
    futureAlbum = fetchAlbum();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Consumo de API'),
      ),
      body: Center(
        child: FutureBuilder<Album>(
          future: futureAlbum,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return Text(snapshot.data!.title);
            } else if (snapshot.hasError) {
              return Text('${snapshot.error}');
            }
            // By default, show a loading spinner.
            return const CircularProgressIndicator();
          },
        ),
      ),

    );
  }
}






// ////////////////////////////////////
// método fetchUsuarios
// ////////////////////////////////////

Future<Autor> fetchAutor() async {
  final response = await http
      .get(Uri.parse('http://localhost:8000/autores'));

  Map data = jsonDecode(response.body);
  if (kDebugMode) {
    print(data);
  }

  if (response.statusCode == 200) {
    // If the server did return a 200 OK response,
    // then parse the JSON.
    return Autor.fromJson(jsonDecode(response.body));
  } else {
    // If the server did not return a 200 OK response,
    // then throw an exception.
    throw Exception('No se cargó información de los autores');
  }
}

class Autor {
  final int AuthoriId;
  final String nombre;
  final String nacionalidad;
  const Autor({
    required this.AuthoriId,
    required this.nombre,
    required this.nacionalidad
  });


  factory Autor.fromJson(Map<String, dynamic> json) {
    return Autor(
      AuthoriId: json['AuthorId'],
      nombre: json['nombre'],
      nacionalidad: json['nacionalidad'],
    );
  }
}



class ClaseAutor extends StatefulWidget {
  const ClaseAutor({super.key});

  @override
  State<ClaseAutor> createState() => _ClaseAutorState();
}

class _ClaseAutorState extends State<ClaseAutor> {
  late Future<Autor> futureAutor;

  @override
  void initState() {
    super.initState();
    futureAutor = fetchAutor();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Consumo de API'),
      ),
      body: Center(
        child: FutureBuilder<Autor>(
          future: futureAutor,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return Text(snapshot.data!.nombre);
            } else if (snapshot.hasError) {
              return Text('${snapshot.error}');
            }
            // By default, show a loading spinner.
            return const CircularProgressIndicator();
          },
        ),
      ),

    );
  }
}




