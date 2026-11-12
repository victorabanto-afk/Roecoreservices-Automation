Feature: Ejemplo de endpoint protegido

  Background:
    * url baseUrl
    * headers authHeader

  # Cambia la ruta por un endpoint real y quita @ignore
  @ignore
  Scenario: Consumir endpoint con token
    Given path 'api', 'modulo', 'recurso'
    When method get
    Then status 200
