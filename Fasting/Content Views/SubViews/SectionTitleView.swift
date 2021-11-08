//
//  SectionTitleView.swift
//  Fasting
//
//  Created by lohsts on 2021/11/7.
//

import SwiftUI

struct SectionTitleView: View {
    var title: String
    var subtitle: String?
    
    var body: some View {
        Text(title).font(.title2).fontWeight(.medium)
        if let subtitle = subtitle {
            Text(subtitle).font(.system(size: 15)).opacity(0.75)
        }
        
    }
}

struct SectionTitleView_Previews: PreviewProvider {
    static var previews: some View {
        SectionTitleView(title: "title")
    }
}
