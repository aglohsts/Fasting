//
//  FormLabelView.swift
//  Fasting
//
//  Created by Yu-chen chih on 2021/10/17.
//

import SwiftUI

struct FormLabelView: View {
    var titleText: String
    var iconSystemName: String = "scribble.variable"
    var backgroundColor: Color = .blue
    var body: some View {
        Label(
            title: {
                Text(titleText)
            },
            icon: {
                Image(systemName: iconSystemName)
                    .padding(4)
                    .background(backgroundColor)
                    .cornerRadius(7)
                    .foregroundColor(.white)
            }
        )
    }
}

struct FormLabelView_Previews: PreviewProvider {
    static var previews: some View {
        FormLabelView(titleText: "title")
            .previewLayout(.sizeThatFits)
    }
}
