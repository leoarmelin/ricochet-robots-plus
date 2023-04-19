//
//  MainViewModel.swift
//  RicochetRobotsPlus
//
//  Created by Leonardo Armelin on 18/04/23.
//

import SwiftUI

class MainViewModel: ObservableObject {
    @Published var board: [any Tile]
    @Published var playerList: [Player]
    let boardSize: Int
    private var playerSelect = 0
    
    init() {
        self.board = Boards.boardOne
        self.boardSize = Int(Double(Boards.boardOne.count).squareRoot())
        
        self.playerList = []
        playerList.append(Player(color: .purple, position: getInitialPosition()))
        playerList.append(Player(color: .green, position: getInitialPosition()))
        playerList.append(Player(color: .blue, position: getInitialPosition()))
        
        updateBoardPlayer(for: playerList[0].position, player: playerList[0])
        updateBoardPlayer(for: playerList[1].position, player: playerList[1])
        updateBoardPlayer(for: playerList[2].position, player: playerList[2])
    }
    
    func getTileFromPosition(_ position: Position) -> any Tile {
        return board.first { tile in tile.position == position }!
    }
    
    private func updateBoardPlayer(for position: Position, player: Player?) {
        guard
            let index = board.firstIndex(where: { tile in tile.position == position })
        else { return }
        
        if let previousIndex = board.firstIndex(where: { tile in tile.position == player?.position }) {
            switch board[previousIndex] {
            case var emptyTile as EmptyTile:
                emptyTile.player = nil
                board[previousIndex] = emptyTile
            case var partialWall as PartialWall:
                partialWall.player = nil
                board[previousIndex] = partialWall
                
            default:
                break
            }
        }
        
        switch board[index] {
        case var emptyTile as EmptyTile:
            emptyTile.player = player
            board[index] = emptyTile
        case var partialWall as PartialWall:
            partialWall.player = player
            board[index] = partialWall
            
        default:
            break
        }
    }
    
    func onKeyPress(_ key: KeyCode) {
        guard
            let newPosition = getNewPosition(for: playerList[playerSelect], key: key).first
        else { return }

        updateBoardPlayer(for: newPosition, player: playerList[playerSelect])
        playerList[playerSelect].position = newPosition
    }
    
    private func getNewPosition(for player: Player, key: KeyCode) -> [Position] {
        let filteredList = filterListBy(key: key, player: player)
        var firstBlockerTile: Tile? = nil
        
        for tile in filteredList {
            if firstBlockerTile != nil {
                continue
            }
            switch tile {
            case is Wall:
                firstBlockerTile = tile
                break
            case let castedTile as PartialWall:
                if (castedTile.player != nil && castedTile.player?.id != player.id) || castedTile.isBlockingMovement(for: key, player.position) {
                    firstBlockerTile = tile
                    break
                }
            case let emptyTile as EmptyTile:
                if emptyTile.player != nil && emptyTile.player?.id != player.id {
                    firstBlockerTile = tile
                    break
                }

            default:
                continue
            }
        }
        
        if firstBlockerTile == nil {
            firstBlockerTile = filteredList.last
        }
        
        switch firstBlockerTile {
        case let wall as Wall:
            return wall.onInteract(with: key)
        case let partialWall as PartialWall:
            return partialWall.onInteract(with: key)
        case let emptyTile as EmptyTile:
            return emptyTile.onInteract(with: key)
        default:
            if let lastItem = filteredList.last {
                return [lastItem.position]
            }
            return []
        }
    }
    
    private func getInitialPosition() -> Position {
        let playerListPositions = playerList.map { $0.position }
        let filteredBoard = board.filter { tile in
            tile is EmptyTile && !playerListPositions.contains(tile.position)
        }
        return filteredBoard.randomElement()!.position
    }
    
    func selectPlayerBy(id: UUID) {
        guard
            let index = playerList.firstIndex(where: { $0.id == id })
        else { return }
        
        self.playerSelect = index
    }
    
    func filterListBy(key: KeyCode, player: Player) -> [Tile] {
        var filteredList: [Tile]

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
}
