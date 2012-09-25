Feature: Get Document
  In order to use persistent documents in the Azure Document Store
  As an authenticated client
  I need to get documents from the store

  Background:
    Given I have a valid API key
    And the 'beer' container exists

  Scenario:
    Given the storage container 'beer' has the local document 'beer/timothytaylor/landlord.json' of type 'text/json' at 'timothytaylor/landlord.json'
    When I request the document 'beer/timothytaylor/landlord.json'
    Then I should get a '200' response

  Scenario:
    Given the storage container 'beer' has the local document 'beer/timothytaylor/landlord.json' of type 'text/json' at 'timothytaylor/landlord.json'
    And I add an 'If-None-Match' access condition to my request based on the actual etag of document 'timothytaylor/landlord.json' in container 'beer'
    When I request the document 'beer/timothytaylor/landlord.json'
    Then I should get a '412' response

  Scenario:
    Given the storage container 'beer' has no document at 'timothytaylor/ramtam.json'
    When I request the document 'beer/timothytaylor/landlord.json'
    Then I should get a '404' response
