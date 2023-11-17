//
//  ARViewContainer.swift
//  ARTIkea
//
//  Created by Giovanni Bifulco on 16/11/23.
//

// ARViewContainer.swift
import SwiftUI
import ARKit

struct ARViewContainer: UIViewControllerRepresentable {
    class Coordinator: NSObject, ARSCNViewDelegate {
        // Implement ARKit-related functions here if needed
    }

    func makeCoordinator() -> Coordinator {
        return Coordinator()
    }

    func makeUIViewController(context: Context) -> UIViewController {
        let viewController = UIViewController()
        let arView = ARSCNView()

        // Check for camera permissions
        switch AVCaptureDevice.authorizationStatus(for: .video) {
        case .authorized:
            // User has already granted access to the camera
            break
        case .notDetermined:
            // Request camera access if not determined
            AVCaptureDevice.requestAccess(for: .video) { granted in
                if granted {
                    // Camera access granted
                } else {
                    // Handle denial of camera access
                }
            }
        default:
            // Handle denial of camera access
            break
        }

        arView.delegate = context.coordinator

        // Create a new AR scene
        let scene = SCNScene()
        arView.scene = scene

        // Enable lighting for more realistic rendering
        arView.autoenablesDefaultLighting = true

        // Load a 3D model (replace "modelFileName" with the name of your .usdz model file)
        if let model = Bundle.main.url(forResource: "tv_retro", withExtension: "usdz") {
            let modelNode = SCNReferenceNode(url: model)
            modelNode?.load()

            // Place the model at the center of the scene
            modelNode?.position = SCNVector3(0, 0, -2) // Adjust the position as needed

            // Add the model to the scene
            scene.rootNode.addChildNode(modelNode!)
        }

        viewController.view = arView

        return viewController
    }

    func updateUIViewController(_ uiViewController: UIViewController, context: Context) {
        // Update the view controller if needed
    }
}

struct ARViewDemo: View {
    var body: some View {
        NavigationView {
            VStack {
                Text("ARKit Example")
                    .font(.largeTitle)
                    .padding()

                ARViewContainer()
                    .edgesIgnoringSafeArea(.all)
            }
        }
    }
}

struct ARViewDemo_Previews: PreviewProvider {
    static var previews: some View {
        ARViewDemo()
    }
}
