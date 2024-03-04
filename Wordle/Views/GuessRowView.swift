//
//  GuessRow.swift
//  Wordle
//
//  Created by 90310013 on 2/18/24.
//

import SwiftUI

struct GuessRowView: View {
  @Binding var guess: String
  @State var squish: Bool = false
  @State var fill: Bool = false
  @State var colors: [Color] = Array(repeating: .black, count: 5)

  func animate(colors: [Color]) {
    withAnimation(.easeInOut(duration: 0.25)) {
      self.squish.toggle()
    } completion: {
      self.colors = colors
      self.fill.toggle()
      withAnimation(.easeInOut(duration: 0.25)) {
        self.squish.toggle()
      }
    }
  }
  
  func reset() {
    animate(colors: Array(repeating: .black, count: 5))
  }

  var body: some View {
    VStack {
      HStack(spacing: 10) {
        ForEach(0..<5) { index in
          Image(systemName: index < guess.count ? String(Array(guess)[index]) + ".square" + (self.fill ? ".fill" : "") : "square")
            .resizable()
            .frame(width: 60.0, height: 60.0)
            .foregroundColor(self.colors[index])
            .scaleEffect(x: 1, y: self.squish ? 0.0 : 1.0)
        }
      }
    }
    .onChange(of: guess) {something, _ in
      animate(colors: [.gray, .green, .green, .green, .green])
    }
  }
}

struct testGuessRowView_Previews: PreviewProvider {
  static var previews: some View {
    GuessRowView(guess: .constant(""))
//      .environmentObject(WordleDataModel())
  }
}
