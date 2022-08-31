//
//  HomeViewModel.swift
//  VeterinaryClinic
//
//  Created by Sachin Daingade on 27/08/22.
//

import Foundation
import Combine

public class HomeViewModel: ObservableObject {
    
    private var cancallables = Set<AnyCancellable>()
    @Published public private(set) var config: VCConfiguration?
    @Published public private(set) var pets = [Pet]()
    @Published public private(set) var loadingState: LoadingStates = LoadingStates.idle

    
    public enum Input {
        case getConfiguration
        case getPets
        case getMockConfiguration
    }
    
    @Published public var input: Input?
    
    init() {
        $input.compactMap{$0}.sink{ [unowned self] action in
            switch action {
            case .getConfiguration:
                self.getConfigurationSettings()
            case.getPets:
                self.getAllPets()
            case .getMockConfiguration:
                self.getAllPets()
            }
        } .store(in: &cancallables)
    }
    
    private func getConfigurationSettings() {
        loadingState = .loading
        ConfigNetwork.getConfigData {[weak self] result in
            switch result {
            case .success(let conf):
                DispatchQueue.main.async {
                    self?.config = conf
                    self?.loadingState = .idle
                }
            case .failure(let error):
                self?.loadingState = .failed(error.description)
                debugPrint("\(error.localizedDescription)")
            }
        }
    }
    
    private func getAllPets() {
        loadingState = .loading

        PetsNetwork.getPets {[weak self] result in
            switch result {
            case .success(let pets):
                DispatchQueue.main.async {
                    self?.pets = pets.pets
                    self?.loadingState = .idle
                }
            case .failure(let error):
                self?.loadingState = .failed(error.description)
                debugPrint("\(error.localizedDescription)")
            }
        }
    }
    
    private func getMockConfigurationSettings() {
        loadingState = .loading
        ConfigNetwork.getConfigData {[weak self] result in
            switch result {
            case .success(let conf):
                DispatchQueue.main.async {
                    self?.config = conf
                    self?.loadingState = .idle
                }
            case .failure(let error):
                self?.loadingState = .failed(error.description)
                debugPrint("\(error.localizedDescription)")
            }
        }
    }
    
    //MARK: check validation for Office Time
    func validateWithInOfficeTime() -> String {
        //"workHours": "M-F 9:00 - 18:00"
        let now = Date()
        let settings = config?.settings.workHours
        guard let hRange = settings?.components(separatedBy: " ") else { return "Work hours has ended. Please contact us again on the next work day" }
        
        let components = Calendar.current.dateComponents([.weekday], from: now)
        let weekday = components.weekday ?? 0
        
        switch weekday {
        case 2...6:
            debugPrint("Working day")
        case 1:
            debugPrint("Not Working Day")
            return  "Work hours has ended. Please contact us again on the next work day"
        case 7:
            debugPrint("Not Working Day")
            return "Work hours has ended. Please contact us again on the next work day"
        default:
            break
        }
        
        let startTimeArray = hRange[1].components(separatedBy: ":")
        let sSettingHour = Int(startTimeArray.first!)
        let sMinute =  Int(startTimeArray.last!)
        
        let calendar = Calendar.current
        let min_today = calendar.date(
            bySettingHour: sSettingHour!,
            minute: sMinute!,
            second: 0,
            of: now)!
        
        let maxTimeArray =  hRange.last!.components(separatedBy: ":")
        let mSettingHour = Int(maxTimeArray.first!)
        let mMinute =  Int(maxTimeArray.last!)
        
        let max_today = calendar.date(
            bySettingHour: mSettingHour!,
            minute: mMinute!,
            second: 0,
            of: now)!
        
        if now >= min_today && now <= max_today  {
            debugPrint("The time is between \(startTimeArray) and \(maxTimeArray)")
            return "Thank you for getting in touch with us. We’ll get back to you as soon as possible"
        } else {
            debugPrint("Not within the time  \(startTimeArray) and \(maxTimeArray)")
            return "Work hours has ended. Please contact us again on the next work day"
        }
    }
    
    deinit {
        cancallables.forEach{$0.cancel()}
    }
}
