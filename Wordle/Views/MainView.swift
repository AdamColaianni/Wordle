//
//  ContentView.swift
//  Wordle
//
//  Created by 90310013 on 2/17/24.
//

import SwiftUI

struct MainView: View {
  @EnvironmentObject var datamodel: WordleDataModel
  
  var body: some View {
    VStack {
      Text("WORDLE")
        .font(.largeTitle)
        .fontWeight(.heavy)
      if !datamodel.inPlay {
        Button {
          datamodel.newGame()
        } label: {
          Text("New Game")
            .padding()
            .foregroundColor(.white)
          .background(Rectangle().cornerRadius(10).foregroundColor(.blue))}
      } else {
        Spacer()
      }
      ForEach(0..<6) { index in
        GuessRowView(guess: $datamodel.guesses[index])
      }
      KeyboardView()
        .padding(.top, 20.0)
      //        .foregroundColor(.primary)
      Spacer()
    }
    .overlay(alignment: .top) {
      if let alertText = datamodel.alertText {
        AlertView(text: alertText)
      }
    }
  }
}

struct ContentView_Previews: PreviewProvider {
  static var previews: some View {
    MainView()
      .environmentObject(WordleDataModel())
  }
}
