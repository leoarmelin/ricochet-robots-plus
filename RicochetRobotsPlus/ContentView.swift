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

struct TileView: View {
    let tile: any Tile
    let size: CGFloat = 30
    
    var partialWall: PartialWall? {
        tile as? PartialWall
    }
    
    
    var body: some View {
        Rectangle()
            .fill(partialWall?.color ?? tile.color)
            .applyIf(partialWall?.sidesBlock.contains(.top) == true) {
                $0.overlay(Rectangle().fill(.gray).frame(width: 30, height: 4), alignment: .top)
            }
            .applyIf(partialWall?.sidesBlock.contains(.bottom) == true) {
                $0.overlay(Rectangle().fill(.gray).frame(width: 30, height: 4), alignment: .bottom)
            }
            .applyIf(partialWall?.sidesBlock.contains(.left) == true) {
                $0.overlay(Rectangle().fill(.gray).frame(width: 4, height: 30), alignment: .leading)
            }
            .applyIf(partialWall?.sidesBlock.contains(.right) == true) {
                $0.overlay(Rectangle().fill(.gray).frame(width: 4, height: 30), alignment: .trailing)
            }
            .frame(width: size, height: size)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
