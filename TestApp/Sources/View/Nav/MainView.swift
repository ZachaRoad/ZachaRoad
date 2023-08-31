//
//  TestNavigationView.swift
//  TestApp
//
//  Created by 강창현 on 2023/08/29.
//

import SwiftUI

struct MainView: View {
    
    @StateObject private var coordinator: Coordinator = Coordinator.shared
    @ObservedObject var carRegViewModel: CarRegistrationViewModel
    @ObservedObject var viewModel: MainViewModel
    @ObservedObject var drivingInfoViewModel: DrivingInfoViewModel
    
    var body: some View {
        if viewModel.active {
            NavView(startDest: coordinator.currentAddress[1],
                    startX: coordinator.userLocation.1,
                    startY: coordinator.userLocation.0,
                    startAddress: coordinator.currentAddress[1],
                    endAddress: coordinator.address,
                    endDest: coordinator.address,
                    endX: coordinator.destination.1,
                    endY: coordinator.destination.0)
            .toolbar(.hidden, for: .tabBar)
            .edgesIgnoringSafeArea(.all)
        } else {
            MapView(mainViewModel: viewModel, drivingInfoViewModel: drivingInfoViewModel, carRegViewModel: carRegViewModel)
        }
    }
}

struct TestNavigationView_Previews: PreviewProvider {
    static var previews: some View {
        MainView(carRegViewModel: CarRegistrationViewModel(), viewModel: MainViewModel(), drivingInfoViewModel: DrivingInfoViewModel())
    }
}
