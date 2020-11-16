//
//  SetGameViewModel.swift
//  Set Game
//
//  Created by asfoury on 11/12/20.
//

import SwiftUI

class SetGameViewModel : ObservableObject {
    @Published private var model : SetGame<SetShape, Pattern, Color> = SetGameViewModel.createSetGame()
    enum Pattern {
        case filled
        case striped
        case empty
    }
    
    enum SetShape {
        case capsule
        case rectangle
        case diamond
    }
    
    private static func createSetGame() -> SetGame<SetShape, Pattern, Color> {
        let shapes : [SetShape] = [ .capsule, .rectangle, .diamond]
        let colors : [Color] = [.green,.blue,.red]
        let numbers : [Int] = [1,2,3]
        let patterns : [Pattern] = [.empty,.filled,.striped]
        
        var cardsArray : Array<SetGame<SetShape, Pattern, Color>.Card> {
            var count = 0
            var cards = Array<SetGame<SetShape, Pattern, Color>.Card>()
            for shape in shapes {
                for color in colors {
                    for number in numbers {
                        for pattern in patterns {
                            let card = SetGame<SetShape, Pattern, Color>.Card(isSelected: false, id: count, isOnTable: false, shape: shape, numberOnCard: number, filing: pattern, color: color)
                            cards.append(card)
                            count += 1
                        }
                    }
                }
            }
            return cards
        }
        
        
        return SetGame { cardIndex in
            cardsArray[cardIndex]
        }
    }
    
    func newGame() {
        model = SetGameViewModel.createSetGame()
    }
    
    func chooseCard(card : SetGame<SetShape, Pattern, Color>.Card ) {
        model.choose(card: card)
    }
    
    func draw3Cards(){
        model.draw3CardsFromDeck()
    }
    
    func canDrawCards() -> Bool{
        model.canDrawCards()
    }
    
    func numberOfCardsInDec() -> Int {
        model.getNumberOfCardsInDeck()
    }
    
    // MARK: - Access The Model
    var table : Array<SetGame<SetShape, Pattern, Color>.Card> {
        model.table
    }
    
   
    
   
    
    
    
}
