//
//  ViewController.swift
//  Pauline2-African-Starter
//
//  Created by Larry Nickerson on 2/2/19.
//  Copyright © 2019 Lawrence Nickerson. All rights reserved.
//

import ARKit
import SceneKit
import UIKit

class ViewController: UIViewController, ARSCNViewDelegate, ARSessionDelegate {
    @IBOutlet var sceneView: ARSCNView!

  fileprivate func printInfo(for node: SCNNode) {
    print("**** \(node.name ?? "no name"): at local position: \(node.position)")
    print("**** \(node.name ?? "no name"): at world position: \(node.worldPosition)")
    
    print("**** \(node.name ?? "no name") parent: \(String(describing: node.parent?.name))")
    
    var nodeNames: [String] = []
    for node in node.childNodes {
      nodeNames.append(node.name ?? "no name")
    }
    print("**** \(node.name ?? "no name"): has \(node.childNodes.count == 1 ? " \(node.childNodes.count) child" : " \(node.childNodes.count) children"): \(nodeNames)")

  }
  
  override func viewDidLoad() {
        super.viewDidLoad()

        // Set the view's delegate
        sceneView.delegate = self
        sceneView.session.delegate = self

        // Show statistics such as fps and timing information
        sceneView.showsStatistics = true

        // Create a new scene
        let scene = SCNScene(named: "art.scnassets/Bike.dae")!

        printInfo(for: scene.rootNode)

    
        if let bodyNode = scene.rootNode.childNode(withName: "Body", recursively: true) {
          
          printInfo(for: bodyNode)
          
          if let bikeNode = bodyNode.childNode(withName: "Bike", recursively: true) {
            printInfo(for: bikeNode)
            for node in bikeNode.childNodes {
              printInfo(for: node)
            }
          }
//            let scaleFactor = Float(0.001)
//            // bikeNode.scale = SCNVector3(double3(scaleFactor))
//            bikeNode.transform = SCNMatrix4(float4x4(rows: [
//                float4(scaleFactor, 0, 0, 0),
//                float4(0, scaleFactor, 0, 0),
//                float4(0, 0, scaleFactor, 0),
//                float4(2, -1.5, -5, 1.0),
//            ]))

//            let newRootNode = SCNNode()
//            newRootNode.name = "myNewRoot"
//            newRootNode.worldPosition = SCNVector3(0, 0, -10)
//
//            scene.rootNode.addChildNode(newRootNode)
//
//            newRootNode.addChildNode(bikeNode)
        }

        // Set the scene to the view
        sceneView.scene = scene
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        // Create a session configuration
        let configuration = ARWorldTrackingConfiguration()

        // Run the view's session
        sceneView.session.run(configuration)

        // where is the camera at start
        let currentCameraPosition = sceneView.pointOfView?.position
        print("**** Camera Position: \(String(describing: currentCameraPosition))")
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)

        // Pause the view's session
        sceneView.session.pause()
    }

    // MARK: - ARSCNViewDelegate

    // Override to create and configure nodes for anchors added to the view's session.

    func renderer(_ renderer: SCNSceneRenderer, didApplyAnimationsAtTime time: TimeInterval) {
        // print("++++ Animated at time: \(time)")
    }

    func renderer(_ renderer: SCNSceneRenderer, nodeFor anchor: ARAnchor) -> SCNNode? {
        print("**** Added to the session, anchor: \(anchor.identifier)")

        let node = SCNNode()
        return node
    }

    func renderer(_ renderer: SCNSceneRenderer, didAdd node: SCNNode, for anchor: ARAnchor) {
        print("**** Renderer Added: \(node) for Anchor: \(anchor)")
    }

    func renderer(_ renderer: SCNSceneRenderer, didUpdate node: SCNNode, for anchor: ARAnchor) {
        print("**** Renderer Updated \(String(describing: node)) for Ancor: \(anchor.identifier) named:  \(String(describing: anchor.name))")
    }

    func session(_ session: ARSession, didFailWithError error: Error) {
        // Present an error message to the user
    }

    func sessionWasInterrupted(_ session: ARSession) {
        // Inform the user that the session has been interrupted, for example, by presenting an overlay
    }

    func sessionInterruptionEnded(_ session: ARSession) {
        // Reset tracking and/or remove existing anchors if consistent tracking is required
    }

    //  //MARK: - ARSessionDelegate
    //  func session(_ session: ARSession, didUpdate frame: ARFrame) {
//    // Do something with the new transform
//    let translatonRow = frame.camera.transform.columns.3
//    let currentPosition = SCNVector3(translatonRow.x, translatonRow.y, translatonRow.z)
//    print("**** current position: \(currentPosition)")
    //  }
}
