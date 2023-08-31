//
//  MapBottomSheet.swift
//  TestApp
//
//  Created by 추현호 on 2023/08/31.
//

import SwiftUI

struct MapBottomSheet: View {
    
    @ObservedObject var mainViewModel: MainViewModel
    @ObservedObject var drivingInfoViewModel: DrivingInfoViewModel
    @StateObject var coordinator: Coordinator = Coordinator.shared
    //@StateObject var mainViewModel: MainViewModel
    @State private var isStartedNavi: Bool = false
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
        ZStack {
            Color(UIColor(.paneColor))
            VStack(spacing: 0) {
                HStack {
                    Image("StartMapMarker")
                        .padding(.trailing, -10)
                    Text("현위치:")
                        .bold()
                    Text("\(currentAddress)")
                    Spacer()
                }
                
                HStack {
                    Image("EndMapMarker")
                        .padding(.trailing, -10)
                    Text("목적지:")
                        .bold()
                    Text("\(address)")
                    Spacer()
                }
                
                HStack {
                    CustomButton {
                        mainViewModel.active = true
                        mainViewModel.startAddress = coordinator.currentAddress[1]
                        Task {
                            let id = UUID().uuidString
                            await drivingInfoViewModel.saveStartDrivingInfo(id: id, drivingInfo: DrivingInfo(id: id, date: drivingDate, purpose: "", totalDistance: 0, startAddress: coordinator.currentAddress[1], startTime: currentTime, endAddress: "", endTime: "", fuelFee: 0, tollFee: 0, depreciation: 0))
                            drivingInfoViewModel.recentRef = id
                            
                            print("시작시점 경로:\(drivingInfoViewModel.recentRef)")
                        }
                        isStartedNavi.toggle()
                    } content: {
                        Text("안내시작")
                    }
                    .padding(.bottom, 50)
                }
                
                Spacer()
            }
            .font(.title3)
            .padding(10)
            .alert(
                "주행종료",
                isPresented: $mainViewModel.showAlert
            ) {
                Button {
                    let endAddress: String = coordinator.currentAddress[1]
                    Task {
                        print("alert 태스크 진입")
                        print("종료시점 경로:\(drivingInfoViewModel.recentRef)")
                        await drivingInfoViewModel.updateDrivingInfo(["endAddress":endAddress,"endTime":currentTime])
                        
                    }
                } label: {
                    Text("확인")
                }
            } message: {
                Text("주행이 완료되었습니다")
            }
            
        }
        .cornerRadius(10)
        .frame(width: UIScreen.main.bounds.width, height: 150, alignment: .leading)
        
    }
}

struct MapBottomSheet_Previews: PreviewProvider {
    static var previews: some View {
        ZStack {
            Color(.systemGray)
            MapBottomSheet(mainViewModel: MainViewModel(), drivingInfoViewModel: DrivingInfoViewModel(), address: "Test", currentAddress: "Test")
        }
        
    }
}
