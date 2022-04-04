import 'package:flutter/material.dart';
import 'package:pokemon/src/models/poekemon_detalle_model.dart';
import 'package:pokemon/src/services/pokemon_services.dart';
bool isLoading = true;
class DescriptionPokemon extends StatefulWidget {
  final String urlPokemon;
  DescriptionPokemon({required this.urlPokemon});

  @override
  State<DescriptionPokemon> createState() => _DescriptionPokemonState();
}

class _DescriptionPokemonState extends State<DescriptionPokemon> {
 PokemonServices pokemonService = PokemonServices(); 
  PokemonDetalle pokemonDetalle = PokemonDetalle();
  
  @override
  void initState() {
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    //cargarDetalle(pokemonService, widget.urlPokemon);
    return Scaffold(
      appBar: AppBar(
         title:const Text('Detalle Pokemon'), 
      ),
      body:Center(
          child: FutureBuilder<PokemonDetalle>(
            future: pokemonService.detallePokemon(widget.urlPokemon),
            builder: (context,snapshot){
              if (snapshot.hasData) {
                PokemonDetalle pokemonDetalle =  snapshot.data as PokemonDetalle;
                return _cargarPokemonDetalle(pokemonDetalle,pokemonService,context);
              }else if(snapshot.hasError){
                return const Text('Error en peticion');
              }else{
                return const CircularProgressIndicator();
              }
            }
          ),
      )
      /*
       (isLoading) ? 
        const Center(
          child: CircularProgressIndicator()
        )
       :Column(
          children: [
            Container(
              width: double.infinity,
              color: Colors.green[300],
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Center(
                  child: Text(pokemonDetalle.name.toUpperCase(),
                    style:const TextStyle(color:Colors.white,
                    fontSize: 25,
                    fontWeight: FontWeight.bold)
                  ),
                ),
              )
            ),
            Container(
              color: Colors.blue.shade200,
              child: Padding(
                padding: const EdgeInsets.only(top:40,bottom: 40),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    FadeInImage(
                        placeholder: const AssetImage('assets/img/pokebola.gif'),
                        image:NetworkImage(pokemonDetalle.gifPokemonFront,scale: 1.0),
                        fit: BoxFit.cover,
                        height: 100,
                      ),
                  
                     FadeInImage(
                          placeholder: const AssetImage('assets/img/pokebola.gif'),
                          image:NetworkImage(pokemonDetalle.gifPokemonBack,scale: 1.0),
                          fit: BoxFit.cover,
                          height: 100,
                      ),
                  ],
                ),
              ),
            ),
            Container(
              color: Colors.amber.shade100,
              child: Padding(
                padding: const EdgeInsets.only(top:20,bottom: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                   const  Text('Experience: ',style: TextStyle(fontSize: 25,fontWeight: FontWeight.bold)),
                    Text(pokemonDetalle.baseExperience.toString(),style: const TextStyle(fontSize: 25,fontWeight: FontWeight.bold)),
                  ],
                ),
              ),
            ),
            Container(
              color: Colors.blueGrey.shade300,
              child: Padding(
                padding: const EdgeInsets.only(top:20,bottom: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    const Text('Height: ',style: TextStyle(fontSize: 25,fontWeight: FontWeight.bold)),
                    Text(pokemonDetalle.height.toString(),style:const TextStyle(fontSize: 25,fontWeight: FontWeight.bold)),
                  ],
                ),
              ),
            ),
            Container(
              color: Colors.lightBlue.shade200,
              child: Padding(
                padding: const EdgeInsets.only(top:20,bottom: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    const Text('Weight: ',style: TextStyle(fontSize: 25,fontWeight: FontWeight.bold)),
                    Text(pokemonDetalle.weight.toString(),style:const TextStyle(fontSize: 25,fontWeight: FontWeight.bold)),
                  ],
                ),
              ),
            ),
            Text(pokemonDetalle.id.toString())
          
          ],
        ),
      */
    );
  }

  void cargarDetalle(PokemonServices pokemonService,String url) async {

    pokemonDetalle = await pokemonService.detallePokemon(url);
    //pokemonService.speciePokemon(pokemonDetalle.id);

      setState(() {
       isLoading=false;
      });
  
  }

  Widget _cargarPokemonDetalle(PokemonDetalle pokemonDetalle,PokemonServices pokemonService,BuildContext context) {
   return  Column(
          children: [
            Container(
              width: double.infinity,
              color: Colors.green[300],
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Center(
                  child: Text(pokemonDetalle.name.toUpperCase(),
                    style:const TextStyle(color:Colors.white,
                    fontSize: 25,
                    fontWeight: FontWeight.bold)
                  ),
                ),
              )
            ),
            Container(
              color: Colors.blue.shade200,
              child: Padding(
                padding: const EdgeInsets.only(top:40,bottom: 40),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    FadeInImage(
                        placeholder: const AssetImage('assets/img/pokebola.gif'),
                        image:NetworkImage(pokemonDetalle.gifPokemonFront),
                        fit: BoxFit.cover,
                        height: 100,
                      ),
                  
                     FadeInImage(
                          placeholder: const AssetImage('assets/img/pokebola.gif'),
                          image:NetworkImage(pokemonDetalle.gifPokemonBack),
                          fit: BoxFit.cover,
                          height: 100,
                      ),
                  ],
                ),
              ),
            ),
            Center(
                child: FutureBuilder<String>(
                  future: pokemonService.speciePokemon(pokemonDetalle.id),
                  builder: (context,snapshot){
                    if (snapshot.hasData) {
                      return Container(
                        color: Colors.cyan,
                        width: double.infinity,
                        child: Padding(
                          padding: const EdgeInsets.only(top:20,bottom: 20,left:20,right: 20),
                          child: Column(
                            children: [
                            const  Text('Descripcion: ',style: TextStyle(fontSize: 25,fontWeight: FontWeight.bold)),
                              Text(snapshot.data.toString(),style: const TextStyle(fontSize: 20,fontWeight: FontWeight.bold)),
                            ],
                          ),
                        ),
                      );
                    }else if(snapshot.hasError){
                      return const Text('Error en peticion');
                    }else{
                      return const CircularProgressIndicator();
                    }
                  }
                ),
            ),
            Container(
              color: Colors.amber.shade100,
              child: Padding(
                padding: const EdgeInsets.only(top:20,bottom: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                   const  Text('Experiencia: ',style: TextStyle(fontSize: 25,fontWeight: FontWeight.bold)),
                    Text(pokemonDetalle.baseExperience.toString(),style: const TextStyle(fontSize: 25,fontWeight: FontWeight.bold)),
                  ],
                ),
              ),
            ),
            Container(
              color: Colors.blueGrey.shade300,
              child: Padding(
                padding: const EdgeInsets.only(top:20,bottom: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    const Text('Altura: ',style: TextStyle(fontSize: 25,fontWeight: FontWeight.bold)),
                    Text(pokemonDetalle.height.toString(),style:const TextStyle(fontSize: 20,fontWeight: FontWeight.bold)),
                  ],
                ),
              ),
            ),

            Container(
              color: Colors.lightBlue.shade200,
              child: Padding(
                padding: const EdgeInsets.only(top:20,bottom: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    const Text('Peso: ',style: TextStyle(fontSize: 25,fontWeight: FontWeight.bold)),
                    Text(pokemonDetalle.weight.toString(),style:const TextStyle(fontSize: 25,fontWeight: FontWeight.bold)),
                  ],
                ),
              ),
            ),
          ],
    );
  }


}