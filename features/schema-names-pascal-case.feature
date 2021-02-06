Feature: Schema names Must be written in PascalCase

  Background:
    Given the rule 'schema-names-pascal-case'

  Scenario: Schema name is written in PascalCase
    Given the OAS3 description document
    """
    openapi: 3.0.3
    components:
      schemas:
        PascalCaseComponent:
          type: object
    """
    When the OAS description document is linted
    Then there should be no errors

  Scenario Outline: Schemas name is not written in PascalCase
    Given the OAS3 description document
    """
    openapi: 3.0.3
    components:
      schemas:
        <component name>:
          type: object
    """
    When the OAS description document is linted
    Then the error message should be
    """
    component '<component name>' must be pascal case
    """

    Examples:
      | component name       |
      | camelCaseComponent   |
      | snake_case_component |
      | kebab-case-component |
