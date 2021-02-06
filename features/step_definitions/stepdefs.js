const { Given, When, Then } = require('@cucumber/cucumber');
const { Spectral, Document, Parsers, isOpenApiv3 } = require('@stoplight/spectral');
const { join } = require('path');
const should = require('chai').should();

Given('the rule {string}', function(rule) {
    this.rule = rule;
});

Given('the OAS3 description document', function(oas3Document) {
    this.document = new Document(oas3Document, Parsers.Yaml);
});

When('the OAS description document is linted', async function() {
    const spectral = new Spectral();
    spectral.registerFormat('oas3', isOpenApiv3);
    await spectral.loadRuleset([
        join(__dirname, '../../spectral_rules/' + this.rule + '.yaml')
    ]);
    this.results = await spectral.run(this.document);
});

Then('there should be no errors', function() {
    this.results.should.have.lengthOf(0, JSON.stringify(this.results, null, "\t"));
});

Then('the error message should be', function(expected) {
    this.results.should.have.lengthOf(1, JSON.stringify(this.results, null, "\t"));
    this.results[0].code.should.equal(this.rule, JSON.stringify(this.results, null, "\t"));
    this.results[0].message.should.equal(expected, JSON.stringify(this.results, null, "\t"));
});