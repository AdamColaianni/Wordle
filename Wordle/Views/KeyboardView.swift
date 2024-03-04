//
//  Keyboard.swift
//  Wordle
//
//  Created by 90310013 on 2/17/24.
//

import SwiftUI

struct KeyboardView: View {
  @EnvironmentObject var datamodel: WordleDataModel
  let keyboardLayoutArray: [[String]] = [["q", "w", "e", "r", "t", "y", "u", "i", "o", "p"],["a", "s", "d", "f", "g", "h", "j", "k", "l"],["z", "x", "c", "v", "b", "n", "m"]]
  
  var body: some View {
    VStack(spacing: 6) {
      ForEach(0..<3) { row in
        HStack(spacing: 2) {
          ForEach(0..<keyboardLayoutArray[row].count, id: \.self) { col in
            if row == 2 && col == 0 {
              Button {
                datamodel.submit()
              } label: {
                Image(systemName: "return")
              }
              .padding(.trailing, 2.0)
              .font(.system(size: 23))
              .foregroundColor(.primary)
            }
            KeyView(letter: keyboardLayoutArray[row][col])
            if row == 2 && col == 6 {
              Button(action: {
                datamodel.pressedBackspace()
              }) {
                Image(systemName: "delete.backward.fill")
                  .resizable()
                  .foregroundColor(.primary)
                  .padding(.leading, 5.0)
                  .frame(width: 42.0, height: 30.0)
              }
            }
          }
        }
      }
    }
  }
}

struct KeyboardView_Previews: PreviewProvider {
  static var previews: some View {
    KeyboardView()
      .environmentObject(WordleDataModel())
  }
}
