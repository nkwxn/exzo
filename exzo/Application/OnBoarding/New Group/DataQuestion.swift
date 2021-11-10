//
//  DataQuestion.swift
//  exzo
//
//  Created by Difa N Pratama on 04/11/21.
//

import Foundation

let dataQuestions = [
    DataQuestion(title: "Body Parts", description: "Pick your current affected parts of your body which correspond to where your eczema is situated.", image: "body"),
    DataQuestion(title: "Dryness", description: "In the last three days, how dry are the area of your skin that are effected by eczema?", image: "dry"),
    DataQuestion(title: "Redness", description: "In the last three days, how red are the area of your skin that are effected by eczema?", image: "red"),
    DataQuestion(title: "Swelling", description: "In the last three days, are there any swelling on your eczema?", image: "swell"),
    DataQuestion(title: "Crust/Oozing", description: "In the last three days, were there any crust or oozing on your eczema?", image: "crust"),
    DataQuestion(title: "Scratch Traces", description: "In the last three days, were there any scratch marks on your eczema?", image: "scratch"),
    DataQuestion(title: "Thickened Skin", description: "In the last three days, did your skin get thickened?", image: "thicken"),
    DataQuestion(title: "Itchiness", description: "In the last three days, do you feel itchy because of your eczema?", image: "itch"),
    DataQuestion(title: "Sleep Loss", description: "In the last three days, how does your eczema disturbed you in your sleep?", image: "sleep")
]

let backBody = [
    "B - Head",
    "B - Shoulder",
    "B - Chest",
    "B - Belly",
    "B - Right Bottom",
    "B - Left Bottom",
    "B - Right Shoulder",
    "B - Right Bisep",
    "B - Right Arm",
    "B - Right Finger",
    "B - Left Shoulder",
    "B - Left Bisep",
    "B - Left Finger",
    "B - Right Knee",
    "B - Right Foot",
    "B - Left Knee",
    "B - Left Foot"
]

let selectedBackBody = [
    "SB - Head",
    "SB - Shoulder",
    "SB - Chest",
    "SB - Belly",
    "SB - Right Bottom",
    "SB - Left Bottom",
    "SB - Right Shoulder",
    "SB - Right Bisep",
    "SB - Right Arm",
    "SB - Right Finger",
    "SB - Left Shoulder",
    "SB - Left Bisep",
    "SB - Left Finger",
    "SB - Right Knee",
    "SB - Right Foot",
    "SB - Left Knee",
    "SB - Left Foot"
]

struct DataQuestion {
    let title: String
    let description: String
    let image: String
}
