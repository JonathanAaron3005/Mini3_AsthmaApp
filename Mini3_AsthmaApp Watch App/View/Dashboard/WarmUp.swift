import SwiftUI

struct WarmUpTimerView: View {
    @Binding var timerActive: Bool // Bind to control the timer state
    @Binding var elapsedTime: TimeInterval // Bind for the elapsed time
    let router: Router
    
    var body: some View {
        VStack {
            Text("WarmUp Timer")
                .font(Font.custom("PallyVariable-Bold_Regular", size: 32))
            
            HStack {
                Image(systemName: "timer")
                    .foregroundColor(Color(hex: "CFF747"))
                    .font(.system(size: 25))
                
                Text(formatTime(elapsedTime))
                    .font(.custom("CruyffSans-Bold", size: 32))
                    .frame(maxWidth: .infinity, alignment: .topLeading)
                    .foregroundColor(Color(hex: "CFF747"))
            }
            .padding()
            HStack {
                Image(systemName: "heart.fill")
                    .foregroundColor(Color.red)
                    .font(.system(size: 25))
                Text("89 bpm")
                    .font(.custom("Cruyff Sans", size: 32))
                    .foregroundColor(Color.red)
            }
            .padding()
            .frame(maxWidth: .infinity, alignment: .topLeading)
        }
        .padding([.top, .bottom], 30)
        .padding(.horizontal, 15)
        .background(Color(hex: "#18293C"))
        .frame(height: 240)
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading)
    }
    
    // Function to format the elapsed time into minutes and seconds
    func formatTime(_ time: TimeInterval) -> String {
        let minutes = Int(time) / 60
        let seconds = Int(time) % 60
        return String(format: "%02d:%02d", minutes, seconds)
    }
}

#Preview {
    @State var timerActive = true
    @State var elapsedTime: TimeInterval = 94
    return WarmUpTimerView(timerActive: $timerActive, elapsedTime: $elapsedTime, router: Router())
}
