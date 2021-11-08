//
//  ProfileUserView.swift
//  Fasting
//
//  Created by Yu-chen chih on 2021/11/8.
//

import SwiftUI

struct ProfileUserView: View {
    var body: some View {
        HStack {
            Image(systemName: "person.circle.fill")
                .font(.system(size: 60))
                .foregroundColor(.black)
                .padding([.leading, .trailing], 16)
            VStack(alignment: .leading, spacing: 4, content:  {
                Text("User")
                    .font(.title)
                    .bold()
                    .padding([.bottom], 4)
                Text("Setting User Name")
                    .foregroundColor(.gray)
            })
            Spacer()
        }
//        .padding([.leading, .trailing], 15)
        .padding([.top, .bottom], 10)
        .background(Color(#colorLiteral(red: 0.9568627451, green: 0.9607843137, blue: 0.9607843137, alpha: 1)).cornerRadius(8)).padding([.leading, .trailing])
    }
}

struct ProfileUserView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileUserView().previewLayout(.sizeThatFits)
    }
}
