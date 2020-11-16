//
//  ContentView.swift
//  Set Game
//
//  Created by asfoury on 11/12/20.
//

import SwiftUI

struct ContentView: View {
    @ObservedObject var viewModel : SetGameViewModel
    @State var drawn: Bool = false
    @State var animationDisabled = false
    var body: some View {
        VStack{
            GeometryReader { geometry in
                    Grid(viewModel.table){ card in
                        Group{
                            if drawn {
                                CardView(card: card).transition(AnyTransition.offset(x:  getRandomInInterval(min: -1000,max: geometry.size.width+1000), y: getRandomInInterval(min: -1000,max: geometry.size.height+1000) )).animation(animationDisabled ? .none : .easeInOut(duration: 2)).padding().contentShape(Rectangle()).onTapGesture {
                                    viewModel.chooseCard(card: card)
                                    //animationDisabled = false
                                }
                            }
                        }
                    }
            }
            HStack{
                Button("Draw cards"){
                    viewModel.draw3Cards()
                }.disabled(!viewModel.canDrawCards())
                Spacer()
                VStack {
                    Text("cards left")
                    Text("\((viewModel.numberOfCardsInDec()))").foregroundColor(.red)
                }.font(.caption)
                Spacer()
                Button("New Game"){
                    viewModel.newGame()
                }
            }.padding()
           
        }.onAppear{
            withAnimation(.easeInOut){
                drawn.toggle()
            }

        }
        
    }
    
    func getRandomInInterval(min : CGFloat , max : CGFloat) -> CGFloat {
        let coin = Int.random(in: 0...1)
        return coin % 2 == 0 ? CGFloat.random(in: min...0) : CGFloat.random(in: max...10000)
    }
    
}


struct CardView : View {
    var card : SetGame<SetGameViewModel.SetShape, SetGameViewModel.Pattern, Color>.Card
    
    
    var body : some View {
        GeometryReader { geometry in
            ZStack {
                HStack{
                    ForEach(0..<card.numberOnCard){ cardIndex in
                        if card.shape == SetGameViewModel.SetShape.capsule {
                            if card.filing == .empty {
                                Capsule().stroke(card.color).frame(width: geometry.size.width / 6, height: geometry.size.height / 3)
                            } else {
                                Capsule().fill(card.filing == SetGameViewModel.Pattern.striped ? card.color.opacity(0.3) : card.color).frame(width: geometry.size.width / 6, height: geometry.size.height / 3)
                            }
                            
                        } else if card.shape == SetGameViewModel.SetShape.diamond {
                            if card.filing == .empty {
                                Rectangle().stroke(card.color).frame(width: geometry.size.width / 6, height: geometry.size.height / 3)
                            } else {
                                Rectangle().fill(card.filing == SetGameViewModel.Pattern.striped ? card.color.opacity(0.3) : card.color).frame(width: geometry.size.width / 6, height: geometry.size.height / 3)
                            }
                        }else {
                            if card.filing == .empty {
                                Rectangle().rotation(Angle.degrees(45)).stroke(card.color).frame(width: geometry.size.width / 6, height: geometry.size.width / 6)
                            } else {
                                Rectangle().rotation(Angle.degrees(45)).fill(card.filing == SetGameViewModel.Pattern.striped ? card.color.opacity(0.3) : card.color).frame(width:geometry.size.width / 6, height: geometry.size.width / 6)
                            }
                        }
                    }
                }
                GeometryReader { geo in
                    RoundedRectangle(cornerRadius: 10.0).stroke(card.isSelected ? Color.orange : Color.black,lineWidth: 3).aspectRatio(geo.size.width/geo.size.height,contentMode: .fit)
                }
            }
        }
          
    }
    
    func getColorFromPattern(pattern : SetGameViewModel.Pattern) -> Color {
        switch pattern {
            case .empty : return Color.red
            case .striped : return Color.blue
            case .filled : return Color.red.opacity(0.3)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView(viewModel: SetGameViewModel())
    }
}
