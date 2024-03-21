//
//  ViewController.swift
//  SolarSystemArtKit
//
//  Created by Murad on 20.03.2024.
//

import UIKit
import SceneKit
import ARKit

class ViewController: UIViewController, ARSCNViewDelegate {

    @IBOutlet var sceneView: ARSCNView!

    override func viewDidLoad() {
        // It works when we start using our program
        super.viewDidLoad()
        

        sceneView.delegate = self //sets itself as delegate\
        

        // We are useing the size of the real planets structured with each other
        // it is a simple function to make our work easier
        let sun = createSphere(radius: 0.4, content: "sun.jpg", vector: SCNVector3(x: 0, y: 0, z: -1))
        let mercury = createSphere(radius: 0.03, content: "mercury.jpg", vector: SCNVector3(x: -0.5, y: 0, z: -1))
        let venus = createSphere(radius: 0.1, content: "venus.png", vector: SCNVector3(x: -0.8, y: 0, z: -1))
        let world = createSphere(radius: 0.1, content: "world.png", vector: SCNVector3(x: -1.2, y: 0, z: -1))
        let mars = createSphere(radius: 0.05, content: "mars.png", vector: SCNVector3(x: -1.6, y: 0, z: -1))
        let jupiter = createSphere(radius: 0.23, content: "jupiter.jpg", vector: SCNVector3(x: -2.2, y: 0, z: -1))
        let saturn = createSphere(radius: 0.19, content: "saturn.jpg", vector: SCNVector3(x: -2.8, y: 0, z: -1))
        let uranus = createSphere(radius: 0.15, content: "uranus.jpg", vector: SCNVector3(x: -3.5, y: 0, z: -1))
        let neptune = createSphere(radius: 0.13, content: "neptun.jpg", vector: SCNVector3(x: -4.0, y: 0, z: -1))
        
        //thats a way to run our function
        sceneView.scene.rootNode.addChildNode(sun)
        sceneView.scene.rootNode.addChildNode(mercury)
        sceneView.scene.rootNode.addChildNode(venus)
        sceneView.scene.rootNode.addChildNode(world)
        sceneView.scene.rootNode.addChildNode(mars)
        sceneView.scene.rootNode.addChildNode(jupiter)
        sceneView.scene.rootNode.addChildNode(saturn)
        sceneView.scene.rootNode.addChildNode(uranus)
        sceneView.scene.rootNode.addChildNode(neptune)
        
        sceneView.automaticallyUpdatesLighting = true
    }
    // The function which normalize our work
    func createSphere(radius: CGFloat, content: String, vector: SCNVector3) -> SCNNode{
        let sphere = SCNSphere(radius: radius)
        let material = SCNMaterial()
        material.diffuse.contents = UIImage(named: "art.scnassets/\(content)")
        sphere.materials = [material]
        let node = SCNNode()
        node.position = vector
        node.geometry = sphere
        
        // The rotation of Planets around themselves
        let rotation = SCNAction.rotateBy(x: 0, y: 2 * .pi, z: 0, duration: 20)
        let limit = SCNAction.repeatForever(rotation)
        node.runAction(limit)
        return node
    }
    //Function that allows us to see our mini solor system normally in the real world
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        let configuration = ARWorldTrackingConfiguration()
        sceneView.session.run(configuration)
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        sceneView.session.pause()
    }
}
