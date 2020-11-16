//
//  Set_GameApp.swift
//  Set Game
//
//  Created by asfoury on 11/12/20.
//

import SwiftUI

@main
struct Set_GameApp: App {
    var body: some Scene {
        WindowGroup {
            let game = SetGameViewModel()
            ContentView(viewModel: game)
        }
    }
}
