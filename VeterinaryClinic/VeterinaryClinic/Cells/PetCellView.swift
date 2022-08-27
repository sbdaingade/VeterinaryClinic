//
//  PetCellView.swift
//  VeterinaryClinic
//
//  Created by Sachin Daingade on 27/08/22.
//

import SwiftUI

struct PetCellView: View {
    
    let pet: Pet
    
    var body: some View {
        ZStack {
            HStack(alignment: .center) {
                Image(systemName: "photo.artframe")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width:80, height:80)
                
                Text(pet.title)
                    .multilineTextAlignment(.leading)
                    .lineLimit(2)
            }
        }
    }
}

struct PetCellView_Previews: PreviewProvider {
    static var previews: some View {
        PetCellView(pet: Pet(imageURL: "", title: "Test", contentURL: "", dateAdded: ""))
    }
}
