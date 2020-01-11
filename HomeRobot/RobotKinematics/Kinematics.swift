//
//  kinematics.swift
//  HomeRobot
//
//  Created by Ferdinand Lösch on 29/10/2019.
//  Copyright © 2019 Laan Labs. All rights reserved.
//

import Foundation
import simd

class Kinematics {
    static let shared = Kinematics()
    // Initializer access level change now
    private init() {}
    func targetPoseToVelocityLinear(_ currentPosition: vector_float3,_ target: vector_float3) -> (Float, Float) {
        let relativeTarget = currentPosition - target
        let gain: Float = 0.5
        let velocity: Float = 0
        let angular: Float = 0
        let minDistToWayPoint: Float = 0.15
        let x = relativeTarget.z
        let y = relativeTarget.y
        let distance = sqrt((x * x) + (y * y))
        let theta = atan2(y, x)
        if distance > minDistToWayPoint, abs(theta) > 0.1 {
            return (velocity, angular)
        } else {
            return (gain * distance, theta)
        }
    }

//    func targetPoseToVelocitySpline(_ currentPosition: vector_float3,_ target: vector_float3) -> (Float,Float) {
//        let relativeTarget = currentPosition - target
//        let gain: Float = 0.5
//        let velocity: Float = 0
//        let angular: Float = 0
//        let minDistToWayPoint: Float = 0.15
//        let x = relativeTarget.z
//        let y = relativeTarget.y
//        let s = sqrt(((x * x) + (y * y)))
//        let l = sqrt(((x * x) + (y * y)))
//        let t = relativeTarget.y
//
//        return
//    }

}
