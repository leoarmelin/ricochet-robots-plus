//
//  InteractProtocol.swift
//  RicochetRobotsPlus
//
//  Created by Leonardo Armelin on 18/04/23.
//

protocol InteractProtocol {
    func onInteract(with key: KeyCode, for player: Player) -> [Position]
}
