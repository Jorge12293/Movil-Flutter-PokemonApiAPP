import 'dart:convert' as convert;

import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:pokemon/src/models/poekemon_detalle_model.dart';
import 'package:pokemon/src/models/pokemon_lista_model.dart';
import 'package:pokemon/src/models/pokemon_model.dart';

class PokemonServices {

  List<Pokemon> pokemonsList =[];
 
  PokemonServices();

  Future<PokemonListaModel> loadPokemonListaModel(String urlDat) async{

    PokemonListaModel pokemonListaModel = PokemonListaModel();

   // final url = Uri.https('pokeapi.co', '/api/v2/pokemon');
  
    var url =Uri.parse(urlDat);
    final resp = await http.get(url);
    if (resp.statusCode == 200) {
     
     final jsonResponse = convert.jsonDecode(resp.body);
     pokemonListaModel =  PokemonListaModel.fromJson(jsonResponse);

     return pokemonListaModel;
    } else {
      debugPrint('Fallo Conexion: ${resp.statusCode}');
      return pokemonListaModel;
    }
  }


  Future<List<Pokemon>> loadPokemons(String urlData) async{
    List<Pokemon> listaPokemon=[];

    var url =Uri.parse(urlData);
    final resp = await http.get(url);
    if (resp.statusCode == 200) {
     final jsonResponse = convert.jsonDecode(resp.body);
     final pokemonsData = jsonResponse['results']; 

     for (var item in pokemonsData) {
      listaPokemon.add(Pokemon.fromJson(item));
     }
    
     return listaPokemon;

    } else {
      debugPrint('Fallo Conexion: ${resp.statusCode}');
      return listaPokemon;
    }
  }


 Future<PokemonDetalle> detallePokemon(String urlPokemon) async{
    PokemonDetalle pokemonDetalle = PokemonDetalle();
    var url =Uri.parse(urlPokemon);
    final resp = await http.get(url);
    if(resp.statusCode == 200){
      final jsonResponse = convert.jsonDecode(resp.body);
      pokemonDetalle = PokemonDetalle.fromJson(jsonResponse);
    }
  
    return pokemonDetalle;
  }

   Future<String> speciePokemon(int idPokemon) async{
    var url =Uri.parse('https://pokeapi.co/api/v2/pokemon-species/$idPokemon/');
    final resp = await http.get(url);
    if(resp.statusCode == 200){
      final jsonResponse = convert.jsonDecode(resp.body);
      final pokemonsData =jsonResponse['flavor_text_entries'];
      for (var item in pokemonsData) {
        if(item['language']['name']=='es'){
         return item['flavor_text'];
        }
      }
    }
    return '';
  }


  Future<String> fotoPokemon(String namePokemon) async{
    var url =Uri.parse('https://pokeapi.co/api/v2/pokemon/${namePokemon}/');
    final resp = await http.get(url);
    if(resp.statusCode == 200){
      final jsonResponse = convert.jsonDecode(resp.body);
      final pokemonsData =jsonResponse['sprites']['front_default'];
      return pokemonsData;
    }
    return '';
  }

  //ESPECIE
  //https://pokeapi.co/api/v2/pokemon-species/1/
  //Nombre Pokemon
  //https://pokeapi.co/api/v2/ability/{id or name}/



}