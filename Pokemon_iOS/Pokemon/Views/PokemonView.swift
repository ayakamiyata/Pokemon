//
//  PokemonView.swift
//  Pokemon
//
//  Created by 宮田彩花 on 2025/03/12.
//

import SwiftUI

struct PokemonView: View {
    @StateObject var viewModel = PokemonViewModel()
    
    var body: some View {
        NavigationStack {
            VStack {
                ScrollView {
                    LazyVGrid(columns: Array(repeating: .init(), count: 2), spacing: 10){
                        ForEach(viewModel.pokemonListEntity.indices, id: \.self) { index in
                            
                            ZStack {
                                Circle()
                                    .trim(from: 0.5, to: 1.0) //下半分をトリミング
                                    .frame(width: 170, height:170)
                                    .foregroundColor(Color.red)
                                Circle()
                                    .trim(from: 0, to: 0.5) //上半分をトリミング
                                    .frame(width: 170, height:170)
                                    .foregroundColor(Color.white)
                                
                                Button(action: {
                                    print("tap buton")
                                    viewModel.tappedPokemon(pokemon: viewModel.pokemonListEntity[index])
                                }) {
                                    AsyncImage(url: URL(string: viewModel.pokemonListEntity[index].sprites.frontdefault)!) { image in
                                        image
                                            .image?.resizable()
                                            .frame(width: 150, height:150)
                                    }
                                }
                            }
                        }
                        //ボーダーライン
                        .overlay(Circle().stroke(Color.black, lineWidth: 1.0))
                    }
                }
            }
            
            .navigationDestination(isPresented: $viewModel.navigateToDetail) {
                PokemonShowView(pokemon: viewModel.selectedPokemon)
            }
        }
    }
}


