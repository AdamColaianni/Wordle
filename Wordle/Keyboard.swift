//
//  Keyboard.swift
//  Wordle
//
//  Created by 90310013 on 2/17/24.
//

import SwiftUI

class KeyboardViewModel: ObservableObject {
  @Published var greenedKeysList: [String]
  @Published var yellowedKeysList: [String]
  @Published var grayedKeysList: [String]
  @Published var typedWord: [String] = []
  
  let keyboardLayoutArray: [[String]] = [["q", "w", "e", "r", "t", "y", "u", "i", "o", "p"],["a", "s", "d", "f", "g", "h", "j", "k", "l"],["z", "x", "c", "v", "b", "n", "m"]]
  
  init(greenKeys: [String], yellowKeys: [String], grayKeys: [String]) {
    self.greenedKeysList = greenKeys
    self.yellowedKeysList = yellowKeys
    self.grayedKeysList = grayKeys
  }
  
  func pressedKey(letter: String) {
    print("You have pressed \(letter)")
    if keyboardLayoutArray[0].contains(letter) {
      greenedKeysList.append(letter)
    } else if keyboardLayoutArray[1].contains(letter) {
      yellowedKeysList.append(letter)
    } else {
      grayedKeysList.append(letter)
    }
    if typedWord.count < 5 {
      typedWord.append(letter)
    }
    print(typedWord)
  }
  
  func pressedBackspace() {
    print("BACKSPACE")
    greenedKeysList.removeAll()
    yellowedKeysList.removeAll()
    grayedKeysList.removeAll()
    if typedWord.count > 0 {
      typedWord.remove(at: typedWord.count - 1)
    }
    print(typedWord)
  }
  
  func getColorOf(letter: String) -> Color {
    if greenedKeysList.contains(letter) {
      return Color(.green)
    } else if yellowedKeysList.contains(letter) {
      return Color(.yellow)
    } else if grayedKeysList.contains(letter) {
      return Color(.gray)
    } else {
      return Color(.white)
    }
  }
  
  func keyViewButton(row: Int, col: Int) -> some View {
    return Button(action: {
      self.pressedKey(letter: self.keyboardLayoutArray[row][col])
    }) {
      Image(systemName: "\(self.keyboardLayoutArray[row][col]).square")
        .resizable()
        .foregroundColor(.black)
        .background(Rectangle()
          .foregroundColor(self.getColorOf(letter: self.keyboardLayoutArray[row][col]))
          .cornerRadius(10))
        .frame(width: 37.0, height: 43.0)
    }
  }
  
  func keyboardViewLayout() -> some View {
    VStack(spacing: 6) {
      ForEach(0..<3) { row in
        HStack(spacing: 2) {
          ForEach(0..<self.keyboardLayoutArray[row].count, id: \.self) { col in
            self.keyViewButton(row: row, col: col)
            if row == 2 && col == 6 {
              Button(action: {
                self.pressedBackspace()
              }) {
                Image(systemName: "delete.backward.fill")
                  .resizable()
                  .foregroundColor(.black)
                  .padding(.leading, 10.0)
                  .frame(width: 47.0, height: 30.0)
              }
            }
          }
        }
      }
    }
    .padding(50)
    .background(Rectangle()
      .foregroundColor(Color(red: 211.0/255.0, green: 215.0/255.0, blue: 220.0/255.0)))
    
  }
}

struct KeyboardView: View {
  @ObservedObject var viewModel: KeyboardViewModel

  init(viewModel: KeyboardViewModel) {
    self.viewModel = viewModel
  }

  var body: some View {
    viewModel.keyboardViewLayout()
  }
}

extension KeyboardView {
  static func `default`() -> KeyboardView {
    let viewModel = KeyboardViewModel(greenKeys: [], yellowKeys: [], grayKeys: [])
    return KeyboardView(viewModel: viewModel)
  }
}

struct KeyboardView_Previews: PreviewProvider {
  static var previews: some View {
    KeyboardView.default()
  }
}
