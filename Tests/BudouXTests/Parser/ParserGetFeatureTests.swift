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
            w6: "f")

        XCTAssertTrue(feature.contains("UW1:a"))

        XCTAssertTrue(feature.contains("BW1:bc"))

        XCTAssertTrue(feature.contains("TW1:abc"))
    }


    func testShouldNotIncludeInvalidFeatures() throws {
        let feature: [String] = Parser.getFeature(
            w1: "a",
            w2: "a",
            w3: invalid,
            w4: "a",
            w5: "a",
            w6: "a")


        func findByPrefix(prefix: String, feature: [String]) -> Bool {
            for item in feature {
                if item.hasPrefix(prefix) {
                    return true
                }
            }

            return false
        }

        XCTAssertFalse(findByPrefix(prefix: "UW3", feature: feature))
        XCTAssertFalse(findByPrefix(prefix: "BW2", feature: feature))
    }
}
