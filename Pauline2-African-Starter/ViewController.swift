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
        // first print out location of  the current node
        print("**** \(node.name ?? "no name"): at local position: \(node.position)")
        print("**** \(node.name ?? "no name"): at world position: \(node.worldPosition)")

        // print the node's parent name
        print("**** \(node.name ?? "no name") parent: \(node.parent?.name ?? "no parent found")")

        // print out child node info
        var nodeNames: [String] = []
        for node in node.childNodes {
            nodeNames.append(node.name ?? "no name")
        }
        print("**** \(node.name ?? "no name"): has \(node.childNodes.count == 1 ? " \(node.childNodes.count) child" : " \(node.childNodes.count) children"): \(nodeNames)")

        // recursive call to have children print out thier info
        for node in node.childNodes {
            printInfo(for: node)
        }
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

        // always name your scene root node
        scene.rootNode.name = "Bike SCNScene RootNode"
        printInfo(for: scene.rootNode)

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
        if let currentCameraPosition = sceneView.pointOfView?.position {
            print("**** Camera Position: \(currentCameraPosition)")
        } else {
            print("**** Camera Position: unknown")
        }
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
