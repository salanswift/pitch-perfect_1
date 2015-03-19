//
//  PlaySoundViewController.swift
//  Pitch Perfect
//
//  Created by Arsalan Akhtar on 08/03/2015.
//  Copyright (c) 2015 Arsalan Akhtar. All rights reserved.
//

import UIKit
import AVFoundation

class PlaySoundViewController: UIViewController {

    var audioPlayer: AVAudioPlayer!
    var audioEngine: AVAudioEngine!
    
    var recievedAudio: RecordedAudio!
 
    var audioFile: AVAudioFile!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.

        audioEngine = AVAudioEngine()
        
        audioPlayer = AVAudioPlayer(contentsOfURL: recievedAudio.filePathUrl, error: nil)
        audioPlayer.enableRate = true
        
        audioFile = AVAudioFile(forReading: recievedAudio.filePathUrl, error: nil)
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func stopSound(sender: UIButton)
    {
        stopAndResetAudio()
    
    }

    @IBAction func playFastSound(sender: UIButton)
    {
        audioPlayer.rate = 2.0
       playSoundCommonMethod()
    }

    @IBAction func playSlowSound(sender: AnyObject)
    {
    
    audioPlayer.rate = 0.5
        
    playSoundCommonMethod()
    
    }
    
    
    func playSoundCommonMethod()
    {
    audioPlayer.currentTime = 0.0
    stopAndResetAudio()
    audioPlayer.play()
        
    }
    
    
    @IBAction func playChipmunkSound(sender: UIButton)
    {
    playAudioWithVariablePith(1000)
    
    
    }
    
    @IBAction func playDathvaderSound(sender: AnyObject)
    {
        playAudioWithVariablePith(-1000)
    }
    func playAudioWithVariablePith (pitch : Float)
    {
        stopAndResetAudio()
        
        var audioPlayerNode = AVAudioPlayerNode()
        audioEngine.attachNode(audioPlayerNode)
    
        
        var changePitchEffect = AVAudioUnitTimePitch()
        changePitchEffect.pitch = pitch
        audioEngine.attachNode(changePitchEffect)
        
        audioEngine.connect(audioPlayerNode, to: changePitchEffect, format: nil)
        audioEngine.connect(changePitchEffect, to: audioEngine.outputNode, format: nil)
        
        audioPlayerNode.scheduleFile(audioFile, atTime: nil, completionHandler: nil)
        
        audioEngine.startAndReturnError(nil)
        
        audioPlayerNode.play()
        
    }
    
    func stopAndResetAudio()
    {
        audioEngine.stop()
        audioEngine.reset()
        audioPlayer.stop()
    }
        
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    @IBOutlet weak var playChipmiunkSound: UIButton!
    */

}
