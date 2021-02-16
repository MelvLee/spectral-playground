Feature: Operation must have at least one `2xx` response

  Background:
    Given the rule 'operation-2xx-response'

  Scenario Outline: Operation has a `2xx` response
    Given the OAS3 description document
    """
    openapi: 3.0.3
    paths:
      /pets:
        get:
          responses:
            '<response>':
    """
    When the OAS description document is linted
    Then there should be no errors

    Examples:
        | response |
        | 200      |
        | 204      |

  Scenario Outline: Operation doesn't have a `2xx` response
    Given the OAS3 description document
    """
    openapi: 3.0.3
    paths:
      /pets:
        get:
          responses:
            '<response>':
    """
    When the OAS description document is linted
    Then the error message should be
    """
    Operation must have at least one `2xx` response.
    """

    Examples:
        | response |
        | 400      |
        | 500      |