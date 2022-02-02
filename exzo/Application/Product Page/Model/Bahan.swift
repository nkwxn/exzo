//
//  Batu.swift
//  skripsiDifa
//
//  Created by Difa N Pratama on 07/01/22.
//

import Foundation
import SwiftUI

// swiftlint:disable all
struct Bahan: Hashable, Codable, Identifiable {
    let id = UUID()
    var name: String
    var bahanMengandung: [String]
    var description: String
}

var bahanBerbahya: [Bahan] = [
    Bahan(name: "Dyes",
          bahanMengandung: [
            "Dyes",
            "D&C Yellow #11",
            "FD&C Blue #1",
            "FD&C Yellow #5 (also known as tartrazine)",
            "paraphenylenediamine (PPD)"
          ],
          description: "When absorbed into your skin, artificial colours can lead to irritation, blocked pores, inflammation and sensitise the skin."),
    Bahan(name: "Fragrance",
          bahanMengandung: [
            "Fragrance",
            "3-Cyclohexene Carboxaldehyde",
            "Alpha Amyl Cinnamic Alcohol",
            "Anthemis Nobilis (Chamomile)",
            "Amyl Cinnamal",
            "Anisyl Alcohol",
            "Balsam of Peru (Myroxylon Pereirae)",
            "Benzaldehyde",
            "Benzyl Alcohol",
            "Benzyl Benzoate",
            "Benzyl Cinnamate",
            "Benzyl Salicylate",
            "Butylphenyl Methylpropional",
            "Cassia Oil",
            "Chamomile (Anthemis Nobilis)",
            "Cinnamal",
            "Cinnamic Alcohol",
            "Cinnamic Aldehyde",
            "Cinnamon Leaf Oil",
            "Cinnamyl Alcohol",
            "Citral",
            "Citronellol",
            "Clove Oil",
            "Cologne",
            "Coumarin",
            "Ethylene Brassylate",
            "Eugenol",
            "Evernia Furfuracea",
            "Evernia Prunastri",
            "Farnesol",
            "Geraniol",
            "Herbal Extracts",
            "Hexyl Cinnamal",
            "Hydroxycitronellal",
            "Hydroxylisohexyl 3-Cyclohexene",
            "Carboxaldehyde",
            "Isoeugenol",
            "Isomethyl Ionone",
            "Limonene",
            "Linalool",
            "Lyral",
            "Masking Fragrance",
            "Methyl 2-Octynoate",
            "Oakmoss absolute",
            "Perfume",
            "Phenoxyethanol",
            "Plant, flower, fruit, nut oils",
            "Yarrow (Achillea Millefolium)"
          ],
          description: "Fragrance adds to consumer appeal and may be used to cover up undesirable odors for some ingredients."),
    Bahan(name: "Preservatives",
          bahanMengandung: [
            "Preservatives",
            "Methylchloroisothiazolinone (MCI)",
            "Methylisothiazolinone (MIT/MI)"
          ],
          description: "Irritating preservatives are used to prevent microbial growth, unfortunately by their own nature, cause irritation to the skin of many people. Preservatives are the second most common cause of cosmetic allergic contact dermatitis."),
    Bahan(name: "Formaldehyde",
          bahanMengandung: [
            "Formaldehyde",
            "Bronopol",
            "Diazolidinyl Urea",
            "DMDM Hydantoin",
            "Imidazolidinyl Urea",
            "MDM Hydantoin",
            "Quaternium 15"
          ],
          description: "Formaldehyde releasers preserve a product against bacterial, mold and fungus contamination. Unfortunately, formaldehyde also causes irritation and allergic problems for some people."),
    Bahan(name: "Parabens",
          bahanMengandung: [
            "Paraben",
            "Benzylparaben",
            "Butylparaben",
            "Ethylparaben",
            "Methylparaben",
            "Propylparaben"
          ],
          description: "Parabens are preservatives that guard against mold, fungus, or bacteria growth."),
    Bahan(name: "Lanolin",
          bahanMengandung: [
            "Lanolin",
            "Lanolin (hydrous and anhydrous)",
            "Hydrogenated Lanolin",
            "Lanolin Alcohol",
            "Wool Fat",
            "Wool Wax",
            "Alcohols (Wool Alcohol)"
          ],
          description: "Lanolin and derivatives contribute properties to skin products that help moisturize. Lanolin is not a pure product but a complex combination of many substances which are difficult to separate and may carry over to derivatives. Some of these substances can cause skin irritation to sensitive skin, and may produce skin sensitization"),
    Bahan(name: "Surfactants",
          bahanMengandung: [
            "Surfactants",
            "Cocamidopropyl Betaine (CAPB)",
            "Sodium lauryl sulfate (SLS)",
            "Sodium laureth sulfate (SLES)",
            "Ammonium lauryl sulfate (ALS)"
          ],
          description: "Surfactants serve several functions but are best known for their cleaning or detergent use; in addition they are used for improved foaming action in many personal care products. Unfortunately, some surfactants are known skin sensitizers and/or skin irritants."),
    Bahan(name: "Urea",
          bahanMengandung: [
            "Urea"
          ],
          description: "Urea can be a fantastic ingredient for certain skin conditions. In particular, it can be a keratolytic, helping pull off thick, adherent scale in psoriasis, calluses and corns. However, in atopic dermatitis (AD), it can be irritating and can contribute to damaging the acid mantle of the skin. While it may be expertly formulated for AD patients, it is probably best avoided outside of special situations."),
    Bahan(name: "Retinoids",
          bahanMengandung: [
            "Retinoids"
          ],
          description: "Retinoids are an amazing class of medicines related to vitamin A. They play an important role for both acne and anti-aging, but they come with a price: they are often irritating and can trigger eczema flares. These should generally be avoided in patients with sensitive skin or at least used very, very carefully"),
    Bahan(name: "Ethanol",
          bahanMengandung: [
            "Ethanol"
          ],
          description: "Ethanol (alcohol) is often an ingredient in gels. These are lightweight, cooling and evaporate in seconds, which makes them great preparations for hair-bearing areas. However, for patients with AD and sensitive skin, alcohols can sting, burn and dry out the skin, so are best avoided"),
    
]

// INGREDIENTS: Limonene, Ethanol, Urea, Hydrogenated Lanolin, Surfactants
