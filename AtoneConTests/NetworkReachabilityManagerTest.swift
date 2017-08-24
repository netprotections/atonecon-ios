//
//  NetworkReachabilityManagerTest.swift
//  AtoneCon
//
//  Created by Pham Ngoc Hanh on 8/18/17.
//  Copyright © 2017 AsianTech Inc. All rights reserved.
//

import Foundation
import XCTest
import SystemConfiguration
@testable import AtoneCon

final class NetworkReachabilityManagerTest: XCTestCase {

    let timeout: TimeInterval = 30.0

    func testThatManagerCanBeInitializedFromHost() {
        // Given, When
        let manager = NetworkReachabilityManager(host: "localhost")

        // Then
        XCTAssertNotNil(manager)
    }

    func testThatManagerCanBeInitializedFromAddress() {
        // Given, When
        let manager = NetworkReachabilityManager()

        // Then
        XCTAssertNotNil(manager)
    }

    func testThatHostManagerIsReachableOnWiFi() {
        // Given, When
        let manager = NetworkReachabilityManager(host: "localhost")

        // Then
        XCTAssertEqual(manager?.networkReachabilityStatus, .reachable(.ethernetOrWiFi))
        XCTAssertEqual(manager?.isReachable, true)
        XCTAssertEqual(manager?.isReachableOnWWAN, false)
        XCTAssertEqual(manager?.isReachableOnEthernetOrWiFi, true)
    }

    func testThatHostManagerStartsWithReachableStatus() {
        // Given, When
        let manager = NetworkReachabilityManager(host: "localhost")

        // Then
        XCTAssertEqual(manager?.networkReachabilityStatus, .reachable(.ethernetOrWiFi))
        XCTAssertEqual(manager?.isReachable, true)
        XCTAssertEqual(manager?.isReachableOnWWAN, false)
        XCTAssertEqual(manager?.isReachableOnEthernetOrWiFi, true)
    }

    func testThatAddressManagerStartsWithReachableStatus() {
        // Given, When
        let manager = NetworkReachabilityManager()

        // Then
        XCTAssertEqual(manager?.networkReachabilityStatus, .reachable(.ethernetOrWiFi))
        XCTAssertEqual(manager?.isReachable, true)
        XCTAssertEqual(manager?.isReachableOnWWAN, false)
        XCTAssertEqual(manager?.isReachableOnEthernetOrWiFi, true)
    }

    func testThatHostManagerCanBeDeinitialized() {
        // Given
        var manager: NetworkReachabilityManager? = NetworkReachabilityManager(host: "localhost")

        // When
        manager = nil

        // Then
        XCTAssertNil(manager)
    }

    func testThatAddressManagerCanBeDeinitialized() {
        // Given
        var manager: NetworkReachabilityManager? = NetworkReachabilityManager()

        // When
        manager = nil

        // Then
        XCTAssertNil(manager)
    }

    // MARK: - Tests - Listener
    func testThatHostManagerIsNotifiedWhenStartListeningIsCalled() {
        // Given
        guard let manager = NetworkReachabilityManager(host: "store.apple.com") else {
            XCTFail("manager should NOT be nil")
            return
        }

        let expectation = self.expectation(description: "listener closure should be executed")
        var networkReachabilityStatus: NetworkReachabilityManager.NetworkReachabilityStatus?

        manager.listener = { status in
            guard networkReachabilityStatus == nil else { return }
            networkReachabilityStatus = status
            expectation.fulfill()
        }

        // When
        manager.startListening()
        waitForExpectations(timeout: timeout, handler: nil)

        // Then
        XCTAssertEqual(networkReachabilityStatus, .reachable(.ethernetOrWiFi))
    }

    func testThatAddressManagerIsNotifiedWhenStartListeningIsCalled() {
        // Given
        let manager = NetworkReachabilityManager()
        let expectation = self.expectation(description: "listener closure should be executed")

        var networkReachabilityStatus: NetworkReachabilityManager.NetworkReachabilityStatus?

        manager?.listener = { status in
            networkReachabilityStatus = status
            expectation.fulfill()
        }

        // When
        manager?.startListening()
        waitForExpectations(timeout: timeout, handler: nil)

        // Then
        XCTAssertEqual(networkReachabilityStatus, .reachable(.ethernetOrWiFi))
    }

    // MARK: - Tests - Network Reachability Status
    func testThatManagerReturnsNotReachableStatusWhenReachableFlagIsAbsent() {
        // Given
        let manager = NetworkReachabilityManager()
        let flags: SCNetworkReachabilityFlags = [.connectionOnDemand]

        // When
        let networkReachabilityStatus = manager?.networkReachabilityStatusForFlags(flags)

        // Then
        XCTAssertEqual(networkReachabilityStatus, .notReachable)
    }

    func testThatManagerReturnsNotReachableStatusWhenConnectionIsRequired() {
        // Given
        let manager = NetworkReachabilityManager()
        let flags: SCNetworkReachabilityFlags = [.reachable, .connectionRequired]

        // When
        let networkReachabilityStatus = manager?.networkReachabilityStatusForFlags(flags)

        // Then
        XCTAssertEqual(networkReachabilityStatus, .notReachable)
    }

    func testThatManagerReturnsNotReachableStatusWhenInterventionIsRequired() {
        // Given
        let manager = NetworkReachabilityManager()
        let flags: SCNetworkReachabilityFlags = [.reachable, .connectionRequired, .interventionRequired]

        // When
        let networkReachabilityStatus = manager?.networkReachabilityStatusForFlags(flags)

        // Then
        XCTAssertEqual(networkReachabilityStatus, .notReachable)
    }

    func testThatManagerReturnsReachableOnWiFiStatusWhenConnectionIsNotRequired() {
        // Given
        let manager = NetworkReachabilityManager()
        let flags: SCNetworkReachabilityFlags = [.reachable]

        // When
        let networkReachabilityStatus = manager?.networkReachabilityStatusForFlags(flags)

        // Then
        XCTAssertEqual(networkReachabilityStatus, .reachable(.ethernetOrWiFi))
    }

    func testThatManagerReturnsReachableOnWiFiStatusWhenConnectionIsOnDemand() {
        // Given
        let manager = NetworkReachabilityManager()
        let flags: SCNetworkReachabilityFlags = [.reachable, .connectionRequired, .connectionOnDemand]

        // When
        let networkReachabilityStatus = manager?.networkReachabilityStatusForFlags(flags)

        // Then
        XCTAssertEqual(networkReachabilityStatus, .reachable(.ethernetOrWiFi))
    }

    func testThatManagerReturnsReachableOnWiFiStatusWhenConnectionIsOnTraffic() {
        // Given
        let manager = NetworkReachabilityManager()
        let flags: SCNetworkReachabilityFlags = [.reachable, .connectionRequired, .connectionOnTraffic]

        // When
        let networkReachabilityStatus = manager?.networkReachabilityStatusForFlags(flags)

        // Then
        XCTAssertEqual(networkReachabilityStatus, .reachable(.ethernetOrWiFi))
    }

    #if os(iOS)
    func testThatManagerReturnsReachableOnWWANStatusWhenIsWWAN() {
        // Given
        let manager = NetworkReachabilityManager()
        let flags: SCNetworkReachabilityFlags = [.reachable, .isWWAN]

        // When
        let networkReachabilityStatus = manager?.networkReachabilityStatusForFlags(flags)

        // Then
        XCTAssertEqual(networkReachabilityStatus, .reachable(.wwan))
    }

    func testThatManagerReturnsNotReachableOnWWANStatusWhenIsWWANAndConnectionIsRequired() {
        // Given
        let manager = NetworkReachabilityManager()
        let flags: SCNetworkReachabilityFlags = [.reachable, .isWWAN, .connectionRequired]

        // When
        let networkReachabilityStatus = manager?.networkReachabilityStatusForFlags(flags)

        // Then
        XCTAssertEqual(networkReachabilityStatus, .notReachable)
    }
    #endif
}
