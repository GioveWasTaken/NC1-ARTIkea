//
//  ARViewContainer.swift
//  ARTIkea
//
//  Created by Giovanni Bifulco on 16/11/23.
//


import SwiftUI
import ARKit

struct ARViewContainer: UIViewRepresentable {
    class Coordinator: NSObject, ARSCNViewDelegate {
        var parent: ARViewContainer

        init(parent: ARViewContainer) {
            self.parent = parent
        }

        // Implement ARSCNViewDelegate methods as needed
    }

    func makeCoordinator() -> Coordinator {
        return Coordinator(parent: self)
    }

    func makeUIView(context: Context) -> ARSCNView {
        let arView = ARSCNView()
        arView.delegate = context.coordinator

        // Create a scene
        let scene = SCNScene()
        arView.scene = scene

        // Add AR content here, e.g., a 3D model
        let tvNode = SCNNode()
        if let tvScene = SCNScene(named: "tv_retro.usdz") {
            for child in tvScene.rootNode.childNodes {
                tvNode.addChildNode(child)
            }
        }

        // Set the scale of the tvNode
        let scale: Float = 0.1 // Adjust this value as needed
        tvNode.scale = SCNVector3(scale, scale, scale)

        scene.rootNode.addChildNode(tvNode)

        // Configure AR session options
        let configuration = ARWorldTrackingConfiguration()
        configuration.planeDetection = .horizontal
        arView.session.run(configuration)

        return arView
    }

    func updateUIView(_ uiView: ARSCNView, context: Context) {
        // Update the view as needed
    }
}

struct ARQuickLookARView: View {
    var body: some View {
        ARViewContainer()
            .edgesIgnoringSafeArea(.all)
    }
}
