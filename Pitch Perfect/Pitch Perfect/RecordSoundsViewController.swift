//
//  RecordSoundsViewController.swift
//  Pitch Perfect
//
//  Created by Arsalan Akhtar on 07/03/2015.
//  Copyright (c) 2015 Arsalan Akhtar. All rights reserved.
//

import UIKit
import AVFoundation

class RecordSoundsViewController: UIViewController,AVAudioRecorderDelegate {

    @IBOutlet weak var stopButton: UIButton!
    
    @IBOutlet weak var recordButton: UIButton!
    
    @IBOutlet weak var recordingLabel: UILabel!
    
    var audioRecorder: AVAudioRecorder!
    var recordedAudio: RecordedAudio!
    
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func stopRecording(sender: UIButton)
    {
        
        
            audioRecorder.stop()
            var audioSession = AVAudioSession.sharedInstance();
            audioSession.setActive(false, error: nil)
        
    }


    
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?)
    {
        if (segue.identifier == "stopRecording")
        {
            let playSound: PlaySoundViewController = segue.destinationViewController as PlaySoundViewController
            
            let data = sender as RecordedAudio
            
            playSound.recievedAudio = data
        }
    }

    @IBAction func recordVoice(sender: UIButton)
    {
      
        recordingLabel.text = "Recording..."
        
        stopButton.hidden = false
        recordButton.enabled = false
        
        let dirPath = NSSearchPathForDirectoriesInDomains(.DocumentDirectory, .UserDomainMask, true)[0] as String
        
        let currentDateTime = NSDate()
        
        let formatter = NSDateFormatter()
        
        formatter.dateFormat = "ddMMyyyy-HHmmss"
        
        let recordingName = formatter.stringFromDate(currentDateTime)+".wav" // recording name is based on the current time so no two files has the same name
        
        let pathArray = [dirPath, recordingName]
        
        let filePath = NSURL.fileURLWithPathComponents(pathArray)
        
        println(filePath)
        
        var session = AVAudioSession.sharedInstance()
        session.setCategory(AVAudioSessionCategoryPlayAndRecord, error: nil)
        
        audioRecorder = AVAudioRecorder(URL: filePath, settings: nil, error: nil)
        audioRecorder.delegate = self
        audioRecorder.meteringEnabled = true
        audioRecorder.record()
        
        
    }

    func audioRecorderDidFinishRecording(recorder: AVAudioRecorder!, successfully flag: Bool)
    {
        if(flag)
        {
            
        recordedAudio = RecordedAudio(filePathUrlInit: recorder.url, titleInit: recorder.url.lastPathComponent)
            
    
            
        self.performSegueWithIdentifier("stopRecording", sender: recordedAudio)
        }
        else
        {
            println("Sound does not recorded successfully")
            
        }
        
        resetUI() // resetting the UI to enable the recording again
    }


    func resetUI()
    {
        recordButton.enabled = true
        stopButton.hidden = true
        recordingLabel.text = "Tap to record"
    }


}

