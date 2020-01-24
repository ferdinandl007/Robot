//
//  WifiServiceManagerDelegate.swift
//  HomeRobot
//
//  Created by Ferdinand Lösch on 24/01/2020.
//  Copyright © 2020 Laan Labs. All rights reserved.
//

import Foundation

// MARK: - WifiServiceManagerDelegate

extension ViewController: WifiServiceManagerDelegate {
    
    func connectedDevicesChanged(manager _: WifiServiceManager, connectedDevices: [String]) {
        OperationQueue.main.addOperation {
            var s = ""
            for d in connectedDevices {
                s += d
                s += ", "
            }
            self.connectionsLabel.text = "Wifi: " + s

            self.botConnectionState = .wifi
            if connectedDevices.count == 0, self.robot == nil {
                self.botConnectionState = .disconnected
            } else if connectedDevices.count > 0, self.robot == nil {
                self.botConnectionState = .wifi
                self.killRobotSlider.reset()
                _ = AudioPlayer.shared.play(.data_transfer_complete)
            } else if connectedDevices.count > 0, self.robot != nil {
                DispatchQueue.main.asyncAfter(deadline: .now() + 3.0) {
                    _ = AudioPlayer.shared.play(.remote_activation)
                }
            }
        }
    }

    func gotData(manager _: WifiServiceManager, data: Data) {
        processIncomingData(data)
    }
}

extension ViewController: RMCoreDelegate {
    func robotDidConnect(_ robot: RMCoreRobot!) {
        self.robot = robot as? RMCoreRobotRomo3
        robotStatusLabel.text = "Robot Connected!"
        botConnectionState = .plug

        _ = AudioPlayer.shared.play(.docking_sequence_activated)
        self.robot.tilt(toAngle: 20, completion: { _ in
            self.robot.tilt(toAngle: 90, completion: { _ in
                DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
                    _ = AudioPlayer.shared.play(.welcome)
                    AudioPlayer.shared.playAmbient()
                }
            })
        })
    }

    func robotDidDisconnect(_: RMCoreRobot!) {
        robot = nil
        robotStatusLabel.text = "Robot Disconnected"
        botConnectionState = .disconnected
        _ = AudioPlayer.shared.play(.hibernation_activated)
        AudioPlayer.shared.stopAmbient()
    }
}
