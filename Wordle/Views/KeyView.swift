//
//  KeyView.swift
//  Wordle
//
//  Created by 90310013 on 2/27/24.
//

import SwiftUI

struct KeyView: View {
  @EnvironmentObject var datamodel: WordleDataModel
  @State var letter: String
  
  var body: some View {
    Button {
      datamodel.pressedKey(letter: letter)
    } label: {
      Image(systemName: "\(letter).square")
        .resizable()
        .foregroundColor(.black)
        .background(Rectangle()
          .foregroundColor(datamodel.getColorOf(letter: letter))
          .cornerRadius(10))
        .frame(width: 37.0, height: 43.0)
    }
  }
}

struct KeyView_Previews: PreviewProvider {
  static var previews: some View {
    KeyView(letter: "a")
      .environmentObject(WordleDataModel())
  }
}
