//
//  ARViewContainer.swift
//  ARTIkea
//
//  Created by Giovanni Bifulco on 16/11/23.
//


import SwiftUI
import ARKit

struct ARViewContainer: UIViewControllerRepresentable {
    class Coordinator: NSObject, ARSCNViewDelegate {
    }

    func makeCoordinator() -> Coordinator {
        return Coordinator()
    }

    func makeUIViewController(context: Context) -> UIViewController {
        let viewController = UIViewController()
        let arView = ARSCNView()

        //CAMERA
        switch AVCaptureDevice.authorizationStatus(for: .video) {
        case .authorized:
            break
        case .notDetermined:
            AVCaptureDevice.requestAccess(for: .video) { granted in
                if granted {
                } else {
                
                }
            }
        default:
            break
        }

        arView.delegate = context.coordinator

        let scene = SCNScene()
        arView.scene = scene

        arView.autoenablesDefaultLighting = true

        if let model = Bundle.main.url(forResource: "tv_retro", withExtension: "usdz") {
            let modelNode = SCNReferenceNode(url: model)
            modelNode?.load()

         
            modelNode?.position = SCNVector3(0, 0, -2)
            scene.rootNode.addChildNode(modelNode!)
        }

        viewController.view = arView

        return viewController
    }

    func updateUIViewController(_ uiViewController: UIViewController, context: Context) {
    }
}

struct ARViewDemo: View {
    var body: some View {
        NavigationView {
            VStack {
                Text("")
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
