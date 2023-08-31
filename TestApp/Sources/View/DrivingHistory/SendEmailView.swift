//
//  SendEmailView.swift
//  TestApp
//
//  Created by 추현호 on 2023/08/31.
//

import SwiftUI
import MessageUI

struct SendEmailView: View {
    @State private var isShowingMailView = false
    @State private var isShowingAlert = false
    let drivingInfo: DrivingInfo
    
    var body: some View {
        VStack {
            Button {
                if MFMailComposeViewController.canSendMail() {
                    self.isShowingMailView.toggle()
                } else {
                    self.isShowingAlert.toggle()
                }
            } label: {
                HStack{
                    Text("\(drivingInfo.date) 운행일지")
                        .foregroundColor(.black)
                        .font(.title3)
                    Spacer()
                    Image(systemName: "paperplane")
                        .bold()
                        .foregroundColor(.representColor)
                    
                }
                .padding(.horizontal, 20)
            }
            .sheet(isPresented: $isShowingMailView) {
                MailView(drivingInfo: drivingInfo, result: self.$isShowingMailView)
            }
            .alert(isPresented: $isShowingAlert) {
                Alert(title: Text("메일 전송 실패"), message: Text("시뮬레이터에선 메일을 보낼 수 없습니다"), dismissButton: .default(Text("확인")))
            }
        }
        
    }
}

struct SendEmailView_Previews: PreviewProvider {
    static var previews: some View {
        SendEmailView(drivingInfo: DrivingInfo(id: "", date: "", purpose: "", totalDistance: 0, startAddress: "", startTime: "", endAddress: "", endTime: "", fuelFee: 0, tollFee: 0, depreciation: 0))
    }
}

