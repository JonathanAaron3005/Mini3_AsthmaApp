import SwiftUI
import WatchKit

struct BreathAnimation: View {
    @State private var size = minSize
    @State private var inhaling = false
    @State private var ghostSize = ghostMaxSize
    @State private var ghostBlur: CGFloat = 0
    @State private var ghostOpacity: Double = 0
    @State private var title = "Inhale"
    @State private var hapticTimer: Timer?
    @State private var hapticIsEnabled : Bool = true

    var body: some View {
        ZStack {
            Color.black.ignoresSafeArea()

            VStack(alignment: .center) {
                Text(title)
                    .font(.headline)
                    .foregroundColor(.white)

                ZStack {
                    Petals(size: ghostSize, inhaling: inhaling)
                        .blur(radius: ghostBlur)
                        .opacity(ghostOpacity)

                    Petals(size: size, inhaling: inhaling, isMask: true)

                    Petals(size: size, inhaling: inhaling)
                    Petals(size: size, inhaling: inhaling)
                        .rotationEffect(.degrees(smallAngle))
                        .opacity(inhaling ? 0.8 : 0.6)
                }
                
                .rotationEffect(.degrees(inhaling ? bigAngle : -smallAngle))
                .drawingGroup()
            }
            .padding([.top, .bottom], 15)
            .frame(width: 240, height: 260)
            
        }
        
        .onAppear {
            performAnimation()
        }
        .onDisappear {
            hapticTimer?.invalidate()
            WKInterfaceDevice.current().play(.stop)
            hapticIsEnabled = false
            
        }
    }

    private func performAnimation() {
        guard ( hapticIsEnabled ) else { return }
        title = "Inhale"
        withAnimation(.easeInOut(duration: inhaleTime)) {
            inhaling = true
            size = maxSize
        }
        playHaptics(isInhale: true, count: 4)

        Timer.scheduledTimer(withTimeInterval: inhaleTime + pauseTime, repeats: false) { _ in
            startExhalingAnimation()
        }
    }

    private func startExhalingAnimation() {
        guard ( hapticIsEnabled ) else { return }
        title = "Exhale"
        ghostSize = ghostMaxSize
        ghostBlur = 0
        ghostOpacity = 0.8

        Timer.scheduledTimer(withTimeInterval: exhaleTime * 0.2, repeats: false) { _ in
            withAnimation(.easeOut(duration: exhaleTime * 0.6)) {
                ghostBlur = 30
                ghostOpacity = 0
            }
        }

        withAnimation(.easeInOut(duration: exhaleTime)) {
            inhaling = false
            size = minSize
            ghostSize = ghostMinSize
        }

        playHaptics(isInhale: false, count: 8)

        Timer.scheduledTimer(withTimeInterval: exhaleTime + pauseTime, repeats: false) { _ in
            performAnimation()
        }
    }

    private func playHaptics(isInhale: Bool, count: Int) {
        hapticTimer?.invalidate()
        var vibrationCount = 0

        hapticTimer = Timer.scheduledTimer(withTimeInterval: (isInhale ? inhaleTime : exhaleTime) / Double(count), repeats: true) { timer in
            WKInterfaceDevice.current().play(.directionUp)
            vibrationCount += 1

            if vibrationCount >= count {
                timer.invalidate()
            }
        }
    }
}

#Preview {
    BreathAnimation()
}
