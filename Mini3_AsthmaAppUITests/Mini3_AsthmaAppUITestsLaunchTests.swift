////
////  Mini3_AsthmaAppUITestsLaunchTests.swift
////  Mini3_AsthmaAppUITests
////
////  Created by Jonathan Aaron Wibawa on 15/08/24.
////
//
//import XCTest
//
//final class Mini3_AsthmaAppUITestsLaunchTests: XCTestCase {
//
//    override class var runsForEachTargetApplicationUIConfiguration: Bool {
//        true
//    }
//
//    override func setUpWithError() throws {
//        continueAfterFailure = false
//    }
//
//    func testLaunch() throws {
//        let app = XCUIApplication()
//        app.launch()
//
//        // Insert steps here to perform after app launch but before taking a screenshot,
//        // such as logging into a test account or navigating somewhere in the app
//
//        let attachment = XCTAttachment(screenshot: app.screenshot())
//        attachment.name = "Launch Screen"
//        attachment.lifetime = .keepAlways
//        add(attachment)
//    }
//}
