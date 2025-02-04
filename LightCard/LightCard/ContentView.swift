import SwiftUI

struct ContentView: View {
    
    @State private var progress : CGFloat = 0.05
    @State private var dragp = CGPoint(x:330/2,y:460/2)

    var body: some View {
        let rotationAngleX = Angle(degrees: Double(dragp.x - 200) / 10)
        let rotationAngleY = Angle(degrees: Double(dragp.y - 200) / 50)
        let cardsize = CGSize(width:330, height:460)
        ZStack {
            ZStack{
                Image("sample")
                    .resizable()
                    .scaledToFill()
            }
            .frame(width:cardsize.width,height: cardsize.height)
            .layerEffect(ShaderLibrary.splash(.boundingRect, .float2(dragp), .float(progress)), maxSampleOffset:.zero)
            .gesture(
                DragGesture()
                    .onChanged { value in
                        dragp = value.location
                    }
                    .onEnded { value in
                        withAnimation(.spring(.bouncy)) {
                            dragp =  CGPoint(x:cardsize.width/2,y:cardsize.height)
                        }
                    }
                
            )
            .rotation3DEffect(rotationAngleX, axis: (x: 0, y: 1, z: 0))
            .rotation3DEffect(rotationAngleY, axis: (x: 1, y: 0, z: 0))
            
            
            VStack{
                Spacer()
                HStack{
                    Text("x : \(dragp.x, specifier: "%.0f")")
                        .foregroundStyle(.black)
                        .font(.system(size:14, design: .monospaced))
                    
                    Text("y : \(dragp.y, specifier: "%.0f")")
                        .foregroundStyle(.black)
                        .font(.system(size:14, design: .monospaced))
                    
                }
                
                HStack{
                    Text("r : \(progress, specifier: "%.1f")")
                        .foregroundStyle(.black)
                        .font(.system(size:14, design: .monospaced))
                    Slider(value:$progress, in:0...1, step:0.01)
                        .tint(.black)
                }
                
                
            }
            .padding()
        }
    }
}

#Preview {
    ContentView()
}
