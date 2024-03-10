//
//  AlertView.swift
//  Wordle
//
//  Created by 90310013 on 3/3/24.
//

import SwiftUI

struct AlertView: View {
  let text: String
  var body: some View {
    Text(text)
      .foregroundColor(.white)
      .padding()
      .background(RoundedRectangle(cornerRadius: 10).fill(.letterbox))
  }
}

struct AlertView_Previews: PreviewProvider {
  static var previews: some View {
    AlertView(text: "Not in word list.")
  }
}
