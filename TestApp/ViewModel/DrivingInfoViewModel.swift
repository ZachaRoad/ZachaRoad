//
//  DrivingInfoViewModel.swift
//  TestApp
//
//  Created by 강창현 on 2023/08/30.
//

import Foundation
import SwiftUI
import Firebase
import FirebaseFirestore
import FirebaseFirestoreSwift

class DrivingInfoViewModel: ObservableObject {
    
    @AppStorage("carReg") var carReg: String = ""
    @Published var drivingInfos: [DrivingInfo] = []
    @Published var drivingInfosAll: [DrivingInfo] = []
    @Published var recentRef: String = ""
    
    /*
     let date: String
     let purpose: String
     let totalDistance: Int
     */
    
    func saveStartDrivingInfo(id: String, drivingInfo: DrivingInfo) async {
        let documents = Firestore.firestore().collection("Users").document(carReg).collection("DrivingInfo")
        await documents.document(id)
            .setData(drivingInfo.dictionary) { error in
                if let error = error {
                    print(error.localizedDescription)
                } else {
                    print("Success")
                }
            }
    }
    
    func updateDrivingInfo(_ updatedField:[String:Any]) async {
        let documents = Firestore.firestore().collection("Users").document(carReg).collection("DrivingInfo").document(recentRef)
        await documents.setData(updatedField, merge: true) { error in
            if let error = error {
                print(error.localizedDescription)
            } else {
                print("Success")
            }
        }
    }
    
    func updateDrivingInfoData() {
        let documentRef = Firestore.firestore().collection("Users").document(carReg).collection("DrivingInfo")
        
        documentRef.addSnapshotListener { (snapshot, error) in
            if let error = error {
                print("Error fetching driving info: \(error.localizedDescription)")
                return
            }
            
            // Process the received data from the snapshot
            if let snapshot = snapshot {
                for document in snapshot.documents {
                    // Here, you can access individual document data using document.data()
                    let drivingInfoData = document.data()
                    // Process the driving info data as needed
                    print("Received driving info: \(drivingInfoData)")
                }
            }
        }
    }
    
    func fetchAllDrivingInfos() async {
        let documentRef = Firestore.firestore().collection("Users").document(carReg).collection("DrivingInfo")
        
        documentRef.addSnapshotListener { snapshot, error in
            if let error = error {
                print(error.localizedDescription)
                return
            }
            
            guard let documents = snapshot?.documents else {
                print("스냅샷 Nil")
                return
            }
            
            self.drivingInfos = []
            documents.forEach { content in
                do {
                    var drivingInfo = try Firestore.Decoder().decode(DrivingInfo.self, from: content.data())
                    self.drivingInfosAll.append(drivingInfo)
                    
                } catch {
                    print("저장 실패")
                }
            }
        }
    }
    func fetchDrivingInfos(targetYear: String, targetMonth: String) async {
        let documentRef = Firestore.firestore().collection("Users").document(carReg).collection("DrivingInfo")
        
        documentRef.addSnapshotListener { snapshot, error in
            if let error = error {
                print(error.localizedDescription)
                return
            }
            
            guard let documents = snapshot?.documents else {
                print("스냅샷 Nil")
                return
            }
            
            self.drivingInfos = []
            documents.forEach { content in
                do {
                    var drivingInfo = try Firestore.Decoder().decode(DrivingInfo.self, from: content.data())
                    
                    // 여기서 date를 분리하여 년도와 월을 추출
                    let dateComponents = drivingInfo.date.split(separator: ".")
                    if dateComponents.count >= 2 {
                        let year = String(dateComponents[0])
                        if let monthInt = Int(dateComponents[1]) { // Int로 변환
                            let month = String(monthInt) // 다시 String으로 변환
                            
                            // 년도와 월이 일치하는지 확인
                            if year == targetYear && month == targetMonth {
                                self.drivingInfos.append(drivingInfo)
                            }
                        }
                    }
                    
                } catch {
                    print("저장 실패")
                }
            }
        }
    }
    
}
