//
//  ProfileTabView.swift
//  Fasting
//
//  Created by Yu-chen chih on 2021/11/1.
//

import SwiftUI

struct ProfileTabView: View {
    @ObservedObject var manager: FastingDataManager
    
    var body: some View {
        ScrollView {
            Divider().padding()
            
        }
    }
}

struct ProfileTabView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileTabView(manager: FastingDataManager())
    }
}
