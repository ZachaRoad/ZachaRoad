//
//  MailView.swift
//  TestApp
//
//  Created by 추현호 on 2023/08/31.
//

import SwiftUI
import MessageUI


struct MailView: UIViewControllerRepresentable {
    var drivingInfo: DrivingInfo
    @Binding var result: Bool
    
    func makeUIViewController(context: UIViewControllerRepresentableContext<MailView>) -> MFMailComposeViewController {
        let mail = MFMailComposeViewController()
        mail.mailComposeDelegate = context.coordinator
        mail.setSubject("\(drivingInfo.date) \(drivingInfo.date) 운행기록")
        mail.setToRecipients(["example@example.com"])
        
        
        var base64Image = ""
        if let image = UIImage(named: "logoForEmail"), let imageData = image.jpegData(compressionQuality: 1.0) {
            base64Image = imageData.base64EncodedString()
        }
        
        let totalCost = drivingInfo.fuelFee + drivingInfo.tollFee + drivingInfo.depreciation
        let emailBody = """
        <html>
        <head>
            <style>
                body {
                    font-family: Arial, sans-serif;
                }
                table {
                    width: 100%;
                    border-collapse: collapse;
                    margin-top: 20px;
                }
                th, td {
                    border: 1px solid #ccc;
                    padding: 10px;
                    text-align: left;
                }
                th {
                    background-color: #f2f2f2;
                }
                td {
                    background-color: #e6f7ff;
                }
                .total-cost {
                    background-color: #ffe6e6;
                }
                .cost-details {
                    padding-left: 20px;
                    background-color: #fff3e6;
                }
                .footer {
                    margin-top: 20px;
                }
            </style>
        </head>
        <body>
        
        <h2>\(drivingInfo.date) \(drivingInfo.date) 운행기록</h2>
        
        <table>
            <tr>
                <th>운행 목적</th>
                <td>\(drivingInfo.purpose)</td>
            </tr>
            <tr>
                <th>총 운행거리</th>
                <td>\(drivingInfo.totalDistance)</td>
            </tr>
            <tr>
                <th>출발지</th>
                <td>\(drivingInfo.startAddress)</td>
            </tr>
            <tr>
                <th>목적지</th>
                <td>\(drivingInfo.endAddress)</td>
            </tr>
            <tr class='total-cost'>
                <th>총 비용</th>
                <td>₩\(totalCost)</td>
            </tr>
            <tr class='cost-details'>
                <th>유류비</th>
                <td>\(drivingInfo.fuelFee)</td>
            </tr>
            <tr class='cost-details'>
                <th>톨게이트비</th>
                <td>\(drivingInfo.tollFee)</td>
            </tr>
            <tr class='cost-details'>
                <th>차량별 감가상각</th>
                <td>\(drivingInfo.depreciation)</td>
            </tr>
        </table>
        <br>
        <br>
        <br>
        <br>

        
        <div class="footer">
            <img src="data:image/jpeg;base64,\(base64Image)" alt="Your Image" />
            <p>똑똑한 회사원은 자차로드를 쓴다</p>
        </div>
        
        </body>
        </html>
        """
        mail.setMessageBody(emailBody, isHTML: true)
        
        return mail
    }
    func updateUIViewController(_ uiViewController: MFMailComposeViewController, context: UIViewControllerRepresentableContext<MailView>) {
    }
    
    func makeCoordinator() -> Coordinator {
        return Coordinator(self)
    }
    
    
    
    class Coordinator: NSObject, MFMailComposeViewControllerDelegate {
        var parent: MailView
        
        init(_ parent: MailView) {
            self.parent = parent
        }
        
        func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?) {
            parent.result = false
            controller.dismiss(animated: true)
        }
    }
}

func resizeImage(image: UIImage, targetSize: CGSize) -> UIImage {
    let size = image.size
    let widthRatio  = targetSize.width  / size.width
    let heightRatio = targetSize.height / size.height
    
    let newSize = CGSize(width: size.width * widthRatio, height: size.height * heightRatio)
    let rect = CGRect(x: 0, y: 0, width: newSize.width, height: newSize.height)
    
    UIGraphicsBeginImageContextWithOptions(newSize, false, 1.0)
    image.draw(in: rect)
    let newImage = UIGraphicsGetImageFromCurrentImageContext()
    UIGraphicsEndImageContext()
    
    return newImage ?? image
}
