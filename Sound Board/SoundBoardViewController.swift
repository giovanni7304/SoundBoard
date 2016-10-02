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
    
    // set audioRecorder variable to nil with the ?
    var audioRecorder : AVAudioRecorder?
    
    

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        setupRecorder()
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
            let audioURL = NSURL.fileURL(withPathComponents: pathComponents)!
        // Create settings for the audio recorder
            var settings : [String:Any] = [:]
            settings[AVFormatIDKey] = Int(kAudioFormatMPEG4AAC)
            settings[AVSampleRateKey] = 44100.0
            settings[AVNumberOfChannelsKey] = 2
            
        // Create AudioRecorder Object
            audioRecorder = try AVAudioRecorder(url: audioURL, settings: settings)
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
    }
    
    @IBAction func playTapped(_ sender: AnyObject) {
    }
    
    @IBAction func addTapped(_ sender: AnyObject) {
    }

    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    

}
