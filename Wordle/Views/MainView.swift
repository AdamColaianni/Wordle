//
//  ContentView.swift
//  Wordle
//
//  Created by 90310013 on 2/17/24.
//

import SwiftUI

struct ContentView: View {
  @EnvironmentObject var datamodel: WordleDataModel
  
  var body: some View {
    VStack {
      //      testGuessRowView()
      ForEach(0..<6) { index in
        GuessRowView(guess: $datamodel.guesses[index])
      }
      KeyboardView()
    }
  }
}

extension Text {
  func headerStyle() -> some View {
    self
      .font(.title)
      .foregroundColor(.blue)
  }
}

struct SubmitButtonStyle: ButtonStyle {
  //  .buttonStyle(SubmitButtonStyle())
  func makeBody(configuration: Configuration) -> some View {
    configuration.label
      .padding()
      .foregroundColor(.white)
      .background(Rectangle()
        .foregroundColor(Color.blue)
        .cornerRadius(5))
  }
}

struct ContentView_Previews: PreviewProvider {
  static var previews: some View {
    ContentView()
      .environmentObject(WordleDataModel())
  }
}
