//
//  audioplayer.swift
//  HomeRobot
//
//  Created by Ferdinand Lösch on 28/10/2019.
//  Copyright © 2019 Laan Labs. All rights reserved.
//

import AVFoundation
import Foundation

enum playfile: String {
    case accessing_archives
    case accessing_files
    case all_phases_complete
    case communication_failure
    case data_transfer_complete
    case deactivating
    case do_you_wish_to_delete
    case docking_sequence_activated
    case downloading
    case engaged
    case hibernation_activated
    case holographic_imaging_activated
    case life_form_detected
    case mission_complete
    case mission_override
    case processing
    case program_terminated
    case remote_activation
    case sorry_try_again
    case system_shut_down
    case c_system_shut_down
    case target_locked
    case target_lost
    case target_range
    case uploading
    case verifying
    case welcome
    case auto_pilot_activated
    case system_stable
    case say_scanning
    case scan
    case ambient
    case pin_s
}

class AudioPlayer {
    var soundEffect: AVAudioPlayer?
    var ambientsound: AVAudioPlayer?
    static let shared = AudioPlayer()
    // Initializer access level change now
    private init() {}

    func play(_ file: playfile) -> Double {
        let path = Bundle.main.path(forResource: "\(file).mp3", ofType: nil)!
        let url = URL(fileURLWithPath: path)

        do {
            soundEffect = try AVAudioPlayer(contentsOf: url)
            soundEffect?.play()
            return soundEffect?.duration ?? 0

        } catch {
            return 0
        }
    }

    func stop() {
        soundEffect?.stop()
    }

    func playAmbient() {
        let path = Bundle.main.path(forResource: "ambient.mp3", ofType: nil)!
        let url = URL(fileURLWithPath: path)

        do {
            ambientsound = try AVAudioPlayer(contentsOf: url)
            ambientsound?.play()
            ambientsound?.volume = 0.02
            ambientsound?.numberOfLoops = 1000

        } catch {
            print("no")
        }
    }

    func stopAmbient() {
        ambientsound?.stop()
    }
}
