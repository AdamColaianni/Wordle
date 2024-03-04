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
      ForEach(0..<6) { index in
        GuessRowView(guess: $datamodel.guesses[index])
      }
      KeyboardView()
        .padding(.top, 20.0)
    }
    .overlay(alignment: .top) {
      if let alertText = datamodel.alertText {
        AlertView(text: alertText)
          .offset(y: -50)
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
