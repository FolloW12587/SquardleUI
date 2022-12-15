//
//  DismissButtonView.swift
//  SquardleUI
//
//  Created by Сергей Дубовой on 15.12.2022.
//

import SwiftUI

struct DismissButtonView: View {
    var dismissAction: () -> ()
    
    var body: some View {
        Button(action: dismissAction) {
            HStack(spacing: 0) {
                Image(systemName: "chevron.left")
                Text("Back")
                Spacer()
            }
        }
    }
}

struct DismissButtonView_Previews: PreviewProvider {
    static var previews: some View {
        DismissButtonView(){}
    }
}
