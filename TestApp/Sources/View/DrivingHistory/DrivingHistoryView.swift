//
//  DrivingHistoryView.swift
//  TestApp
//
//  Created by 추현호 on 2023/08/26.
//

import SwiftUI

struct DrivingHistoryView: View {
    @ObservedObject var drivingInfoViewModel: DrivingInfoViewModel
    var body: some View {
        VStack {
            Spacer()
            Text("일지를 선택하세요")
                .font(.title)
                .bold()
                .padding(.bottom)
            Divider()
                .padding(.horizontal)
            ScrollView{
                LazyVStack{
                    ForEach(drivingInfoViewModel.allDrivingInfos) { info in
                        SendEmailView(drivingInfo: info)
                            .padding(.vertical)
                    }
                }
            }
            .padding(.top)
        }
        .task {
            await drivingInfoViewModel.updateDrivingInfoData()
        }
    }
}

struct DrivingHistoryView_Previews: PreviewProvider {
    static var previews: some View {
        DrivingHistoryView(drivingInfoViewModel: DrivingInfoViewModel())
    }
}
