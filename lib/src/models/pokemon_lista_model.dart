class PokemonListaModel {

    PokemonListaModel({
        this.count=0,
        this.next,
        this.previous,
    });

    int count;
    String? next;
    String? previous;

    factory PokemonListaModel.fromJson(Map<String, dynamic> json) => PokemonListaModel(
        count:    json["count"],
        next:     json["next"],
        previous: json["previous"],
    );
}
