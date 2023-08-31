//
//  ContentView.swift
//  TestApp
//
//  Created by 추현호 on 2023/08/12.
//

import SwiftUI


struct ContentView: View {
    @ObservedObject var viewModel: AppViewModel
    @ObservedObject var mainVM: MainViewModel
    @ObservedObject var drivingInfoViewModel: DrivingInfoViewModel
    @StateObject var carRegVM = CarRegistrationViewModel()
    @AppStorage("carName") var carName: String = ""
    let currentYear = Calendar.current.component(.year, from: Date())
    let currentMonth = Calendar.current.component(.month, from: Date())
    
    var body: some View {
        if carName == ""{
            CarRegistrationView(carRegVM: carRegVM, mainViewModel: mainVM)
        } else {
            VStack {
                TabView(selection: self.$viewModel.selectedTab) {
                    MainView(carRegViewModel: carRegVM, viewModel: mainVM, drivingInfoViewModel: drivingInfoViewModel)
                        .tabItem {
                            VStack{
                                Image(systemName: "car")
                                Text("내비")
                            }
                            .foregroundColor(.representColor)
                        }
                        .tag(Tab.one)
                    DrivingInfoListView(drivingInfoViewModel: drivingInfoViewModel, month: currentMonth, year: currentYear)
                        .tabItem {
                            VStack{
                                Image(systemName: "square.text.square.fill")
                                Text("운행내역")
                            }
                            .foregroundColor(.representColor)
                        }
                        .tag(Tab.two)
                    DrivingHistoryView(drivingInfoViewModel: drivingInfoViewModel)
                        .tabItem {
                            VStack{
                                Image(systemName: "doc.on.clipboard")
                                Text("운행일지")
                            }
                            .foregroundColor(.representColor)
                        }
                        .tag(Tab.three)
                }
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView(viewModel: AppViewModel(), mainVM: MainViewModel(), drivingInfoViewModel: DrivingInfoViewModel())
    }
}
