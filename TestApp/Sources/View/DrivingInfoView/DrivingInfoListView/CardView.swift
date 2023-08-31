//
//  CardView.swift
//  TestApp
//
//  Created by 추현호 on 2023/08/19.
//

import SwiftUI

struct CardView: View {
    
    @ObservedObject var drivingInfoViewModel: DrivingInfoViewModel
    let drivingInfo: DrivingInfo
    
    var body: some View {
            ZStack(alignment: .leading) {
                Rectangle()
                    .cornerRadius(16)
                    .foregroundColor(.paneColor)
                VStack(alignment: .leading) {
                    HStack {
                        Text("\(drivingInfo.date)")
                            .font(.title2)
                            .bold()
                        Spacer()
                        Text("운행목적")
                            .foregroundColor(.lightGray)
                        Text(drivingInfo.purpose.isEmpty ? "미설정" : "\(drivingInfo.purpose)")
                            .foregroundColor(.representColor)
                    }
                    .padding(20)
                    
                    HStack(alignment: .top) {
                        VStack {
                            Text(drivingInfo.startTime)
                                .font(.subheadline)
                                .padding(.bottom, 35)
                            Text(drivingInfo.endTime)
                                .font(.subheadline)
                        }
                        VStack {
                            Image("DepartureDestination")
                        }
                        VStack(alignment: .leading) {
                            Text(drivingInfo.startAddress)
                                .font(.subheadline)
                                .padding(.bottom, 35)
                            Text(drivingInfo.endAddress)
                                .font(.subheadline)
                        }
                    }
                    .padding(.bottom, 7)
                    .padding(.horizontal, 20)
                    
                    HStack(alignment: .center) {
                        HStack {
                            Image(systemName: "car.circle.fill")
                            Text("\(drivingInfo.totalDistance)" + "km")
                                .padding(.trailing, 5)
                                .font(.subheadline)
                            Image(systemName: "wonsign.circle.fill")
                            Text(
                                 "\(drivingInfo.fuelFee + drivingInfo.tollFee + drivingInfo.depreciation)"
                                 + "원"
                            )
                            .font(.subheadline)
                        }
                        .padding()
                        .background {
                            Rectangle()
                                .foregroundColor(.white)
                                .frame(height: 38)
                                .cornerRadius(30)
                        }
                        .padding(.leading)
                        Spacer()
                        
                        ZStack {
                            Circle()
                                .frame(width: 38, height: 38)
                                .foregroundColor(.representColor)
                            Image(systemName: "chevron.right")
                                .foregroundColor(.white)
                        }
                        .padding()

                    }
                    .padding(.bottom, 7)
                }
            }
            .padding(.horizontal)
    }
}

struct CardView_Previews: PreviewProvider {
    static var previews: some View {
        CardView(drivingInfoViewModel: DrivingInfoViewModel(), drivingInfo: DrivingInfo(id: "", date: "2023.08.30.(수)", purpose: "출장", totalDistance: 0, startAddress: "출발", startTime: "15:33", endAddress: "도착", endTime: "13:33", fuelFee: 123, tollFee: 123, depreciation: 123))
    }
}
