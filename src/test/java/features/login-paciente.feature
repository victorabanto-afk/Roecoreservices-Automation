Feature: Login Paciente v2 API

  Background:
    * url baseUrl
    * headers authHeader
    * header X-User-IP = '10.10.20.44'

  Scenario: Login de paciente exitoso
    Given path 'api', 'login', 'loginPaciente'
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
    * print '=== RESPUESTA LOGIN PACIENTE ===:', response

    # Validaciones de la respuesta
    And match response.codigoRespuesta == 2
    And match response.mensaje contains 'Exitoso'
    And match response.data.numeroDocumento == '00039311'
    And match response.data.nombres == 'LUIS'
    And match response.data.apellidoPaterno == 'VALDEZ'
    And match response.data.apellidoMaterno == 'VILLACORTA'
    And match response.data.nombreCompleto == 'LUIS VALDEZ VILLACORTA'
    And match response.data.correoElectronico == 'glvaldezs26@gmail.com'
    And match response.data.requiereCambioContrasena == true

    # Validacion del schema y tipos de datos
    And match response.data ==
      """
      {
        "tipoDocumento": '#number',
        "numeroDocumento": '#string',
        "codigoUnicoPaciente": '#number',
        "nombres": '#string',
        "apellidoPaterno": '#string',
        "apellidoMaterno": '#string',
        "apellidoCasada": '#string',
        "nombreCompleto": '#string',
        "edad": '#string',
        "genero": '#string',
        "correoElectronico": '#string',
        "fechaNacimiento": '#string',
        "requiereCambioContrasena": '#boolean',
        "puedeUsarCorreoMFA": '#boolean',
        "listPacienteTelefonoBE": '#[]'
      }
      """
    And match response.data.listPacienteTelefonoBE[0].telefono == '961908500'

  Scenario: Login de paciente con credenciales invalidas
    Given path 'api', 'login', 'loginPaciente'
    And request
      """
      {
        "usuario": "00039311",
        "clave": "clave_erronea",
        "TipoAutenticacion": 1
      }
      """
    When method post
    Then status 200
    And match response.codigoRespuesta != 2
