//
//  ARViewContainer.swift
//  ARTIkea
//
//  Created by Giovanni Bifulco on 16/11/23.
//

// i had to ask help to Felix, kudos to him!
import SwiftUI
import ARKit

struct ARViewContainer: UIViewRepresentable {
    class Coordinator: NSObject, ARSCNViewDelegate {
        var parent: ARViewContainer

        init(parent: ARViewContainer) {
            self.parent = parent
        }

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

        // select your AR thingy
        let tvNode = SCNNode()
        if let tvScene = SCNScene(named: "tv_retro.usdz") {
            for child in tvScene.rootNode.childNodes {
                tvNode.addChildNode(child)
                
                // Add an ambient light
                let ambientLightNode = SCNNode()
                ambientLightNode.light = SCNLight()
                ambientLightNode.light?.type = .ambient
                ambientLightNode.light?.intensity = 1000 // Adjust intensity as needed
                scene.rootNode.addChildNode(ambientLightNode)

            
            }
        }
        
        

        // Set the scale of the tvN
        let scale: Float = 2
        // Adjust this value as needed
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
