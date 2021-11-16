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
    DataQuestion(title: "Sleep Loss", description: "In the last three days, how does your eczema disturbed you in your sleep?", image: "sleep"),
    DataQuestion(title: "Lorem", description: "Lorem Ipsum Odor", image: "lorem")
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

var selectedBody = [String]()
//Jangan lupa apanya itu lu inget" kembali keynya apa, biar nanti ga ribet pokoknya. Gua lupa ngasih tunjuk untuk yang ini jurnal section

//  DataInsight.swift
//  Created by Difa N Pratama on 10/11/21.

import Foundation
// swiftlint:disable all
let dataInsight = [
    ResultInsights(title: "Lots of scratch traces", description: "There are many traces of scratches that can be seen all over your body. Try to reduce scratching your body, consult with a doctor for anti-itch medication if necessary.", image: "scratch3"),
    ResultInsights(title: "Lots of thickened skin", description: "TMany areas of your skin have a bumpy texture and are darker than the surrounding skin.", image: "thicken3"),
    ResultInsights(title: "Quite Dry", description: "You’re skin is quite dry, so you need to apply moisturizer several times a day.", image: "dry3"),
    ResultInsights(title: "Quite Red", description: "Some redness can be seen on your body. Use products that give more soothing effect on your skin.", image: "red3"),
    ResultInsights(title: "A bit swelling", description: "TYou have a bit of an increase in the size or a change in the shape of an area of the body.", image: "crust3"),
    ResultInsights(title: "A bit crust / oozing", description: "You have some pus-filled blisters. These sores literally weep, resulting in oozing or wetness. The pus is usually yellow or clear in color and eventually dries up as a crusty layer on your skin.", image: "swell3"),
    ResultInsights(title: "Severe itching", description: "Really disturbs your activities and continues throughout the day and night.", image: "itch"),
    ResultInsights(title: "Rarely disturbed my sleep", description: "Really disturbs your activities and continues throughout the day and night.", image: "sleep")
]

struct ResultInsights {
    let title: String
    let description: String
    let image: String
}
