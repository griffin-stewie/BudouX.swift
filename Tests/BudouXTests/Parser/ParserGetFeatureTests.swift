import XCTest

@testable import BudouX

final class ParserGetFeatureTests: XCTestCase {

    func testShouldIncludeCertainFeatures() throws {
        let feature: [String] = Parser.getFeature(
            w1: "a",
            w2: "b",
            w3: "c",
            w4: "d",
            w5: "e",
            w6: "f",
            p1: "x",
            p2: "y",
            p3: "z")

        XCTAssertTrue(feature.contains("UW1:a"))

        XCTAssertTrue(feature.contains("UB1:001"))
        XCTAssertTrue(feature.contains("UP1:x"))

        XCTAssertTrue(feature.contains("BW1:bc"))
        XCTAssertTrue(feature.contains("BB1:001001"))
        XCTAssertTrue(feature.contains("BP1:xy"))

        XCTAssertTrue(feature.contains("TW1:abc"))
        XCTAssertTrue(feature.contains("TB1:001001001"))
    }


    func testShouldNotIncludeInvalidFeatures() throws {
        let feature: [String] = Parser.getFeature(
            w1: "a",
            w2: "a",
            w3: invalid,
            w4: "a",
            w5: "a",
            w6: "a",
            p1: "a",
            p2: "a",
            p3: "a")


        func findByPrefix(prefix: String, feature: [String]) -> Bool {
            for item in feature {
                if item.hasPrefix(prefix) {
                    return true
                }
            }

            return false
        }

        XCTAssertFalse(findByPrefix(prefix: "UW3", feature: feature))
        XCTAssertFalse(findByPrefix(prefix: "UB3", feature: feature))
        XCTAssertFalse(findByPrefix(prefix: "BW2", feature: feature))
        XCTAssertFalse(findByPrefix(prefix: "BB2", feature: feature))
    }
}
