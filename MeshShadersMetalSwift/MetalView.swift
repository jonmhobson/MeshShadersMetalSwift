import SwiftUI
import MetalKit

struct MetalView: View {
    @State private var metalView = MTKView()
    static private var renderer: Renderer? = nil

    let detail: Int
    let topology: Int
    let speed: Float
    let offset: Float

    private func updateRendererSettings() {
        MetalView.renderer?.lodChoice = detail
        MetalView.renderer?.topologyChoice = topology
        MetalView.renderer?.rotationSpeed = speed
        MetalView.renderer?.offsetZ = offset
    }

    init(detail: Int, topology: Int, speed: Float, offset: Float) {
        self.detail = detail
        self.topology = topology
        self.speed = speed
        self.offset = offset
        updateRendererSettings()
    }

    var body: some View {
        MetalViewRepresentable(metalView: $metalView)
            .onAppear {
                MetalView.renderer = Renderer(metalView: metalView)
                updateRendererSettings()
            }
    }
}

struct MetalViewRepresentable: NSViewRepresentable {
    @Binding var metalView: MTKView

    func makeNSView(context: Context) -> some NSView {
        metalView
    }

    func updateNSView(_ nsView: NSViewType, context: Context) {
        updateMetalView()
    }

    func updateMetalView() {}
}

struct MetalView_Previews: PreviewProvider {
    static var previews: some View {
        VStack {
            MetalView(detail: 2, topology: 2, speed: 1.5, offset: 0.0)
        }
    }
}
