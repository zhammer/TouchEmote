//
//  DataTests.swift
//  TouchEmoteWithData
//
//  Created by Zach Hammer on 1/3/17.
//  Copyright © 2017 Zach Hammer. All rights reserved.
//

import XCTest

class DataTests: XCTestCase {

    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }

    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }

    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    
    /* Move this to tests */
    @IBAction func testClickHander(_ sender: Any) {
        
        let allClicks: [NSManagedObject] = fetchDataByType(entityName: Entity.Click)
        var clicksCounter = 0
        
        for emotion in emotions {
            let clickArray = getClicksOnEmotion(emotion: emotion)
            if clickArray.count != emotion.value(forKey: EmotionAttr.Count) as! Int {
                print("Error: \(emotion.value(forKey: EmotionAttr.Emoji)) has mismatched count and num clicks")
            }
            clicksCounter += clickArray.count
            for click in clickArray {
                if click.value(forKey: ClickAttr.Emotion) as! NSManagedObject != emotion {
                    print("Error: Click has mismatched emotion")
                }
            }
        }
        if allClicks.count != clicksCounter {
            print("Error: unequal total clicks and clicks on emotions")
        }
        
        print("Test completed")
    }

}
