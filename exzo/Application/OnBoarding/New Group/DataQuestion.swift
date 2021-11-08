//
//  DataQuestion.swift
//  exzo
//
//  Created by Difa N Pratama on 04/11/21.
//

import Foundation

let dataQuestions = [
    DataQuestion(title: "Dryness", description: "In the last three days, how dry are the area of your skin that are effected by eczema?", image: "dry"),
    DataQuestion(title: "Redness", description: "In the last three days, how red are the area of your skin that are effected by eczema?", image: "red"),
    DataQuestion(title: "Swelling", description: "In the last three days, are there any swelling on your eczema?", image: "swell"),
    DataQuestion(title: "Crust/Oozing", description: "In the last three days, were there any crust or oozing on your eczema?", image: "crust"),
    DataQuestion(title: "Scratch Traces", description: "In the last three days, were there any scratch marks on your eczema?", image: "scratch"),
    DataQuestion(title: "Thickened Skin", description: "In the last three days, did your skin get thickened?", image: "thicken"),
    DataQuestion(title: "Itchiness", description: "In the last three days, do you feel itchy because of your eczema?", image: "itch"),
    DataQuestion(title: "Sleep Loss", description: "In the last three days, how does your eczema disturbed you in your sleep?", image: "sleep")
]

struct DataQuestion {
    let title: String
    let description: String
    let image: String
}
