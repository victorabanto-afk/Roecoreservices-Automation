@ignore
Feature: Login reutilizable

  Scenario: Obtener token
    Given url baseUrl
    And path 'api', 'security', 'login'
    And request
      """
      {
        "auth_user": "#(authUser)",
        "auth_password": "#(authPassword)"
      }
      """
    When method post
    Then status 200
    And match response.access_token == '#string'

    * def token = response.access_token
    * def refreshToken = response.refresh_token
    * def expiration = response.expiration
    * def role = response.role
