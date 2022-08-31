//
//  VeterinaryClinicApp.swift
//  VeterinaryClinic
//
//  Created by Sachin Daingade on 27/08/22.
//

import SwiftUI

@main
struct VeterinaryClinicApp: App {

    var body: some Scene {
        WindowGroup {
            NavigationView {
                HomeView()
            }
            .onAppear {
                InternetMonitor.shared.startMonitoring()
            }
        }
    }
}
