class PokemonDetalle {
    PokemonDetalle({
        this.id=0,
        this.name='',
        this.baseExperience=0, 
        this.height=0, 
        this.weight=0, 
        this.gifPokemonFront='', 
        this.gifPokemonBack='', 
    });
    int id;
    String name;
    int baseExperience; 
    int height; 
    int weight; 
    String gifPokemonFront;
    String gifPokemonBack; 

    factory PokemonDetalle.fromJson(Map<String, dynamic> json) => PokemonDetalle(
        id: json['id'],
        name : json['name'], 
        baseExperience : json['base_experience'], 
        height : json['height'], 
        weight : json['weight'],
        gifPokemonFront : json['sprites']['versions']['generation-v']['black-white']['animated']['front_default'], 
        gifPokemonBack : json['sprites']['versions']['generation-v']['black-white']['animated']['back_default'] 

    );
    
}
