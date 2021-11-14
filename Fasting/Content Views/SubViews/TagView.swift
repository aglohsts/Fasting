//
//  TagView.swift
//  Fasting
//
//  Created by lohsts on 2021/11/8.
//

import SwiftUI

struct TagView: View {
    var text: String
    var textColor: Color = .gray
    var backgroundColor: Color = .white
    var body: some View {
        Text(text)
            .foregroundColor(textColor)
            .fontWeight(.bold)
            .font(.system(size: 14))
            .padding([.leading, .trailing], 10)
            .padding([.top, .bottom], 6)
            .background(backgroundColor)
            .cornerRadius(14)
            .clipped()
    }
}

struct TagView_Previews: PreviewProvider {
    static var previews: some View {
        TagView(text: "123123123").previewLayout(.sizeThatFits)
    }
}
