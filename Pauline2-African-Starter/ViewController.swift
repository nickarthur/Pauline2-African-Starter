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
  
  var time = Timer()

    @IBOutlet var sceneView: ARSCNView!
  
  
   func loadSceneNode(withName name: String, from sourceScene: SCNScene) -> SCNNode? {
    if let loadedNode = sourceScene.rootNode.childNode(withName: name, recursively: true) {
      return loadedNode
    }
    return nil
  }
  
  @objc func timer() {
    let node = sceneView.scene.rootNode.childNode(withName: "BikeSceneRoot", recursively: true)
    if let node = node {
      node.isPaused = !node.isPaused
    }
  }
  
  override func viewDidLoad() {
        super.viewDidLoad()

        // Set the view's delegate
        sceneView.delegate = self
        sceneView.session.delegate = self

        // Show statistics such as fps and timing information
        sceneView.showsStatistics = true

        var currentScene = SCNScene()

        // Create a new scene
    
    guard let bikeScene = SCNScene(named: "art.scnassets/PERSONAL-YOUNG-TRAINER-STARTER-KIT.dae") else {
      fatalError("unable to load scene file")
    }
        currentScene = bikeScene
    
        currentScene.rootNode.printInfo()
    
   if let resultNode = currentScene.rootNode.childNode(withName: "Body", recursively: true) {
      let parentNode = resultNode.parent
    parentNode?.worldPosition = SCNVector3(0, -2, -3)
    
      print("found: \(resultNode.name ?? "no name" )")
    }
 
    if let resultNode = currentScene.rootNode.childNode(withName: "Bike", recursively: true) {
      if let parentNode = resultNode.parent {
        parentNode.worldPosition = SCNVector3(0, -2, -3)
      }
      print("found: \(resultNode.name ?? "no name" )")
    }
    
//        // always name your scene root node
//        bikeScene.rootNode.name = "Bike SCNScene RootNode"
//        // if we cannot load then crash we cannot operate witout a bike
//        let bikeSceneRootNode = loadSceneNode(withName: "BikeSceneRoot", from: bikeScene)!
//        bikeSceneRootNode.worldPosition = SCNVector3(0, -100, -400)
//        bikeSceneRootNode.isPaused = true
//        currentScene.rootNode.addChildNode(bikeSceneRootNode)
//
//        // turn on bike pedals animation after a delay
//        time = Timer.scheduledTimer(timeInterval: 7, target: self, selector: #selector(timer), userInfo: nil, repeats: true)
//
//    if let yogaPantsScene = SCNScene(named: "art.scnassets/Yoga-Pants5-unity.dae") {
//      if let yogaPantsRootNode = loadSceneNode(withName: "YogaPantsRoot", from: yogaPantsScene) {
//        currentScene.rootNode.addChildNode(yogaPantsRootNode)
//        yogaPantsRootNode.worldPosition = SCNVector3(0, -100, -400)
//      } else {
//        fatalError("Did you forget to add a 'name' attribute to the node inside the .dae file??")
//      }
//    } else {
//      fatalError("could not load the main character's pants")
//    }
        // Set the scene to the view
        sceneView.scene = currentScene
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        // Create a session configuration
        let configuration = ARWorldTrackingConfiguration()
        configuration.isLightEstimationEnabled = false
      
        // Run the view's session
        sceneView.session.run(configuration)

        // where is the camera at start
        if let currentCameraPosition = sceneView.pointOfView?.position {
            print("**** Camera Position: \(currentCameraPosition)")
        } else {
            print("**** Camera Position: unknown")
        }
      
//        sceneView.pointOfView = sceneView.scene.rootNode.childNode(withName: "FACE_CAMERA", recursively: true)
      
      
      
      
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

