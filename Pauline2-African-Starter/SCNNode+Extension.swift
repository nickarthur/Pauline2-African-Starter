//
//  SCNNode+Extension.swift
//  Pauline2-African-Starter
//
//  Created by Larry Nickerson on 2/7/19.
//  Copyright © 2019 Lawrence Nickerson. All rights reserved.
//

import Foundation
import SceneKit

// Mark: - Extension SCNNode
extension SCNNode {
  
    func printInfo() {
        // first print out location of  the current node
        print("**** \(name ?? "no name"): at local position: \(position)")
        print("**** \(name ?? "no name"): at world position: \(worldPosition)")

        // print the node's parent name
        print("**** \(name ?? "no name") parent: \(parent?.name ?? "no parent found")")

        // print out child node info
        var nodeNames: [String] = []
        for node in childNodes {
            nodeNames.append(node.name ?? "no name")
        }
      
        print("**** \(name ?? "no name"): has \(childNodes.count == 1 ? " \(childNodes.count) child" : " \(childNodes.count) children"): \(nodeNames)")

        // recursive call to have children print out thier info
        for node in childNodes {
            node.printInfo()
        }
    }
}
