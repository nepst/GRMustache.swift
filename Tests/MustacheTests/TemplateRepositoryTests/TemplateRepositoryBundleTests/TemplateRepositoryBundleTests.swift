// The MIT License
//
// Copyright (c) 2015 Gwendal Roué
//
// Permission is hereby granted, free of charge, to any person obtaining a copy
// of this software and associated documentation files (the "Software"), to deal
// in the Software without restriction, including without limitation the rights
// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
// copies of the Software, and to permit persons to whom the Software is
// furnished to do so, subject to the following conditions:
//
// The above copyright notice and this permission notice shall be included in
// all copies or substantial portions of the Software.
//
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
// THE SOFTWARE.


import XCTest
@testable import Mustache
import Foundation

class TemplateRepositoryBundleTests: XCTestCase {

// GENERATED: allTests required for Swift 3.0
    static var allTests : [(String, (TemplateRepositoryBundleTests) -> () throws -> Void)] {
        return [
            ("testTemplateRepositoryWithBundle", testTemplateRepositoryWithBundle),
            ("testTemplateRepositoryWithBundleTemplateExtensionEncoding", testTemplateRepositoryWithBundleTemplateExtensionEncoding),
        ]
    }
// END OF GENERATED CODE

    func testTemplateRepositoryWithBundle() {
        var template: Template
        var rendering: String

        let repo = TemplateRepository(bundle: FoundationAdapter.getBundle(for: type(of: self)))

        do {
            let _ = try repo.template(named: "notFound")
            XCTAssert(false)
        } catch {
        }

        template = try! repo.template(named: "TemplateRepositoryBundleTests")
        rendering = try! template.render()
        XCTAssertEqual(rendering, "TemplateRepositoryBundleTests.mustache TemplateRepositoryBundleTests_partial.mustache")

        template = try! repo.template(string: "{{>TemplateRepositoryBundleTests}}")
        rendering = try! template.render()
        XCTAssertEqual(rendering, "TemplateRepositoryBundleTests.mustache TemplateRepositoryBundleTests_partial.mustache")

        template = try! repo.template(string: "{{>TemplateRepositoryBundleTestsResources/partial}}")
        rendering = try! template.render()
        XCTAssertEqual(rendering, "partial sibling TemplateRepositoryBundleTests.mustache TemplateRepositoryBundleTests_partial.mustache")
    }

    func testTemplateRepositoryWithBundleTemplateExtensionEncoding() {
        var template: Template
        var rendering: String

        let testBundle = FoundationAdapter.getBundle(for: type(of: self))
        var repo = TemplateRepository(bundle: testBundle, templateExtension: "text", encoding: String.Encoding.utf8)

        do {
            let _ = try repo.template(named: "notFound")
            XCTAssert(false)
        } catch {
        }

        template = try! repo.template(named: "TemplateRepositoryBundleTests")
        rendering = try! template.render()
        XCTAssertEqual(rendering, "TemplateRepositoryBundleTests.text TemplateRepositoryBundleTests_partial.text")

        template = try! repo.template(string: "{{>TemplateRepositoryBundleTests}}")
        rendering = try! template.render()
        XCTAssertEqual(rendering, "TemplateRepositoryBundleTests.text TemplateRepositoryBundleTests_partial.text")

        repo = TemplateRepository(bundle: testBundle, templateExtension: "", encoding: String.Encoding.utf8)

        do {
            let _ = try repo.template(named: "notFound")
            XCTAssert(false)
        } catch {
        }

        template = try! repo.template(named: "TemplateRepositoryBundleTests")
        rendering = try! template.render()
        XCTAssertEqual(rendering, "TemplateRepositoryBundleTests TemplateRepositoryBundleTests_partial")

        template = try! repo.template(string: "{{>TemplateRepositoryBundleTests}}")
        rendering = try! template.render()
        XCTAssertEqual(rendering, "TemplateRepositoryBundleTests TemplateRepositoryBundleTests_partial")
    }
}
