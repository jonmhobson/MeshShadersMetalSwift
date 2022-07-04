import SwiftUI

struct ContentView: View {
    @State var detail: Int = 0
    @State var topology: Topology = .triangles
    @State var speed: Speed = .slow
    @State var translation: Float = 0.0

    enum Speed {
        case off
        case slow
        case fast

        var radiansPerSecond: Float {
            switch self {
            case .off: return 0.0
            case .slow: return 0.1
            case .fast: return 0.25
            }
        }
    }

    enum Topology: Int {
        case points = 0
        case lines = 1
        case triangles = 2
    }

    var body: some View {
        ZStack(alignment: .top) {
            MetalView(detail: detail,
                      topology: topology.rawValue,
                      speed: speed.radiansPerSecond,
                      offset: translation)

            HStack {
                VStack {
                    Picker("Detail", selection: $detail) {
                        Text("Low").tag(2)
                        Text("Medium").tag(1)
                        Text("High").tag(0)
                    }
                    .pickerStyle(.segmented)

                    Picker("Topology", selection: $topology) {
                        Text("Points").tag(Topology.points)
                        Text("Lines").tag(Topology.lines)
                        Text("Triangles").tag(Topology.triangles)
                    }
                    .pickerStyle(.segmented)
                }
                .frame(maxWidth: 300)
                .padding()

                Spacer()

                VStack {
                    Picker("Rotation", selection: $speed) {
                        Text("Off").tag(Speed.off)
                        Text("Slow").tag(Speed.slow)
                        Text("Normal").tag(Speed.fast)
                    }
                    .pickerStyle(.segmented)

                    Slider(value: $translation) { Text("Translation") }
                }
                .frame(maxWidth: 300)
                .padding()
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
