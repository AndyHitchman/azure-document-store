Feature: Security
  In order to obtain authorised access to the store
  As a client
  I need to provide an API key on all requests

  Background:
    Given the 'beer' container exists
    And the service has an account against API key 'superdupersecretkey'

  Scenario: No API Key
    Given I have no API key header on my request
    When I request the document 'beer/nevergoingtoexist'
    Then I should get a '401' response

  Scenario: Invalid API Key
    Given I have an API key 'thisiscompleterubbish' header on my request
    When I request the document 'beer/nevergoingtoexist'
    Then I should get a '401' response

  Scenario: Valid API Key
    Given I have an API key 'superdupersecretkey' header on my request
    When I request the document 'beer/nevergoingtoexist'
    Then I should get a '404' response
