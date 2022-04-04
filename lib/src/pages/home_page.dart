import 'package:flutter/material.dart';
import 'package:pokemon/src/models/pokemon_lista_model.dart';
import 'package:pokemon/src/models/pokemon_model.dart';
import 'package:pokemon/src/pages/description_pokemon.dart';
import 'package:pokemon/src/services/pokemon_services.dart';

String urlDataG='https://pokeapi.co/api/v2/pokemon';
bool loadData=true;
int contador = 0 ;
String urlNext='';
String urlPrevious='';
List<Pokemon> listaPokemon = [];

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {

  PokemonServices pokemonService = PokemonServices();
  
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Pokemons'),
        ),
        body: Center(
          child: FutureBuilder<PokemonListaModel>(
            future: pokemonService.loadPokemonListaModel(urlDataG),
            builder: (context,snapshot){
              if (snapshot.hasData) {
                PokemonListaModel pokemonListaModel =  snapshot.data as PokemonListaModel;
                return ModelPokemonWidget(pokemonListaModel: pokemonListaModel);
              }else if(snapshot.hasError){
                return const Text('Error en peticion');
              }else{
                return const CircularProgressIndicator();
              }
            }
          ),
        )
      ));
  
  }

}

class ModelPokemonWidget extends StatefulWidget {
  const ModelPokemonWidget({
    Key? key,
    required this.pokemonListaModel,
  }) : super(key: key);

  final PokemonListaModel pokemonListaModel;

  @override
  State<ModelPokemonWidget> createState() => _ModelPokemonWidgetState();
}

class _ModelPokemonWidgetState extends State<ModelPokemonWidget> {

  @override
  void initState() {
    super.initState();
    urlNext=widget.pokemonListaModel.next ?? '';
    urlPrevious=widget.pokemonListaModel.previous ?? '';
    loadDataPokemons(urlDataG);
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: [
          //Text('Total ${widget.pokemonListaModel.count}'),
         (loadData)
          ? const Expanded(
              child:Center(
                child: CircularProgressIndicator()
              )
            )
          : Expanded(
            child: GridView.count(
                crossAxisCount: 3,
                children: listadoPokemon(context, listaPokemon),
              ),
          ),
          Container(
            color: Colors.black45,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                  onPressed: (){
                    if(urlPrevious !=''){
                      loadDataPokemons(urlPrevious);
                    }
                  },
                  child: const Padding(
                    padding: EdgeInsets.only(top: 8,bottom: 8,left: 5,right: 5),
                    child:Text('Previous'),
                  ),
                  style: (urlPrevious =='')
                   ?ElevatedButton.styleFrom( onPrimary: Colors.black, primary: const Color(0xFFcdcdcd))
                   :ElevatedButton.styleFrom( onPrimary: Colors.white, primary: Colors.blue)
                ),
                ElevatedButton(
                  onPressed: (){
                    if(urlNext !=''){
                      loadDataPokemons(urlNext);
                    }
                  },
                  child: const Padding(
                    padding: EdgeInsets.only(top: 8,bottom: 8,left: 20,right: 20),
                    child: Text('Next'),
                  ),
                   style: (urlNext =='')
                   ?ElevatedButton.styleFrom( onPrimary: Colors.black, primary: const Color(0xFFcdcdcd))
                   :ElevatedButton.styleFrom( onPrimary: Colors.white, primary: Colors.blue)
                )
            ]),
          ),
        ],
      ),
    );
  }
  
  void loadDataPokemons(String urlData) async {

    if(urlData.length>33){
        contador = int.parse(urlData.substring(41, urlData.length-9));
    }
  
    PokemonServices pokemonService = PokemonServices();
    setState(() {
      loadData=true;
    });
    PokemonListaModel modeList = await pokemonService.loadPokemonListaModel(urlData);
    List<Pokemon> listaPok = await pokemonService.loadPokemons(urlData);
    setState(() {
       urlDataG=urlData;
       listaPokemon=listaPok;
       urlNext=modeList.next ?? '';
       urlPrevious=modeList.previous ?? '';
       loadData=false;
    });
  }

  List<Widget> listadoPokemon(BuildContext context,List<Pokemon> data) {
  PokemonServices pokemonService = PokemonServices();
  List<Widget> listWidgets= [];
  for(Pokemon item in data){
    contador=contador+1;
    listWidgets.add(  
        Card(
          color: Colors.blueGrey[100],
         child: GestureDetector(
           onTap: (){
              Navigator.push(context,
                MaterialPageRoute(builder: (context) => DescriptionPokemon(urlPokemon: item.url)),
              );
           },
           child: Stack(
             children:[
               Center(
                 child: FutureBuilder<String>(
                    future: pokemonService.fotoPokemon(item.name),
                    builder: (context,snapshot){
                      if (snapshot.hasData) {
                         return  Center(
                              child: FadeInImage(
                                placeholder: const AssetImage('assets/img/pokebola.gif'),
                                image:NetworkImage(snapshot.data as String),
                                fit: BoxFit.cover,
                              ),
                          );
                      }else if(snapshot.hasError){
                        return const Text('Error en peticion');
                      }else{
                        return const CircularProgressIndicator();
                      }
                    }
                  )
               ),
               Container(
                 color: Colors.black26,
                 width: double.infinity,
                 child: Padding(
                   padding: const EdgeInsets.all(8.0),
                   child: Text(item.name.toUpperCase(),
                          style:const TextStyle(color:Colors.white,fontWeight: FontWeight.bold),
                          textAlign: TextAlign.center),
                 )
               )
             ],
           ),
         ),
         
       )
    );
  }
  return listWidgets;
}
}






