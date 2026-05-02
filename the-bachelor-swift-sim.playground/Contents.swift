import UIKit

// This Season's Bachelorettes...
var bachelorettes = ["Rachel", "Brooklyn", "Kaitlyn", "Charity", "Trista", "Becca", "Emily", "Hannah", "Jillian", "Ashley"]

// Alphabetical List
bachelorettes.sort()
print("Alphabetical Bachelorette Roster:\n\(bachelorettes)")

// Reverse Alphabetical List
bachelorettes.sort(by: >)
print("\nReverse Alphabetical Bachelorette Roster:\n\(bachelorettes)")

// First 4 Letters of Each Bachelorette's Name
print("\nNicknames:")
for name in bachelorettes {
    print(name.prefix(4))
}

// Bachelor Episode Structure
struct BachelorEpisode {
    var bachelorettes: [String]
    var affectionLevels: [String: Int]
    var episodeCount: Int
    let bachelorName: String
    
    let intros = ["GRAB YOUR POPCORN!", "THIS ONE'S A NAIL BITER!", "THE JOURNEY CONTINUES", "EXPECT THE UNEXPECTED", "BUCKLE UP—THIS GETS WILD", "THE DRAMA CONTINUES", "ARE YOU READY FOR THIS?", "GET READY FOR CHAOS!", "THE SHOCKING CONTINUATION"]
    
    let activities = [
        ("on a picnic", 1.2), ("skydiving!", 1.8), ("dancing!", 1.5),
        ("on a hot air balloon ride!", 2.0), ("on a sunset boat ride!", 2.2),
        ("stargazing.", 1.6), ("to a fancy cooking class.", 1.3),
        ("on a private wine tasting tour!", 1.9), ("on a museum date.", 1.1),
        ("on a luxury shopping spree!", 2.0), ("to a beach bonfire.", 1.8),
        ("on amusement park rides!", 1.4), ("to a rooftop dinner date!", 2.1),
        ("to a spa day for two.", 2.0), ("to an outdoor Concert.", 1.3),
        ("on a moonlit gondola ride.", 2.4)
    ]
    
    let dramaReasons = ["spreads a rumor", "bullies another girl", "cries in a limo", "confronts the Bachelor", "hides in the bushes for 'private' Intel", "steals someone’s rose (allegedly)", "makes a passive-aggressive toast", "gets drunk and ruins the group date", "overhears a secret and dramatizes it", "flirts like it’s a competitive sport", "stages a ‘chance encounter’ at the worst time", "sabotages the group date (oops, 'miscommunication')", "gives a heartfelt speech… then throws shade"]
    
    // Swap Function
    mutating func replaceContestant(oldName: String, newName: String) {
        if let index = bachelorettes.firstIndex(of: oldName) {
            // Remove the girl who is leaving
            affectionLevels.removeValue(forKey: oldName)
            
            // Swap in the ex-girlfriend
            bachelorettes[index] = newName
            
            // Random "History" bonus
            let historyBonus = Int.random(in: 20...40)
            affectionLevels[newName] = historyBonus
            
            print("\n⚠️ IN A SHOCKING NEW TWIST, the bachelor's ex-girlfriend, \(newName), is joining the girls!")
            print("\(oldName) is horrified and decides to leave!")
            print("📈 The bachelor is \(historyBonus)% attracted to \(newName). They have a 'complicated history'!")
        }
    }

    // New Episode Function
    mutating func runEpisode() {
        print("\n🎬 \(intros.randomElement() ?? "EPISODE \(episodeCount) BEGINS NOW!") (Episode \(episodeCount))")
        print("The remaining girls vying for \(bachelorName)'s heart are: \(bachelorettes.joined(separator: ", "))")
        
        let locations: [(String, Double)] = [("Paris", 2.4), ("New York", 1.2), ("Italy", 2.5), ("Mexico", 2.0), ("Greece", 1.8), ("California", 1.4), ("Antigua", 2.2), ("Banff", 2.0), ("Budapest", 1.3), ("Australia", 1.9), ("Texas", 1.3), ("Toronto", 1.1), ("Vienna", 2.5), ("Amsterdam", 2.0), ("The Mansion", 1.0), ("the Local Pub", 0.5)]
        let (city, multiplier) = locations.randomElement() ?? ("The Mansion", 1.0)
        print("📍 Location: \(city) (Romance Multiplier: \(multiplier)x)")

        let shuffledGirls = bachelorettes.shuffled()
        let dateContestants = shuffledGirls.prefix(2)
        
        var dateNumber = 1
        for girl in dateContestants {
            if let activity = activities.randomElement() {
                let basePoints = 10 + Int.random(in: 1...30)
                let finalGain = Int(Double(basePoints) * multiplier * activity.1)
                affectionLevels[girl, default: 0] += finalGain
                print("Date #\(dateNumber): \(bachelorName) takes \(girl) \(activity.0) Their attraction level increases by \(finalGain)%!")
                dateNumber += 1
            }
        }
        
        
        let dramaCandidates = bachelorettes.filter { !dateContestants.contains($0) }
        if let dramaQueen = dramaCandidates.randomElement() ?? bachelorettes.randomElement(), let reason = dramaReasons.randomElement() {
            let loss = Int.random(in: 5...20)
            affectionLevels[dramaQueen, default: 0] -= loss
            print("😱 DRAMA ALERT: \(dramaQueen) \(reason) and becomes \(loss)% less attractive to \(bachelorName)!")
        }
    }
}

// --- THE SIMULATION ---
let bachelor = "Peter"
var contestants = ["Rachel", "Brooklyn", "Kaitlyn", "Charity", "Trista", "Becca", "Emily", "Hannah", "Jillian", "Ashley"]
var scores: [String: Int] = [:]
contestants.forEach { scores[$0] = 0 }

print("\n✧──────────────────────────────────────────────────────────────────────────────────────✧")
print("EPISODE 1: WELCOME TO A BRAND NEW SEASON OF THE BACHELOR! 🎉")
if let luckyGirl = contestants.randomElement() {
    scores[luckyGirl, default: 0] += 20
    print("🌹 \(luckyGirl) receives the coveted 'First Impression Rose'! Out of the gate, \(bachelor) is smitten!")
}
print("No one is going home tonight. Get ready for the most dramatic season ever!")
print("✧──────────────────────────────────────────────────────────────────────────────────────✧")

var episodeCounter = 2

while contestants.count > 1 {
    var episode = BachelorEpisode(
        bachelorettes: contestants,
        affectionLevels: scores,
        episodeCount: episodeCounter,
        bachelorName: bachelor
    )
    
    // Episode 4 Swap Twist
    if episodeCounter == 4 {
        if let leavingGirl = contestants.randomElement() {
            episode.replaceContestant(oldName: leavingGirl, newName: "Desiree")
            contestants = episode.bachelorettes
        }
    }
    
    episode.runEpisode()
    
    // Elimination Time
    print("\n🌹 THE ROSE CEREMONY 🌹")
    // Sort by affection level descending
    contestants.sort { (episode.affectionLevels[$0] ?? 0) > (episode.affectionLevels[$1] ?? 0) }
    
    if contestants.count > 2 {
        let eliminated1 = contestants.removeLast()
        let eliminated2 = contestants.removeLast()
        print("\(eliminated1) and \(eliminated2), you did not receive a rose. Please say your goodbyes.")
    } else if contestants.count == 2 {
        let runnerUp = contestants.removeLast()
        print("\(bachelor): I'm so sorry \(runnerUp), but my heart belongs to someone else!")
    }
    
    print("✧──────────────────────────────────────────────────────────────────────────────────────✧")
    
    scores = episode.affectionLevels
    episodeCounter += 1
}

// --- THE GRAND FINALE ---
if let winner = contestants.first {
    let updates = [
        "are currently living in a bungalow with 3 golden retrievers.",
        "started a successful travel vlog and are currently in Bali.",
        "are planning a massive televised wedding for next summer!",
        "moved to a quiet farm to start an organic vineyard.",
        "are still together and just adopted a rescue cat named 'Rose'.",
        "are officially exes—but in a healthy, friendly group chat kind of way.",
        "are still together, but only because neither of them can exit the plot without a dramatic reveal.",
        "are living off vibes and emergency pizza deliveries. Romance? Yes. Budget? Questionable.",
        "are engaged—although one of them keeps saying 'we were on a break' like it’s a love strategy.",
        "are in therapy (together). The Bachelor turned out to be the real villain of their stress storyline.",
        "broke up in week 3, but they’re thriving as besties with matching ‘survived reality TV’ mugs.",
        "are currently in a situationship that is technically committed… by paperwork that hasn’t been signed yet.",
        "are together, and their ‘date nights’ include rewatching their own red-flag moments."
    ]
    
    let walkoffs = [
        "they walk off lip-locked, into the great unknown.",
        "scoops her up into his arms and trips! Oh well, the bruises are masked by the elation of the moment.",
        "scoops her up and they sprint away like the finale owes them money.",
        "they stumble into a slow-motion romance montage… and yes, it’s cringe—in a perfect way.",
        "says 'I choose you' as he tucks the rose behind her ear—because apparently we’re doing romance AND magic tricks now!",
        "the band hits a triumphant note like this was destiny (and not a last-minute choice).",
        "they storm out together like they’re both running from their group chat notifications.",
        "the camera lingers a little too long on their dramatic eye contact."
    ]
    
    let finalUpdate = updates.randomElement() ?? "are living happily ever after."
    let exit = walkoffs.randomElement() ?? "exit strategy"

    print("\n🌹🌹🌹 THE FINAL ROSE CEREMONY 🌹🌹🌹")
    print("""
    \(bachelor): \(winner), my journey started with 10 incredible women, 
    but it ends here with you. From the moment you stepped out of the limo, I knew you were the one. \(winner), will you accept my final rose? 🌹
    
    \(winner): (tearing up) A million times yes, \(bachelor)! 
    I've waited my whole life for this moment! 💍💕
    
    \(bachelor) embraces \(winner) and \(exit)
    [Dramatic music swells as the screen fades to black]
    """)
    print("✧──────────────────────────────────────────────────────────────────────────────────────✧")
    print("UPDATE: \(bachelor) and \(winner) \(finalUpdate)")
    print("✧──────────────────────────────────────────────────────────────────────────────────────✧")
}
