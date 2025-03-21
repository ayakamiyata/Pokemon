//
//  PokemonShowView.swift
//  Pokemon
//
//  Created by 宮田彩花 on 2025/03/19.
//

import SwiftUI

struct PokemonShowView: View {
    @StateObject var viewModel = PokemonViewModel()
    
    var pokemon: PokemonEntity?
    
    var body: some View {
        VStack {
            Text(pokemon?.id.description ?? "")
            AsyncImage(url: URL(string: pokemon?.sprites.frontdefault ?? "") ) { image in
                image
                    .image?.resizable()
                    .frame(width: 200, height:200)
            }
            Text(pokemon?.name ?? "")
            Text(pokemon?.types.first?.type.name ?? "")
        }
    }
}
