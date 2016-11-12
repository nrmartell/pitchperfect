//
//  ViewController.swift
//  PitchPerfect
//
//  Created by -Natalie  on 11/7/16.
//  Copyright © 2016 Natalie. All rights reserved.
//

import UIKit
import AVFoundation

class RecordSoundsViewController: UIViewController, AVAudioRecorderDelegate{
    

    
    @IBOutlet weak var recordingLabel: UILabel!
    @IBOutlet weak var recordButton: UIButton!
    @IBOutlet weak var stopRecordingButton: UIButton!
    
    var audioRecorder:AVAudioRecorder!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        stopRecordingButton.isEnabled = false
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
 
    func configureUI(recording: Bool) {
        recordingLabel.text = recording ? "Recording in progress" : "Tap to Record"
        stopRecordingButton.isEnabled = recording
        recordButton.isEnabled = !recording
    }


    @IBAction func recordAudio(_ sender: Any) {
        print("Record button pressed")
        configureUI(recording: true)
        
        let recordingName = "recordedVoice.wav"
        let dirPath = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first
        let filePath = URL(fileURLWithPath: recordingName, relativeTo: dirPath)
        let session = AVAudioSession.sharedInstance()
        try! session.setCategory(AVAudioSessionCategoryPlayAndRecord)
        

   try! audioRecorder = AVAudioRecorder(url: filePath, settings: [:])
        audioRecorder.delegate = self
        audioRecorder.isMeteringEnabled = true
        audioRecorder.prepareToRecord()
        audioRecorder.record()
        
        
    }
   
    @IBAction func stopRecording(_ sender: Any) {
        configureUI(recording: false)
        audioRecorder.stop()
        let audioSession = AVAudioSession.sharedInstance()
        try! audioSession.setActive(false)
    }
    override func viewWillAppear(_ animated: Bool) {
       
    }
    func audioRecorderDidFinishRecording(_ recorder: AVAudioRecorder, successfully flag: Bool) {
        print("AVAudioRecorder finished saving recording")
        if(flag) {
           performSegue(withIdentifier: "stopRecording", sender: audioRecorder.url)
        }
        else{
            print("Saving of recording failed")
        }
        
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.identifier == "stopRecording") {
            let playSoundsVC = segue.destination as! PlaySoundsViewController
            let recordedAudioURL = sender as! NSURL
            playSoundsVC.recordedAudioURL = recordedAudioURL
        }
    }
    }

