//
//  ViewController.swift
//  FPSControls
//
//  Created by Nick Lockwood on 30/10/2014.
//  Copyright (c) 2014 Nick Lockwood. All rights reserved.
//

import UIKit
import SceneKit

class ViewController: UIViewController {

    // MARK: Properties

    @IBOutlet weak var sceneView: SCNView!
    @IBOutlet weak var overlayView: UIView!

    var lookGesture: UIPanGestureRecognizer!
    var walkGesture: UIPanGestureRecognizer!
    var fireGesture: FireGestureRecognizer!

    let autofireTapTimeThreshold = 0.2
    let maxRoundsPerSecond = 30
    let bulletRadius = 0.05
    let bulletImpulse = 15
    let maxBullets = 100
    
    var tapCount = 0
    var lastTappedFire: TimeInterval = 0
    var lastFired: TimeInterval = 0
    var bullets = [SCNNode]()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.setupGame()
    }

    /**
    *  Setup game by creating and configuring singleton instance
    *  of scene, assigning it to scene property of the Interface Builder
    *  outlet of the SceneKit view, assigning the current View Controller
    *  as the delegate of the SceneKit view implementing the
    *  relevant protocols, showing statistics including FPS and timing info
    *  and setting up gesture recognisers for looking, walking, and firing.
    */
    func setupGame() {

        Scene.sharedInstance.setupSceneWithView(self.sceneView!)
        self.sceneView!.scene = Scene.sharedInstance
        self.sceneView!.delegate = self
        self.sceneView!.showsStatistics = true
        self.sceneView!.backgroundColor = UIColor.black
        self.setupGestureRecognizers()
    }

    override func viewDidAppear(_ animated: Bool) {
        
        UIView.animate(withDuration: 0.5, animations: {
            self.overlayView.alpha = 1
        }) 
    }
    
    @IBAction func hideOverlay() {
        
        UIView.animate(withDuration: 0.5, animations: {
            self.overlayView.alpha = 0
        }) 
    }
}
