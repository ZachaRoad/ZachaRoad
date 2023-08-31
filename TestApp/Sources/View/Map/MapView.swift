//
//  MapView.swift
//  TestApp
//
//  Created by 추현호 on 2023/08/12.
//

import SwiftUI

struct MapView: View {
    @ObservedObject var mainViewModel: MainViewModel
    @ObservedObject var drivingInfoViewModel: DrivingInfoViewModel
    @StateObject var coordinator: Coordinator = Coordinator.shared
    @State private var tapSearchBar: Bool = false
    var body: some View {
        ZStack {
            if tapSearchBar {
                MapSearchView(tapSearchBar: $tapSearchBar)
                        .toolbar(.hidden, for: .tabBar)
                        .ignoresSafeArea(.all, edges: .bottom)
                        .zIndex(2)
            } else {
                ZStack {
                    ZStack {
                        VStack(alignment: .leading) {
                            VStack(alignment: .leading) {
                                MapWrapperView(mainViewModel: mainViewModel, drivingInfoViewModel: drivingInfoViewModel, tapSearchBar: $tapSearchBar, address: coordinator.address, currentAddress: coordinator.isLocationDataLoaded ? coordinator.currentAddress[1] : coordinator.currentAddress[0])
                            }
                        }
                    }
                    .zIndex(1)
                    // FIXME: - 하단 탭바 이슈(가려짐)
                    //                    .padding(.bottom, UIApplication.shared.windows.first?.safeAreaInsets.bottom)
                    
                    // 도착 이미지 마커
                    Image("MapMarker")
                        .zIndex(1)
                }
                .zIndex(1)
            }
            
            KakaoMapWrapper()
                .zIndex(0)
                .ignoresSafeArea(.all, edges: .top)
        }
        .onAppear {
            coordinator.checkIfLocationServicesIsEnabled()
        }
    }
}

struct MapView_Previews: PreviewProvider {
    static var previews: some View {
        MapView(mainViewModel: MainViewModel(), drivingInfoViewModel: DrivingInfoViewModel())
    }
}
