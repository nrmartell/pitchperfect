//
//  ViewController.swift
//  PitchPerfect
//
//  Created by -Natalie  on 11/7/16.
//  Copyright © 2016 Natalie. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
 @IBOutlet weak var recordingLabel: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


    @IBAction func recordAudio(_ sender: Any) {
        print("Record button pressed")
        recordingLabel.text = "Recording in Progress"
    }
   
    @IBAction func stopRecording(_ sender: Any) {
        print("Stop recording button pressed")
    }
    }

