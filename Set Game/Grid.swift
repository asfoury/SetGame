//
//  Grid.swift
//  Memorize
//
//  Created by asfoury on 11/2/20.
//

import SwiftUI

struct Grid<Item, ItemView>: View where Item : Identifiable, ItemView : View {
    private var items : [Item]
    private var viewForItem : (Item) -> ItemView
    
    init(_ items: [Item], viewForItem : @escaping (Item) -> ItemView) {
        self.items = items
        self.viewForItem = viewForItem
    }
    
    var body: some View {
        GeometryReader{ geometry in
            self.body(for: GridLayout(itemCount: self.items.count, in: geometry.size))
        }
    }
    
    private func body(for layout : GridLayout) -> some View {
        ForEach(items){ item in
            viewForItem(item)
                .frame(width: layout.itemSize.width, height : layout.itemSize.height)
                .position(layout.location(ofItemAt: items.firstIndex(matching: item)!))
        }
    }
    
    
}
