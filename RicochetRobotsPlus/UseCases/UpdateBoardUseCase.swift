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
        board.forEach{ tile in
            switch tile {
            case var emptyTile as EmptyTile:
                if player.id == emptyTile.playerId {
                    emptyTile.playerId = nil
                    if let index = board.firstIndex(where: { $0.position == emptyTile.position }) {
                        board[index] = emptyTile
                    }
                }
            case var partialWall as PartialWall:
                if player.id == partialWall.playerId {
                    partialWall.playerId = nil
                    if let index = board.firstIndex(where: { $0.position == partialWall.position }) {
                        board[index] = partialWall
                    }
                }

            case var trampoline as Trampoline:
                if player.id == trampoline.playerId {
                    trampoline.playerId = nil
                    if let index = board.firstIndex(where: { $0.position == trampoline.position }) {
                        board[index] = trampoline
                    }
                }

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
        case var trampoline as Trampoline:
            trampoline.playerId = player.id
            board[tileIndex] = trampoline
            
        default:
            break
        }
        
        let filtered = board.filter { tile in
            switch tile {
            case let emptyTile as EmptyTile:
                return emptyTile.playerId != nil
            case let partialWall as PartialWall:
                return partialWall.playerId != nil
            case let trampoline as Trampoline:
                return trampoline.playerId != nil
            default:
                return false
            }
        }
        print("new-board \(filtered.map({$0.position}))")
    }
}
