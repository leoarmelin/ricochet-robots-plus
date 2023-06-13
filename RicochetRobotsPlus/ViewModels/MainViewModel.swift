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
        let filteredList = boardFilterUseCase.filterList(for: board, with: key, using: playerList[playerSelect])
        
        let positionList = getNewPosition(for: filteredList, with: key, using: playerList[playerSelect], board: board)
        
        for i in 0..<positionList.count {
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.3 * Double(i)) { [self] in
                updateBoardUseCase.update(&board, with: positionList[i], using: playerList[playerSelect])
                playerList[playerSelect].position = positionList[i]
            }
        }
    }
    
    private func getNewPosition(for filteredList: [any Tile], with key: KeyCode, using player: Player, board: [any Tile]) -> [Position] {
        var pivotBoard = board
        let firstBlockerTile = getFirstBlockingTileUseCase.getFirstBlockingTile(for: filteredList, with: key, using: player)
        
        switch firstBlockerTile {
        case let wall as Wall:
            return wall.onInteract(with: key, for: player)
        case let partialWall as PartialWall:
            return partialWall.onInteract(with: key, for: player)
        case let emptyTile as EmptyTile:
            return emptyTile.onInteract(with: key, for: player)
        case let trampoline as Trampoline:
            let newDirection = trampoline.ricochetFrom(key)
            var filteredListFromTrampoline = boardFilterUseCase.filterList(
                for: pivotBoard,
                with: newDirection,
                using: trampoline.position
            )
            let positionToTrampoline = trampoline.onInteract(with: key, for: player)
            
            updateBoardUseCase.update(&filteredListFromTrampoline, with: trampoline.position, using: player)
            updateBoardUseCase.update(&pivotBoard, with: trampoline.position, using: playerList[playerSelect])
            playerList[playerSelect].position = trampoline.position

            let positionFromTrampoline = getNewPosition(for: filteredListFromTrampoline, with: newDirection, using: playerList[playerSelect], board: pivotBoard)
            
            return positionToTrampoline + positionFromTrampoline
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
