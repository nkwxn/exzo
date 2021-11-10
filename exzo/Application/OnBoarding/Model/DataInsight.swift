//
//  DataInsight.swift
//  ParallaxScrolling_StickyHeader
//
//  Created by Difa N Pratama on 10/11/21.
//

import Foundation
//swiftlint:ignore all
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
