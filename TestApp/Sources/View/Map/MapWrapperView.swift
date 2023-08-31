//
//  MapWrapperView.swift
//  TestApp
//
//  Created by 추현호 on 2023/08/31.
//

import SwiftUI

struct MapWrapperView: View {
    
    @StateObject var coordinator: Coordinator = Coordinator.shared
    @ObservedObject var mainViewModel: MainViewModel
    @ObservedObject var drivingInfoViewModel: DrivingInfoViewModel
    @ObservedObject var carRegViewModel: CarRegistrationViewModel
    @Binding var tapSearchBar: Bool
    @State private var isStartedNavi: Bool = false
    //선택시 분기처리 해줄 변수
    @State private var destinationSelected: Bool = false
    @AppStorage("carName") var carName: String = ""
    @AppStorage("carReg") var carReg: String = ""
    @State var totalDistance: Double = 0
    @State var fuelFee: Double = 0
    @State var depreciation: Double = 0
    
    var address: String
    var currentAddress: String
    let currentDate: Date = Date()
    var currentTime: String {
        let formatter = DateFormatter()
        formatter.dateFormat = "HH:mm"
        let currentTime = formatter.string(from: currentDate)
        return currentTime
    }
    var drivingDate: String {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy.MM.dd.(E)"
        let drivingDate = formatter.string(from: currentDate)
        return drivingDate
    }
    
    var body: some View {
        VStack {
            if !destinationSelected {
                
                HStack(alignment: .center, spacing: 0) {
                    VStack(spacing: 0){
                        MapSearchBar()
                    }
                }
                .padding(7)
                .font(.subheadline)
                .cornerRadius(20)
                .padding(7)
                .shadow(radius: 10)
                .onTapGesture {
                    tapSearchBar = true
                }
                
            } else {
                HStack{
                    Button {
                        destinationSelected = false
                    } label: {
                        Image("backButton")
                            .resizable()
                            .frame(width: 60, height: 60)
                            .aspectRatio(contentMode: .fit)
                            .offset(y: 5)
                    }
                    Spacer()
                }

            }
            
            Spacer()
            if !destinationSelected {
                ShortcutScrollView(destinationSelected: $destinationSelected)
            } else {
                MapBottomSheet(mainViewModel: mainViewModel, drivingInfoViewModel: drivingInfoViewModel, address: address, currentAddress: currentAddress)
            }
            
        }
        .task {
            await drivingInfoViewModel.getOwnerName(carNum: carReg)
        }
        .onAppear {
            carRegViewModel.getCarInfo(registratedNum: carReg, ownerName: drivingInfoViewModel.ownerName) { carName in
                print(carName)
            }
            totalDistance = haversineDistance(lat1: coordinator.userLocation.0, lon1: coordinator.userLocation.1, lat2: coordinator.destination.0, lon2: coordinator.destination.1)
            fuelFee = (totalDistance/(Double(carRegViewModel.carFuelCo) ?? 10.3)) * totalDistance
            depreciation = ((Double(carRegViewModel.carPrice) ?? 40000000)/200000) * totalDistance
        }
        .alert(
            "주행종료",
            isPresented: $mainViewModel.showAlert
        ) {
            Button {
                let endAddress: String = coordinator.currentAddress[1]
                Task {
                    await drivingInfoViewModel.updateRecentDrivingInfo(
                        ["endAddress":endAddress,
                         "endTime":currentTime,
                         "totalDistance": Int(totalDistance),
                         "fuelFee": Int(fuelFee),
                         "depreciation": Int(depreciation)
                        ])
                    
                }
            } label: {
                Text("확인")
            }
        } message: {
            Text("주행이 완료되었습니다")
        }
    }
    
    func haversineDistance(lat1: Double, lon1: Double, lat2: Double, lon2: Double) -> Double {
        let radius = 6371000.0
        let lat1Rad = lat1 * .pi / 180.0
        let lon1Rad = lon1 * .pi / 180.0
        let lat2Rad = lat2 * .pi / 180.0
        let lon2Rad = lon2 * .pi / 180.0

        let dLat = lat2Rad - lat1Rad
        let dLon = lon2Rad - lon1Rad

        let a = sin(dLat / 2) * sin(dLat / 2) + cos(lat1Rad) * cos(lat2Rad) * sin(dLon / 2) * sin(dLon / 2)
        let c = 2 * atan2(sqrt(a), sqrt(1 - a))

        let distance = radius * c
        return distance
    }
}

struct MapWrapperView_Previews: PreviewProvider {
    static var previews: some View {
        ZStack {
            Color(.systemGray)
            MapWrapperView(mainViewModel: MainViewModel(), drivingInfoViewModel: DrivingInfoViewModel(), carRegViewModel: CarRegistrationViewModel(), tapSearchBar: Binding.constant(false), address: "Test", currentAddress: "Test")
        }
        
    }
}
