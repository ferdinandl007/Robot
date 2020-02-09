//
//  ARNavigationKitDelicates.swift
//  HomeRobot
//
//  Created by Ferdinand Lösch on 24/01/2020.
//  Copyright © 2020 Laan Labs. All rights reserved.
//

import ARNavigationKit
import Foundation
import SceneKit
import simd

// MARK: - ARNavigationKitDelegate

extension ViewController: ARNavigationKitDelegate {
    func updateDebugView(_: UIView) {}

    func getPathupdate(_ path: [vector_float3]?) {
        self.path = (path?.map { SCNVector3($0) }) ?? []

        if self.path.isEmpty {
            _ = AudioPlayer.shared.play(.target_lost)
            currentDriveState = .getWaypoints
            return
        }
        updatePath(self.path)
        currentDriveState = .getPoint
    }
}
