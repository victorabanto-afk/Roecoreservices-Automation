@ignore
Feature: Login Paciente reutilizable

  Scenario: Obtener token de paciente
    Given url baseUrl
    And headers authHeader
    And header X-User-IP = '10.10.20.44'
    And path 'api', 'login', 'loginPaciente'
    And request
      """
      {
        "usuario": "00039311",
        "clave": "00039311",
        "TipoAutenticacion": 1
      }
      """
    When method post
    Then status 200
    And match response.codigoRespuesta == 2

    # Extraer el header Authorization-Token-Login devuelto por el servidor
    * def authList = karate.get("responseHeaders['Authorization-Token-Login']") || karate.get("responseHeaders['authorization-token-login']")
    * def tokenPaciente = authList ? authList[0] : null
    * print '=== TOKEN PACIENTE ALMACENADO (karate-config) ===:', tokenPaciente
