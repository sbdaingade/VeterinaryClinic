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

    public enum Input {
        case getConfiguration
        case getPets
    }
    
    @Published public var input: Input?
    
    init() {
        $input.compactMap{$0}.sink{ [unowned self] action in
            switch action {
            case .getConfiguration:
                self.getConfigurationSettings()
             case.getPets:
                self.getAllPets()
            }
        } .store(in: &cancallables)
    }
    
    private func getConfigurationSettings() {
        TestConfigNetwork.getConfigData { result in
            switch result {
            case .success(let conf):
                DispatchQueue.main.async {[unowned self] in
                    self.config = conf
                }
            case .failure(let error):
                debugPrint("\(error.localizedDescription)")
            }
        }
    }
    
    private func getAllPets() {
        TestPetsNetwork.getPets { result in
            switch result {
            case .success(let pets):
                DispatchQueue.main.async {[unowned self] in
                    self.pets = pets.pets
                }
            case .failure(let error):
                debugPrint("\(error.localizedDescription)")
            }
        }
    }
    
    deinit {
        cancallables.forEach{$0.cancel()}
    }
}
