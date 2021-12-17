import XCTest
@testable import BudouX

final class ParserGetFeatureTests: XCTestCase {

    let feature: [String] = Parser.getFeature(w1: "a",
                                              w2: "b",
                                              w3: "c",
                                              w4: "d",
                                              w5: "e",
                                              w6: "f",
                                              p1: "x",
                                              p2: "y",
                                              p3: "z")

    func testShouldIncludeCertainFeatures() throws {
        XCTAssertTrue(feature.contains("UW1:a"))

        XCTAssertTrue(feature.contains("UB1:001"))
        XCTAssertTrue(feature.contains("UP1:x"))

        XCTAssertTrue(feature.contains("BW1:bc"))
        XCTAssertTrue(feature.contains("BB1:001001"))
        XCTAssertTrue(feature.contains("BP1:xy"))

        XCTAssertTrue(feature.contains("TW1:abc"))
        XCTAssertTrue(feature.contains("TB1:001001001"))
    }
}
