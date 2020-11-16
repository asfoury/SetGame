//
//  SetGameModel.swift
//  Set Game
//
//  Created by asfoury on 11/12/20.
//

import Foundation

struct SetGame<Shape, Filing, Color> where Shape : Equatable, Filing : Equatable, Color : Equatable {
    private(set) var deck : [Card]
    private(set) var table : [Card]
    private var selectedCards : [Card]
    private let deckSize : Int = 81
    private(set) var initTableSize : Int = 12
    
    mutating func choose(card : Card){
        printGameStats()
        let index = self.selectedCards.firstIndex(matching: card)
        if index != nil {
            self.selectedCards.remove(at: index!)
            let new_card = toggleCardSelection(card: card)
            let table_index = self.table.firstIndex(matching: card)
            self.table[table_index!] = new_card
            return
            
        }
        
        if(self.selectedCards.count == 3){
            // if they form a match
            
            // if they dont form a match
            for card in selectedCards {
                let index = table.firstIndex(matching: card)!
                self.table[index] = toggleCardSelection(card: card)
            }
            // make new card selected
            self.selectedCards =  Array<Card>()
            let index = table.firstIndex(matching: card)!
            let new_card = toggleCardSelection(card: card)
            self.table[index] = new_card
            self.selectedCards.append(new_card)
        }
        else if (self.selectedCards.count == 2){
            // add card to the selected cards set
            let index = table.firstIndex(matching: card)!
            let new_card = toggleCardSelection(card: card)
            self.table[index] = new_card
            self.selectedCards.append(new_card)
            //  when adding the 3rd card check if form valid set
            if checkIfThreeCardsFormValidSet(c1: self.selectedCards[0], c2: self.selectedCards[1], c3: self.selectedCards[2]) {
               // remove cards from table
                for card in selectedCards {
                    let index = self.table.firstIndex(matching: card)!
                    self.table.remove(at: index)
                }
                // remove 3 cards from selected cards
                self.selectedCards = Array<Card>()
            }
            else {
                print("NOT VALID")
            }
            
        }
        else if(self.selectedCards.count < 3){
            let index = table.firstIndex(matching: card)!
            let new_card = toggleCardSelection(card: card)
            self.table[index] = new_card
            self.selectedCards.append(new_card)
        }
        print(self.selectedCards.count)
    }
    
    func toggleCardSelection(card: Card) -> Card {
        let card = Card(isSelected: !card.isSelected, id: card.id, isOnTable: card.isOnTable, shape: card.shape, numberOnCard: card.numberOnCard, filing: card.filing, color: card.color)
        return card
    }
    
    func checkIfThreeCardsFormValidSet(c1: Card, c2 : Card, c3 : Card) -> Bool {
        // for each feature check if the same or diff
        //
        if !checkIfPairwiseEqualOrDiff(v1: c1.color, v2: c2.color, v3: c3.color) {
            return false
        }
        if !checkIfPairwiseEqualOrDiff(v1: c1.shape, v2: c2.shape, v3: c3.shape) {
            return false
        }
        if !checkIfPairwiseEqualOrDiff(v1: c1.numberOnCard, v2: c2.numberOnCard, v3: c3.numberOnCard) {
            return false
        }
        if !checkIfPairwiseEqualOrDiff(v1: c1.filing, v2: c2.filing, v3: c3.filing) {
            return false
        }
        return true
    }
    
    func checkIfPairwiseEqualOrDiff<T : Equatable>(v1 : T, v2 : T, v3: T) -> Bool {
        if v1 == v2 && v1 == v3 && v2==v3 {
            return true
        }
        else if v1 != v2 && v1 != v2 && v2 != v3 {
            return true
        }
        else {
            return false
        }
    }
    

    func printGameStats() {
        print("Cards in deck \(self.deck.count), Cards on table \(self.table.count)")
    }
    
    func canDrawCards() -> Bool {
        return deck.count >= 3 && table.count <= 12
    }
    
    mutating func draw3CardsFromDeck() {
        if deck.count >= 3 && table.count <= 12 {
            let nbCards = deck.count
            let card1 = deck[nbCards-1]
            let card2 = deck[nbCards-2]
            let card3 = deck[nbCards-3]
            table.append(card1)
            table.append(card2)
            table.append(card3)
            let index1 = deck.firstIndex(matching: card1)!
            deck.remove(at: index1)
            let index2 = deck.firstIndex(matching: card2)!
            deck.remove(at: index2)
            let index3 = deck.firstIndex(matching: card3)!
            deck.remove(at: index3)
        }
    }
    
    func getNumberOfCardsInDeck() -> Int {
        self.deck.count
    }
    
    
    init(cardContentFactory : (Int) -> Card) {
        deck = Array<Card>()
        table = Array<Card>()
        selectedCards = Array<Card>()
        for cardIndex in  0..<deckSize {
            let card = cardContentFactory(cardIndex)
            deck.append(card)
        }
        deck.shuffle()
        for cardNumber in 0..<initTableSize {
            let card = deck[cardNumber]
            table.append(card)
            deck.remove(at: cardNumber)
        }
    }
    
    struct Card : Identifiable {
        var isSelected : Bool
        var id : Int
        var isOnTable : Bool
        
        var shape : Shape
        var numberOnCard : Int
        var filing : Filing
        var color : Color
        
    }
}
