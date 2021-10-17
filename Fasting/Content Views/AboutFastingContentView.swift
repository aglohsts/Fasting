//
//  AboutFastingContentView.swift
//  Fasting
//
//  Created by Apps4World on 2/4/21.
//

import SwiftUI

/// A general information view about fasting
struct AboutFastingContentView: View {
    
    // MARK: - Main rendering function
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 30) {
                Text("What is intermittent fasting?").font(.largeTitle).bold()
                Text(fastingDescription)
            }
            .padding(40)
        }
    }
    
    let fastingDescription: String =
    """
    Intermittent fasting (IF) is an eating pattern that cycles between periods of fasting and eating.

    It doesn’t specify which foods you should eat but rather when you should eat them.

    In this respect, it’s not a diet in the conventional sense but more accurately described as an eating pattern.

    Common intermittent fasting methods involve daily 16-hour fasts or fasting for 24 hours, twice per week.

    Fasting has been a practice throughout human evolution. Ancient hunter-gatherers didn’t have supermarkets, refrigerators or food available year-round. Sometimes they couldn’t find anything to eat.

    As a result, humans evolved to be able to function without food for extended periods of time.

    In fact, fasting from time to time is more natural than always eating 3–4 (or more) meals per day.
    """
}

// MARK: - Render preview UI
struct AboutFastingContentView_Previews: PreviewProvider {
    static var previews: some View {
        AboutFastingContentView()
    }
}
