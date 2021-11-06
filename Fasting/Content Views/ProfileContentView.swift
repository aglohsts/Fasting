//
//  ProfileContentView.swift
//  Fasting
//
//  Created by Yu-chen chih on 2021/11/1.
//

import SwiftUI

struct ProfileContentView: View {
    
    @ObservedObject var manager: FastingDataManager
    
    var body: some View {
        ProfileTabView(manager: manager)
    }
}

struct ProfileContentView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileContentView(manager: FastingDataManager())
    }
}
