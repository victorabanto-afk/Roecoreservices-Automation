Feature: Consentimiento API

  Background:
    * url baseUrl
    * headers authHeader
    * header X-User-IP = '10.10.20.44'

  Scenario: Consultar consentimiento por paciente exitoso
    Given path 'api', 'consentimiento', 'consultar-por-paciente'
    And param idPaciente = 3807073
    When method get
    Then status 200
    * print '=== RESPUESTA CONSENTIMIENTO ===:', response