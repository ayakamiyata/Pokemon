//
//  PokemonViewModel.swift
//  Pokemon
//
//  Created by 宮田彩花 on 2025/03/13.
//

import Foundation
import SwiftUICore

@MainActor

final class PokemonViewModel: ObservableObject {
    init() {
        fetchPokemonList()
    } //ページを開いた際に必ず最初に出力されるようにするためのコードini()
    
    @Published var pokemonEntity: PokemonEntity?
    @Published var pokemonListEntity: [PokemonEntity] = []
    
    @Published var navigateToDetail = false
    @Published var selectedPokemon: PokemonEntity?
    let pokemonlistURL: [URL] = (1...151).map{URL(string: "https://pokeapi.co/api/v2/pokemon/\($0)")!}
    
    func navigateToDetails() {
        navigateToDetail = true
    }
    
    func tappedPokemon(pokemon: PokemonEntity) {
        navigateToDetail = true
        selectedPokemon = pokemon
    }
    
    func fetchPokemonList() {
        Task {
            do {
                var responsePokemonEntity: [PokemonEntity] = []
                try await withThrowingTaskGroup(of: (Data, URLResponse).self) { group in
                    for url in pokemonlistURL {
                        group.addTask {
                            let (data, response) = try await URLSession.shared.data(from: url)
                            return (data, response)
                        }
                    }
                    
                    for try await (data, _) in group {
                        let decoder = JSONDecoder()
                        let pokemonEntity = try decoder.decode(PokemonEntity.self, from: data)
                        responsePokemonEntity.append(pokemonEntity)
                        responsePokemonEntity.sort { $0.id < $1.id }
                        self.pokemonListEntity = responsePokemonEntity
                        
                        print("\(pokemonListEntity)")
                    }
                }
            }
        }
    }
}
