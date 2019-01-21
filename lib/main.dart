import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;


void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.teal,
      ),
      home: MyHomePage(title: 'WHATSAPP AFRICAIN'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
// deux variable defini
  String phpMsg;
  String regInfo;

  TextEditingController user = new TextEditingController();
  TextEditingController pass = new TextEditingController();
  TextEditingController email= new TextEditingController();
  TextEditingController num= new TextEditingController();


  // la fonction qui envoi les donnees dans le formulaire
  sendData() async{

    final response = await http.post("http://172.19.1.129/mb/index.php", body:{
      "username":user.text,
      "password":pass.text,
      "email":email.text,
      "numero":num.text,
    });

    //les info recu a la soumission du formulaire avec succes ou pas
    //---- Info -------
    phpMsg =  response.body.toString();
    setState(() {
      if(phpMsg==null){
        regInfo = "veuillez vous enregistrer ";
      }else{
        regInfo =  "enregistrement effectué avec succes";
      }
    });

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),

      // DEBUT DU MENU PLACE A GAUCHE QUI EST LE DRAWER
        drawer: Drawer(
          child: ListView(
            // nous enlevons tous les padding par defaut dans le drawer
            padding: EdgeInsets.zero,
            children: <Widget>[
              DrawerHeader(
                child: Text('Menu principal', style: TextStyle(fontSize: 30.0,color: Colors.white),),
                decoration:BoxDecoration(
                  color: Colors.teal,

                ),
              ),
              ListTile(
                title: Text('mes contact', style: TextStyle(fontSize: 30.0,color: Colors.teal),),
                onTap: (){
                  // Mise à jour de l'état de l'application
                  // ...
                  // Puis ferme le tiroir
                  Navigator.pop(context);
                },
              ),
              ListTile(
                title: Text('parametre', style: TextStyle(fontSize: 30.0,color: Colors.teal),),
                onTap:(){
              Navigator.pop(context);
              },

              ),
            ],
          ),
        ),
      // FIN DU MENU PLACE A GAUCHE KI ES LE DRAWER
      body: Center(

        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            // pour ajouter un background image
            // fin dajout du background
            Text('Enregistrement',style: TextStyle(fontSize:30.0,color:Colors.black),
            ),
            Text('$regInfo',style: TextStyle(fontSize:20.0, color:Colors.green),),


            // debut dut champ su nom
            TextFormField(//--- name ------
              controller: user,
              decoration: const InputDecoration(
                icon: Icon(Icons.person),
                hintText: 'vous vous appelez ...',
                labelText: 'Nom *',
              ),
              onSaved: (String value) {
                // This optional block of code can be used to run
                // code when the user saves the form.
              },
              validator: (String value) {
                return value.contains('@') ? 'Do not use the @ char.' : null;
              },
            ),

            // debut du champ de l'email
            TextFormField(
              controller: email,
              decoration: const InputDecoration(
                icon: Icon(Icons.email),
                hintText: 'votre adresse mail',
                labelText: 'email*',
              ),
              onSaved: (String value){

              },
              validator: (String value){
                return value.contains('@') ? 'Do not use the @ char.' : null;
              },

            ),

            // DEBUT DU CHAMP DU NUMERO

            TextFormField(
              controller: num,
              decoration: const InputDecoration(
                icon: Icon(Icons.confirmation_number),
                hintText: 'votre numero',
                labelText: 'numero*',
              ),
              onSaved: (String value){

              },
              validator: (String value){
                return value.contains('@') ? 'Do not use the @ char.' : null;
              },
            ),


            // debut du champ du mot de passe
            TextFormField(
              controller: pass,
              obscureText: true,
              decoration: const InputDecoration(
                icon: Icon(Icons.lock),
                hintText: 'votre mot de passe ?',
                labelText: 'mot de passe *',
              ),
              onSaved: (String value) {
                // This optional block of code can be used to run
                // code when the user saves the form.
              },
              validator: (String value) {
                return value.contains('@') ? 'Do not use the @ char.' : null;
              },
            ),



          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: (){
          sendData();
          user.clear();
          pass.clear();
          email.clear();
          num.clear();
        },
        tooltip: 'Increment',
        child: Icon(Icons.send),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
