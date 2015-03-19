//
//  RecordedAudio.swift
//  Pitch Perfect
//
//  Created by Arsalan Akhtar on 15/03/2015.
//  Copyright (c) 2015 Arsalan Akhtar. All rights reserved.
//

import Foundation

class RecordedAudio: NSObject
{

    var filePathUrl: NSURL!
    var title: String!

    init(filePathUrlInit: NSURL!, titleInit: String!)
    {
        self.filePathUrl = filePathUrlInit
        self.title = titleInit
    }


}