//
//  TagView.swift
//  Fasting
//
//  Created by Yu-chen chih on 2021/11/8.
//

import SwiftUI

struct TagView: View {
    var text: String
    var body: some View {
        Text(text)
            .foregroundColor(Color.gray)
            .fontWeight(.bold)
            .font(.system(size: 14))
            .padding([.leading, .trailing], 10)
            .padding([.top, .bottom], 6)
            .background(Color.white)
            .cornerRadius(14)
            .clipped()
    }
}

struct TagView_Previews: PreviewProvider {
    static var previews: some View {
        TagView(text: "123123123").previewLayout(.sizeThatFits)
    }
}
