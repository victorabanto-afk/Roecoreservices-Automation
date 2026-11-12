Feature: Login API

  Background:
    * url baseUrl
    * path 'api', 'security', 'login'

    Scenario: Login exitoso
    Given request { auth_user: '#(authUser)', auth_password: '#(authPassword)' }
    When method post
    Then status 200
    * print '=== TOKEN RECUPERADO ===:', response.access_token

  Scenario: Login con credenciales invalidas
    Given request { auth_user: '#(authUser)', auth_password: 'incorrecta' }
    When method post
    Then assert responseStatus == 400 || responseStatus == 401