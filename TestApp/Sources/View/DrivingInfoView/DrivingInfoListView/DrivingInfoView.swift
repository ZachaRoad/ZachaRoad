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
    @State var isPurposeSelecting: Bool = false
    @State var fuelCharge: String = ""
    @State var tollCharge: String = ""

    let purposeList = ["출장","출퇴근","개인용무"]
    
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
                            .bold()
                            .foregroundColor(.representColor)
                        Menu {
                            ForEach(purposeList, id: \.self) { string in
                                Button(string) {
                                    purpose = string
                                    isPurposeSelecting = true
                                }
                            }
                        } label: {
                            HStack{
                                if purpose == "" {
                                    Text("미선택")
                                }else{
                                    Text("\(purpose)")
                                }
                                Spacer()
                                Image("DropDownImage")
                                    .rotationEffect(.degrees( isPurposeSelecting ? -180 : 0))
                            }
                            .foregroundColor(.primary)
                        }
                        .onTapGesture {
                            isPurposeSelecting = false
                        }
                    }
                    
                    Divider()
                    HStack {
                        Text("차량 정보")
                            .bold()
                            .foregroundColor(.representColor)
                        Text("\(carName)")
                    }
                    Divider()
                    
                    VStack(alignment: .leading) {
                        HStack{
                            Text("운행정보")
                                .foregroundColor(.lightGray)
                                .bold()
                                .padding(.trailing, 5)
                            Spacer()
                        }
                        
                        
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
                                VStack(alignment: .leading){
                                    Text("출발지")
                                        .font(.subheadline)
                                        .foregroundColor(.lightGray)
                                    Text(drivingInfo.startAddress)
                                        .font(.subheadline)
                                }
                                .padding(.bottom, 17)
                                VStack(alignment: .leading){
                                    Text("목적지")
                                        .font(.subheadline)
                                        .foregroundColor(.lightGray)
                                    Text(drivingInfo.endAddress)
                                        .font(.subheadline)
                                }
                            }
                            VStack{
                                
                            }
                        }
                        .padding(.bottom)
                        HStack {
                            Spacer()
                            Image(systemName: "car.circle.fill")
                            Text("\(drivingInfo.totalDistance)" + "km")
                                .bold()
                                .padding(.trailing, 5)
                                .font(.subheadline)
                            Spacer()
                            Image(systemName: "wonsign.circle.fill")
                            Text(
                                "\(drivingInfo.fuelFee + drivingInfo.tollFee + drivingInfo.depreciation)"
                                + "원"
                            )
                            .bold()
                            .font(.subheadline)
                            Spacer()
                        }
                        .padding(.bottom)
                    }
                    
                    Divider()
                    VStack(alignment: .leading) {
                        HStack {
                            Text("차량 정보")
                                .bold()
                                .foregroundColor(.representColor)
                            Spacer()
                        }
                        HStack{
                            NavigationLink {
                                EditChargeView(drivingInfoViewModel: drivingInfoViewModel, drivingInfo: drivingInfo, type: "통행료", charge: $tollCharge)
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
                                EditChargeView(drivingInfoViewModel: drivingInfoViewModel, drivingInfo: drivingInfo, type: "유류비", charge: $fuelCharge)
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
                    .padding(.vertical)
                    
                }
                .padding(.horizontal)
                Spacer()
                //TODO: 저장버튼
                CustomButton(action: {
                    Task {
                        await drivingInfoViewModel.updateDrivingInfo(drivingInfo, [
                            "purpose" : purpose,
                            "tollFee" : drivingInfo.tollFee,
                            "fuelFee" : drivingInfo.fuelFee])
                    }
                }) {
                    Text("저장하기")
                }
                .padding(.vertical)
            }
            .onAppear{
                fuelCharge = String(drivingInfo.fuelFee)
                tollCharge = String(drivingInfo.tollFee)
            }
            .alert(
                "저장완료",
                isPresented: $drivingInfoViewModel.isSaved
            ) {
                Button {
                    self.presentationMode.wrappedValue.dismiss()
                    
                } label: {
                    Text("확인")
                }
            } message: {
                Text("저장되었습니다")
            }
            
            .padding()
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button {
                        self.presentationMode.wrappedValue.dismiss()
                    } label: {
                        Image("backButton")
                            .resizable()
                            .frame(width: 60, height: 60)
                            .aspectRatio(contentMode: .fit)
                            .offset(y: 5)
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
    }
}

//struct DrivingInfoView_Previews: PreviewProvider {
//    static var previews: some View {
//        DrivingInfoView(drivingInfoViewModel: DrivingInfoViewModel(), purpose: "출장", drivingInfo: DrivingInfo(id: "", date: "2023.08.30.(수)", purpose: "출장", totalDistance: 0, startAddress: "출발", startTime: "15:33", endAddress: "도착", endTime: "13:33", fuelFee: 123, tollFee: 123, depreciation: 123))
//    }
//}
