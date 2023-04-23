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
    
    private let boardFilterUseCase = BoardFilterUseCase()
    private let getBoardTileUseCase = GetBoardTileUseCase()
    private let updateBoardUseCase = UpdateBoardUseCase()
    private let getFirstBlockingTileUseCase = GetFirstBlockingTileUseCase()
    
    init() {
        self.board = Boards.boardOne
        self.boardSize = Int(Double(Boards.boardOne.count).squareRoot())
        
        self.playerList = []
        playerList.append(Player(color: .purple, position: getInitialPosition()))
        playerList.append(Player(color: .green, position: getInitialPosition()))
        playerList.append(Player(color: .blue, position: getInitialPosition()))
        
        updateBoardUseCase.update(&board, with: playerList[0].position, using: playerList[0])
        updateBoardUseCase.update(&board, with: playerList[1].position, using: playerList[1])
        updateBoardUseCase.update(&board, with: playerList[2].position, using: playerList[2])
    }
    
    func getTileFromPosition(_ position: Position) -> any Tile {
        return getBoardTileUseCase.getTile(for: board, on: position)
    }
    
    func onKeyPress(_ key: KeyCode) {
        guard
            let newPosition = getNewPosition(for: playerList[playerSelect], key: key).first
        else { return }

        updateBoardUseCase.update(&board, with: newPosition, using: playerList[playerSelect])
        playerList[playerSelect].position = newPosition
    }
    
    private func getNewPosition(for player: Player, key: KeyCode) -> [Position] {
        let filteredList = boardFilterUseCase.filterList(for: board, with: key, using: player)
        
        let firstBlockerTile = getFirstBlockingTileUseCase.getFirstBlockingTile(for: filteredList, with: key, using: player)
        
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
}
