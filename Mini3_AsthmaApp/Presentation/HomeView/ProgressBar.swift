import SwiftUI
import UIKit

//class StripesView: UIView {
//    
//    override func draw(_ rect: CGRect) {
//        
//        let T: CGFloat = 10     // desired thickness of lines
//        let G: CGFloat = 2     // desired gap between lines
//        let W = rect.size.width
//        let H = rect.size.height
//        
//        guard let c = UIGraphicsGetCurrentContext() else { return }
//        c.setStrokeColor(UIColor.red.cgColor)
//        c.setLineWidth(T)
//        
//        var p = -(W > H ? W : H) - T
//        while p <= W {
//            
//            c.move( to: CGPoint(x: p-T, y: -T) )
//            c.addLine( to: CGPoint(x: p+T+H, y: T+H) )
//            c.strokePath()
//            p += G + T + T
//        }
//    }
//}

extension UIColor {
   convenience init(red: Int, green: Int, blue: Int) {
       assert(red >= 0 && red <= 255, "Invalid red component")
       assert(green >= 0 && green <= 255, "Invalid green component")
       assert(blue >= 0 && blue <= 255, "Invalid blue component")

       self.init(red: CGFloat(red) / 255.0, green: CGFloat(green) / 255.0, blue: CGFloat(blue) / 255.0, alpha: 1.0)
   }

   convenience init(rgb: Int) {
       self.init(
           red: (rgb >> 16) & 0xFF,
           green: (rgb >> 8) & 0xFF,
           blue: rgb & 0xFF
       )
   }
}

class StripesView: UIView {
    
    var strokeColor: CGColor = UIColor.red.cgColor
    var shift: CGFloat = 0
    var displayLink: CADisplayLink?

    // Initialize the view and start the animation
    override init(frame: CGRect) {
        super.init(frame: frame)
        startAnimation()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        startAnimation()
    }

    override func draw(_ rect: CGRect) {
        let T: CGFloat = 15     // desired thickness of lines
        let G: CGFloat = 2      // desired gap between lines
        let W = rect.size.width
        let H = rect.size.height
        
        guard let c = UIGraphicsGetCurrentContext() else { return }
        c.setStrokeColor(strokeColor)
        c.setLineWidth(T)
        
        var p = -(W > H ? W : H) - T + shift
        while p <= W {
            c.move(to: CGPoint(x: p - T, y: -T))
            c.addLine(to: CGPoint(x: p + T + H, y: T + H))
            c.strokePath()
            p += G + T + T
        }
    }

    // Function to start the animation
    func startAnimation() {
        displayLink = CADisplayLink(target: self, selector: #selector(updateAnimation))
        displayLink?.add(to: .main, forMode: .default)
    }
    
    // Function called every frame to update the shift
    @objc func updateAnimation() {
        shift -= 0.5  // Decrease to move the lines to the left
        if shift <= -((2 + 15) * 2)+1.2 {  // Reset the shift after the full cycle
            shift = 0
        }
        setNeedsDisplay()  // Redraw the view with updated shift
    }
    
    // Function to stop the animation
    func stopAnimation() {
        displayLink?.invalidate()
        displayLink = nil
    }
    
    deinit {
        stopAnimation()
    }
}

struct StripeProgressBar: UIViewRepresentable {
    @Binding var progress: Float
    var progressColor: UIColor
    var trackColor: UIColor
    var barHeight: CGFloat
    var stripeColor: UIColor
    var strokeColor: UIColor
    
    func makeUIView(context: Context) -> UIView {
        // Create a container view
        let containerView = UIView()

        // Create the progress view
        let progressView = UIProgressView(progressViewStyle: .default)
        progressView.progressTintColor = progressColor
        progressView.trackTintColor = trackColor
        
        // Add the progress view to the container
        containerView.addSubview(progressView)
        
        // Disable autoresizing mask for Auto Layout
        progressView.translatesAutoresizingMaskIntoConstraints = false
        
        progressView.layer.cornerRadius = barHeight/2
        progressView.clipsToBounds = true
        progressView.layer.sublayers![1].cornerRadius = barHeight/2
        progressView.subviews[1].clipsToBounds = true
        
        progressView.layer.borderColor = strokeColor.cgColor
        progressView.layer.borderWidth = 1.5
        
        
        let stripesView = StripesView(frame: CGRect(x: 0, y: 0, width: 500, height: barHeight))
        stripesView.backgroundColor = progressColor
        stripesView.strokeColor = stripeColor.cgColor
        progressView.subviews[1].addSubview(stripesView)
        
        // Set the layout constraints for the progress view
        NSLayoutConstraint.activate([
            // Pin progress view to the edges of the container view
            progressView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor),
            progressView.trailingAnchor.constraint(equalTo: containerView.trailingAnchor),
            progressView.centerYAnchor.constraint(equalTo: containerView.centerYAnchor),
            progressView.heightAnchor.constraint(equalToConstant: barHeight) // Set custom height
        ])
        
        return containerView
    }

    func updateUIView(_ uiView: UIView, context: Context) {
        // Access the progress view and update its progress value
        if let progressView = uiView.subviews.first as? UIProgressView {
            progressView.progress = progress
//            progressView.subviews[1].subviews[0].frame = CGRect(x: 0, y: 0, width: progressView.subviews[1].frame.width, height: barHeight)
        }
    }
}

struct PBTestView: View {
    @State private var progress: Float = 0.3 // Initial progress
    
    var body: some View {
        VStack {
            // SwiftUI Text for displaying current progress
            Text("Progress: \(Int(progress * 100))%")
                .font(.headline)
            
            // Custom ProgressBar using UIProgressView wrapped in SwiftUI
            StripeProgressBar(progress: $progress, progressColor: UIColor.green, trackColor: UIColor.systemGray6, barHeight: 50.0, stripeColor: UIColor.freshGreen, strokeColor: UIColor(rgb: 0x30C530))
                .frame(height: 40)
                .padding()
            
            // Slider to control progress value
            Slider(value: $progress, in: 0...1)
                .padding()
            
            Button("Increase Progress") {
                // Increase progress value by 0.1
                if progress < 1.0 {
                    progress += 0.1
                }
            }
            .padding()
        }
        .padding()
    }
}

#Preview {
    PBTestView()
}
