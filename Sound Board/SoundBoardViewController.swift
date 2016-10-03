//
//  SoundBoardViewController.swift
//  Sound Board
//
//  Created by Terry Johnson on 10/2/16.
//  Copyright © 2016 Terry Johnson. All rights reserved.
//

import UIKit
import AVFoundation

class SoundBoardViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var recordButton: UIButton!
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var playButton: UIButton!
    @IBOutlet weak var addButton: UIButton!
    
    // set audioRecorder variable to nil with the ?
    var audioRecorder : AVAudioRecorder?
    var audioPlayer : AVAudioPlayer?
    
    var audioURL : URL?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        setupRecorder()
        playButton.isEnabled = false
        addButton.isEnabled = false
    }
    
    func setupRecorder() {
        // Create an audio session
        let session = AVAudioSession.sharedInstance()
        
        do {
        // this section needs the do .. try .. catch parameters for error handling
        try session.setCategory(AVAudioSessionCategoryPlayAndRecord)
        try session.overrideOutputAudioPort(.speaker)
        try session.setActive(true)
        
        // Create URL for the audio file
            let basePath : String = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).first!
            let pathComponents = [basePath, "audio.m4a"]
            audioURL = NSURL.fileURL(withPathComponents: pathComponents)!

        // Create settings for the audio recorder
            var settings : [String:Any] = [:]
            settings[AVFormatIDKey] = Int(kAudioFormatMPEG4AAC)
            settings[AVSampleRateKey] = 44100.0
            settings[AVNumberOfChannelsKey] = 2
            
        // Create AudioRecorder Object
            audioRecorder = try AVAudioRecorder(url: audioURL!, settings: settings)
            audioRecorder!.prepareToRecord()
            
        } catch let error as NSError {
            print("setupRecorder initialization Error: \(error)")
            
        }
    }
    
    // Need this function for the keyboard to be dismissed when completed entry
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.view.endEditing(true)
        return false
    }
    
    @IBAction func recordTapped(_ sender: AnyObject) {
        
        if audioRecorder!.isRecording {
            // Stop the recording
            audioRecorder?.stop()
            // change button title to record
            recordButton.setTitle("Record", for: .normal)
            playButton.isEnabled = true
            addButton.isEnabled = true
        } else {
            // start the recording
            audioRecorder?.record()
            // change the button title to stop
            recordButton.setTitle("Stop", for: .normal)
        }
    }
    
    @IBAction func playTapped(_ sender: AnyObject) {
        
        do {
            try audioPlayer = AVAudioPlayer(contentsOf: audioURL!)
            audioPlayer!.play()
        } catch { print("AudioPlayer Error")}
    }
    
    @IBAction func addTapped(_ sender: AnyObject) {
    }

    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    

}
