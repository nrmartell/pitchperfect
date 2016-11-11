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


    @IBAction func recordAudio(_ sender: Any) {
        print("Record button pressed")
        recordingLabel.text = "Recording in Progress"
        stopRecordingButton.isEnabled = true
        recordButton.isEnabled = false
        

        
        let recordingName = "recordedVoice.wav"
        let dirPath = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first
        let filePath = URL(fileURLWithPath: recordingName, relativeTo: dirPath)
        let session = AVAudioSession.sharedInstance()
        try! session.setCategory(AVAudioSessionCategoryPlayAndRecord)
        
        do {
            audioRecorder = try AVAudioRecorder(url: filePath, settings: [String: AnyObject]())
        } catch let error {
            audioRecorder = nil
            print("error setting up Audio Recorder: \(error.localizedDescription)")
            return
        }
//      try! audioRecorder = AVAudioRecorder(url: filePath, settings: [:])
        audioRecorder.delegate = self
        audioRecorder.isMeteringEnabled = true
        audioRecorder.prepareToRecord()
        audioRecorder.record()
        
        
    }
   
    @IBAction func stopRecording(_ sender: Any) {
        print("Stop button pressed")
        recordButton.isEnabled = true
        stopRecordingButton.isEnabled = false
        recordingLabel.text = "Tap to Record"
    }
    override func viewWillAppear(_ animated: Bool) {
       
    }
    func audioRecorderDidFinishRecording(_ recorder: AVAudioRecorder, successfully flag: Bool) {
        print("AVAudioRecorder finished saving recording")
        if(flag) {
            self.performSegue(withIdentifier: "stopRecording", sender: audioRecorder.url)
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

