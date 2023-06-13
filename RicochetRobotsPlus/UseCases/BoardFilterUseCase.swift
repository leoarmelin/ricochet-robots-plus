//
//  BoardFilterUseCase.swift
//  RicochetRobotsPlus
//
//  Created by Leonardo Armelin on 22/04/23.
//

import SwiftUI

struct BoardFilterUseCase {
    func filterList(for board: [any Tile], with key: KeyCode, using player: Player) -> [any Tile] {
        var filteredList: [any Tile]

        switch key {
        case .arrowUp:
            filteredList = board.filter { tile in tile.position.x == player.position.x && tile.position.y <= player.position.y }
            filteredList.sort { $0.position.y > $1.position.y }
            
        case .arrowDown:
            filteredList = board.filter { tile in tile.position.x == player.position.x && tile.position.y >= player.position.y }
            filteredList.sort { $0.position.y < $1.position.y }
            
        case .arrowLeft:
            filteredList = board.filter { tile in tile.position.x <= player.position.x && tile.position.y == player.position.y }
            filteredList.sort { $0.position.x > $1.position.x }
            
        case .arrowRight:
            filteredList = board.filter { tile in tile.position.x >= player.position.x && tile.position.y == player.position.y }
            filteredList.sort { $0.position.x < $1.position.x }
        }
        
        return filteredList
    }
    
    func filterList(for board: [any Tile], with key: KeyCode, using position: Position) -> [any Tile] {
        var filteredList: [any Tile]

        switch key {
        case .arrowUp:
            filteredList = board.filter { tile in tile.position.x == position.x && tile.position.y <= position.y }
            filteredList.sort { $0.position.y > $1.position.y }
            
        case .arrowDown:
            filteredList = board.filter { tile in tile.position.x == position.x && tile.position.y >= position.y }
            filteredList.sort { $0.position.y < $1.position.y }
            
        case .arrowLeft:
            filteredList = board.filter { tile in tile.position.x <= position.x && tile.position.y == position.y }
            filteredList.sort { $0.position.x > $1.position.x }
            
        case .arrowRight:
            filteredList = board.filter { tile in tile.position.x >= position.x && tile.position.y == position.y }
            filteredList.sort { $0.position.x < $1.position.x }
        }
        
        return filteredList
    }
}
