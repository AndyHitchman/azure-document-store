Feature: Put Document
  In order to have persistent documents in the Azure Document Store
  As an authenticated client
  I need to put documents into the store

  Background:
    Given I have a valid API key
    And the 'beer' container exists

  Scenario:
    Given the storage container 'beer' has no document at 'monteiths/goldenlager.json'
    When I put the local document 'beer/monteiths/goldenlager.json' at 'beer/monteiths/goldenlager.json'
    Then I should get a '201' response
    And the store should contain a document at 'beer/monteiths/goldenlager.json'
    And the document at 'beer/monteiths/goldenlager.json' should be identical to the local document 'beer/monteiths/goldenlager.json'

  Scenario:
    Given the storage container 'beer' has the local document 'beer/monteiths/goldenlager.json' of type 'text/json' at 'monteiths/goldenlager.json'
    And I do not specify access conditions
    When I put the local document 'landlord.json' at 'beer/monteiths/goldenlager.json'
    Then I should get a '405' response

