//
//  ARCloud.swift
//  Robotty
//
//  Created by Ferdinand Lösch on 25/10/2019.
//  Copyright © 2019 Ferdinand Lösch. All rights reserved.
//
import Foundation
import SceneKit

/* protocol ARCloudManager {
 func startWithSceneView()
 func showMapPicker()
 } */

/*
 What does this manage?

 - Load an existing map
 - Create a new map
 -

 */

protocol ARCloudDelegate {
    func mapLoaded()

    // Init, Done, Uploading, Saved
    func mapCreationStatusChanged()
}

class ARCloudManager {
    func startWithSceneView() {}

    // Present as pop-over?
    func showMapPicker() {}

    // MARK: - Position conversion ARKit -> Map

    func convertToMap(position _: SCNVector3) -> SCNVector3? {
        return nil
    }

    func convertFromMap(position _: SCNVector3) -> SCNVector3? {
        return nil
    }
}
