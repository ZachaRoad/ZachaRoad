//
//  DrivingInfoView.swift
//  TestApp
//
//  Created by 추현호 on 2023/08/19.
//

import SwiftUI

struct DrivingInfoView: View {
    @ObservedObject var drivingInfoViewModel: DrivingInfoViewModel
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    @AppStorage("carName") var carName: String = ""
    @State var purpose: String
    var drivingInfo: DrivingInfo
    var body: some View {
        NavigationStack {
            VStack{
                VStack(alignment: .leading) {
                    HStack {
                        Text("\(drivingInfo.date)")
                            .font(.title2)
                            .bold()
                        Spacer()
                    }
                    .padding(.vertical)
                    
                    HStack {
                        Text("운행 목적")
                            .foregroundColor(.representColor)
                        DropDownMenu(menus: ["출장", "출퇴근", "개인용무"], selection: $purpose)
                    }
                    
                    Divider()
                    HStack {
                        Text("차량 정보")
                            .foregroundColor(.representColor)
                        Text("\(carName)")
                    }
                    Divider()
                    HStack(alignment: .top) {
                        Text("운행정보")
                            .foregroundColor(.representColor)
                            .padding(.trailing, 5)
                        
                        VStack(alignment: .leading) {
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
                                VStack{
                                    
                                }
                            }
                            .padding(.bottom, 5)
                            
                            // 지도 들어갈 공간
                            ZStack(alignment: .bottom) {
                                
                            }
                            .frame(width: 100, height: 100)
                            .background(Color.gray)
                            .cornerRadius(15)
                        }
                    }
                    Divider()
                    HStack(alignment: .top) {
                        Text("메모")
                            .foregroundColor(.representColor)
                            .padding(.trailing, 30)
                        HStack{
                            NavigationLink {
                                EditChargeView(drivingInfoViewModel: drivingInfoViewModel, drivingInfo: drivingInfo, type: "통행료")
                            } label: {
                                VStack(alignment: .leading){
                                    Image(systemName: "mappin.and.ellipse")
                                        .resizable()
                                        .frame(width: 20, height: 23)
                                        .foregroundColor(.black)
                                    HStack {
                                        Text("통행료")
                                        Image(systemName: "square.and.pencil")
                                    }
                                    .foregroundColor(.gray)
                                    Text("\(drivingInfo.tollFee)")
                                        .bold()
                                        .font(.title3)
                                        .foregroundColor(.black)
                                }
                            }
                            Spacer()
                            NavigationLink {
                                EditChargeView(drivingInfoViewModel: drivingInfoViewModel, drivingInfo: drivingInfo, type: "유류비")
//                                EditChargeView(drivingInfoViewModel: drivingInfoViewModel, drivingInfo: drivingInfo, type: "유류비")
                            } label: {
                                VStack(alignment: .leading){
                                    Image(systemName: "fuelpump")
                                        .resizable()
                                        .frame(width: 20, height: 23)
                                        .foregroundColor(.black)
                                    HStack {
                                        Text("유류비")
                                        Image(systemName: "square.and.pencil")
                                    }
                                    .foregroundColor(.gray)
                                    Text("\(drivingInfo.fuelFee)")
                                        .bold()
                                        .font(.title3)
                                        .foregroundColor(.black)
                                }
                            }
                            Spacer()
                            
                            VStack(alignment: .leading){
                                Image(systemName: "arrow.counterclockwise.circle.fill")
                                    .resizable()
                                    .frame(width: 23, height: 23)
                                    .foregroundColor(.black)
                                HStack {
                                    Text("감가상각")
                                    Image(systemName: "square.and.pencil")
                                }
                                .foregroundColor(.gray)
                                Text("\(drivingInfo.depreciation)")
                                    .bold()
                                    .font(.title3)
                                    .foregroundColor(.black)
                            }
                            .padding(.trailing, 3)
                        }
                    }
                    
                }
                .padding(.horizontal)
                Spacer()
                //TODO: 저장버튼
                CustomButton(action: {
                    Task {
                        await drivingInfoViewModel.updateDrivingInfo(["purpose": purpose,
                                                                      "tollFee":drivingInfo.tollFee,
                                                                      "fuelFee":drivingInfo.fuelFee,
                                                                      "depriciate":drivingInfo.depreciation])
                    }
                    
                }) {
                    Text("저장하기")
                }
                .padding(.vertical)
            }
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button {
                        self.presentationMode.wrappedValue.dismiss()
                    } label: {
                        ZStack {
                            Circle()
                                .stroke(lineWidth: 1)
                                .frame(width: 25, height: 25)
                            
                            Image(systemName: "chevron.left")
                                .frame(width: 25, height: 25)
                        }
                        .foregroundColor(.gray)
                        
                    }
                }
                ToolbarItem(placement: .navigationBarLeading) {
                    Text("운행정보")
                        .font(.title2)
                        .bold()
                }
            }
        .navigationBarBackButtonHidden()
        }
        .onAppear {
            drivingInfoViewModel.updateDrivingInfoData()
        }
    }
}

//struct DrivingInfoView_Previews: PreviewProvider {
//    static var previews: some View {
//        DrivingInfoView(drivingInfoViewModel: DrivingInfoViewModel(), purpose: "출장", drivingInfo: DrivingInfo(id: "", date: "2023.08.30.(수)", purpose: "출장", totalDistance: 0, startAddress: "출발", startTime: "15:33", endAddress: "도착", endTime: "13:33", fuelFee: 123, tollFee: 123, depreciation: 123))
//    }
//}
