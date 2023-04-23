//
//  ContentView.swift
//  RicochetRobotsPlus
//
//  Created by Leonardo Armelin on 18/04/23.
//

import SwiftUI

struct ContentView: View {
    @StateObject private var viewModel = MainViewModel()
    let size: CGFloat = 30
    
    var body: some View {
        ZStack(alignment: .topLeading) {
            VStack(spacing: 0) {
                ForEach(0..<viewModel.boardSize, id: \.self) { row in
                    HStack(spacing: 0) {
                        ForEach(0..<viewModel.boardSize, id: \.self) { col in
                            VStack {
                                TileView(tile: viewModel.getTileFromPosition(Position(x: col, y: row)))
                            }
                        }
                    }
                }
            }
            
            ForEach(viewModel.playerList, id: \.id) { player in
                Circle()
                    .fill(player.color)
                    .frame(width: 24, height: 24)
                    .offset(
                        x: CGFloat(player.position.x) * 30,
                        y: CGFloat(player.position.y) * 30
                    )
                    .animation(.easeInOut, value: player.position)
                    .frame(width: 30, height: 30)
                    .onTapGesture {
                        viewModel.selectPlayerBy(id: player.id)
                    }
            }
            
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .onKeyPress(onKeyPress: viewModel.onKeyPress)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
