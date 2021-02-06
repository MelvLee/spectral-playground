Feature: Text MUST be printable ASCII or diacritics 

  Background:
    Given the rule 'text-printable-ascii-diacritics'

  Scenario Outline: supported characters in description field
    Given the OAS3 description document
    """
    openapi: 3.0.3
    components:
      schemas:
        Component1:
          type: object
          description: <text>
    """
    When the OAS description document is linted
    Then there should be no errors

    Examples:
        | text                       | description          |
        | " "                        | white space          |
        | "!#$%&'()*+,-/."           |                      |
        | "0123456789"               | numbers              |
        | ":;<=>?@"                  |                      |
        | ABCDEFGHIJKLMNOPQRSTUVWXYZ | upper case letters   |
        | "[]^_`"                    |                      |
        | abcdefghijklmnopqrstuvwxyz | lower case letters   |
        | "{\|}~"                    |                      |
        | áéíóúäëïöüàèìòùñç          | supported diacritics |

  Scenario Outline: supported characters in CommonMark syntax in description field
    Given the OAS3 description document
    """
    openapi: 3.0.3
    components:
      schemas:
        Component1:
          type: object
          description: |
            <text>
    """
    When the OAS description document is linted
    Then there should be no errors
    Examples:
        | text                       | description        |
        | " "                        | white space        |
        | ABCDEFGHIJKLMNOPQRSTUVWXYZ | upper case letters |

  Scenario Outline: supported characters in title field
    Given the OAS3 description document
    """
    openapi: 3.0.3
    info:
      title: <text>
    """
    When the OAS description document is linted
    Then there should be no errors

    Examples:
        | text                       | description        |
        | " "                        | white space        |
        | ABCDEFGHIJKLMNOPQRSTUVWXYZ | upper case letters |

  Scenario Outline: supported characters in summary field
    Given the OAS3 description document
    """
    openapi: 3.0.3
    paths:
      /resources:
        summary: <text>
    """
    When the OAS description document is linted
    Then there should be no errors

    Examples:
        | text                       | description        |
        | " "                        | white space        |
        | ABCDEFGHIJKLMNOPQRSTUVWXYZ | upper case letters |

  Scenario Outline: unsupported characters in description field
    Given the OAS3 description document
    """
    openapi: 3.0.3
    components:
      schemas:
        Component1:
          type: object
          description: <text>
    """
    When the OAS description document is linted
    Then the error message should be
    """
    description: '<text>' must match the pattern <pattern>
    """

    Examples:
        | text | pattern                        |
        | ©    | '^[\s!-/0-9:-@A-Z[-`a-z{-~áéíóúäëïöüàèìòùñç]+$' |

  Scenario Outline: unsupported characters in CommonMark syntax in description field
    Given the OAS3 description document
    """
    openapi: 3.0.3
    components:
      schemas:
        Component1:
          type: object
          description: |
            <text>
    """
    When the OAS description document is linted
    Then the error message should be
    """
    description: '<text>
    ' must match the pattern <pattern>
    """

    Examples:
        | text | pattern                        |
        | ©    | '^[\s!-/0-9:-@A-Z[-`a-z{-~áéíóúäëïöüàèìòùñç]+$' |

  Scenario Outline: unsupported characters in title field
    Given the OAS3 description document
    """
    openapi: 3.0.3
    info:
      title: <text>
    """
    When the OAS description document is linted
    Then the error message should be
    """
    title: '<text>' must match the pattern <pattern>
    """

    Examples:
        | text | pattern                        |
        | ©    | '^[\s!-/0-9:-@A-Z[-`a-z{-~áéíóúäëïöüàèìòùñç]+$' |

  Scenario Outline: unsupported characters in summary field
    Given the OAS3 description document
    """
    openapi: 3.0.3
    paths:
      /resources:
        summary: <text>
    """
    When the OAS description document is linted
    Then the error message should be
    """
    summary: '<text>' must match the pattern <pattern>
    """

    Examples:
        | text | pattern                        |
        | ©    | '^[\s!-/0-9:-@A-Z[-`a-z{-~áéíóúäëïöüàèìòùñç]+$' |
