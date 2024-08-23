////
////  NotificationView.swift
////  Breatheee Watch App
////
////  Created by Kevin Fairuz on 16/08/24.
////
//
//import SwiftUI
//struct NotificationView: View {
//    @Environment(\.presentationMode) var presentationMode
//    @State private var ringAnimation: CGFloat = 0
//    @State private var counter = 10
//    var count = 10
//    var body: some View {
//        VStack{
//            Text("Drink some milk!")
//                .font(.subheadline)
//            ZStack{
//                //MARK: - Background Circle
//                Circle()
//                    .stroke(Color.white.opacity(0.1), style: StrokeStyle(lineWidth: 15))
//                //MARK: - Progress Circle
//                Circle()
//                    .trim(from: ringAnimation, to: 1.0)
//                    .stroke(LinearGradient(gradient: Gradient(colors: [Color( colorLiteral(red: 0.2588235438, green: 0.7568627596, blue: 0.9686274529, alpha: 1)), Color( colorLiteral(red: 0.2666666667, green: 0.8431372549, blue: 0.7137254902, alpha: 1))]), startPoint: .topTrailing, endPoint: .bottomLeading),
//                            style: StrokeStyle(lineWidth: 15, lineCap: .round))
//                    .rotationEffect(Angle(degrees: 90))
//                    .rotation3DEffect(Angle(degrees: 180), axis: (x: 1, y: 0, z: 0))
//                    .shadow(color: Color( colorLiteral(red: 0.2666666667, green: 0.8431372549, blue: 0.7137254902, alpha: 1)).opacity(0.3), radius: 3, x: 0, y: 3)
//                    .animation(.easeInOut)
//                //MARK: - Percentage
//                Text("🥛\n\(counter)")
//                    .font(.title3)
//                    .multilineTextAlignment(.center)
//            }.padding()
//                .onAppear{
//                    updateRing()
//                }.frame(minWidth: 100, idealWidth: 110, maxWidth: .infinity, minHeight: 100, idealHeight: 110, maxHeight: .infinity, alignment: .center)
//        }
//    }
//    func updateRing(){
//        if counter == 0 {
//            self.presentationMode.wrappedValue.dismiss()
//            ringAnimation = 10
//            return
//        }else{
//            DispatchQueue.main.asyncAfter(deadline: (.now() + 1)) {
//                ringAnimation += CGFloat(1) / CGFloat(count)
//                counter -= 1
//                updateRing()
//            }
//        }
//    }
//}
//
//#Preview {
//    NotificationView()
//}
