//
//  ContentView.swift
//  VeterinaryClinic
//
//  Created by Sachin Daingade on 27/08/22.
//

import SwiftUI

struct HomeView: View {
    
    @StateObject var homeViewModel = HomeViewModel()
    var body: some View {
        VStack (alignment: .center) {
            sectionHeaderView(view: homeViewModel.config)
            
            List(homeViewModel.pets) { petObject in
                NavigationLink(destination: PetDetailView(pet: petObject)) {
                    PetCellView(pet: petObject)
                }
            }
            .padding(EdgeInsets(top: 0, leading: 12, bottom: 0, trailing: 12))
            .navigationTitle("Home")
            .onAppear {
                homeViewModel.input = .getConfiguration
                homeViewModel.input = .getPets
            }
        }
    }
    @ViewBuilder private func sectionHeaderView(view: VCConfiguration?) -> some View {
        if let settings = view?.settings  {
            VStack(alignment: .center, spacing: 10) {
                HStack (alignment: .center, spacing: 10){
                    if settings.isChatEnabled {
                        
                        Button(action: {
                            // TODO: ...
                        }) {
                            HStack {
                                Spacer()
                                Text("Chat")
                                    .foregroundColor(.black)
                                Spacer()
                            }
                        }
                        .frame(maxWidth: .infinity, maxHeight: 50)
                        .background(Color.blue)
                        .cornerRadius(10)
                    }
                    
                    if settings.isCallEnabled {
                        
                        Button(action: {
                            // TODO: ...
                        }) {
                            HStack {
                                Spacer()
                                Text("Call")
                                    .foregroundColor(.black)
                                Spacer()
                            }
                        }
                        .frame(maxWidth: .infinity, maxHeight: 50)
                        .background(Color.green)
                        .cornerRadius(10)
                    }
                }
                
                Text("Office Hours: \(settings.workHours)")
                    .font(.title3)
                
            }
            .padding(EdgeInsets(top: 0, leading: 12, bottom: 0, trailing: 12))
        }else {
            EmptyView()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
