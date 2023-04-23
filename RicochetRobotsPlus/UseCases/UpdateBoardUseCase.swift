//
//  UpdateBoardForPlayerUseCase.swift
//  RicochetRobotsPlus
//
//  Created by Leonardo Armelin on 22/04/23.
//

struct UpdateBoardUseCase {
    func update(_ board: inout [any Tile], with newPosition: Position, using player: Player) {
        // Assure a tile with new position exists
        guard
            let tileIndex = board.firstIndex(where: { $0.position == newPosition })
        else { return }
        
        // Remove player from previous position
        if let previousIndex = board.firstIndex(where: { tile in tile.position == player.position }) {
            switch board[previousIndex] {
            case var emptyTile as EmptyTile:
                emptyTile.playerId = nil
                board[previousIndex] = emptyTile
            case var partialWall as PartialWall:
                partialWall.playerId = nil
                board[previousIndex] = partialWall
                
            default:
                break
            }
        }
        
        // Add player to new position
        switch board[tileIndex] {
        case var emptyTile as EmptyTile:
            emptyTile.playerId = player.id
            board[tileIndex] = emptyTile
        case var partialWall as PartialWall:
            partialWall.playerId = player.id
            board[tileIndex] = partialWall
            
        default:
            break
        }
    }
}
