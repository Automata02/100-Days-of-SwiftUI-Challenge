//
//  DetailsView.swift
//  NewFaces
//
//  Created by roberts.kursitis on 08/12/2022.
//

import SwiftUI

struct DetailsView: View {
    var image: Data?
    var name: String
    var company: String
    
    var body: some View {
        VStack {
            if let image {
                Image(uiImage: UIImage(data: image)!)
                    .resizable()
                    .scaledToFill()
                    .frame(width: 200, height: 200)
                    .clipShape(Circle())
                    .padding(.horizontal)
            } else {
                Image("hank")
                    .resizable()
                    .frame(width: 200, height: 200)
                    .clipShape(Circle())
                    .padding(0)
            }
            Text(name)
            Text(company)
        }
    }
}

struct DetailsView_Previews: PreviewProvider {
    static var previews: some View {
        DetailsView(name: "Hank Hill", company: "Strickland Propane")
    }
}
