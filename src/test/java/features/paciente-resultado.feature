Feature: Consulta de Resultados de Paciente v3

  Background:
    * url baseUrl
    * headers authHeaderPaciente
    * header X-User-IP = '10.10.20.44'

  Scenario: Consultar resultados de paciente exitoso
    Given path 'api', 'resultado', 'pacienteResultadoCabeceraConsulta_v3'
    And request
      """
      {
        "numeroPagina": 1,
        "cantidadRegistros": 12,
        "fechaInicio": "2021-03-10",
        "fechaFin": "2026-09-11",
        "idIngreso": null,
        "campoBusqueda1": null,
        "data": {
          "codigoUnico": 151680,
          "resulSetIndex": ",1,2,3,4",
          "separadorAnalisis": ";"
        }
      }
      """
    When method post
    Then status 200
    * print '=== RESPUESTA RESULTADO PACIENTE ===:', response

    # Validaciones basicas
    And match response.codigoRespuesta == 1
    And match response.descripcionRespuesta == '¡Exitoso!'
    And match response.mensaje contains 'Listado de atenciones exitoso'

    # Validaciones de paginacion
    And match response.paginacion.paginaActual == 1
    And assert response.paginacion.totalPaginas > 0
    And assert response.paginacion.totalRegistros > 0

    # Validar que existan ordenes en la lista
    And match response.data.codigoRespuesta == 0
    And match response.data.detalleOrdenes == '#[]'
    * def primerOrden = response.data.detalleOrdenes[0]
    And assert primerOrden != null
    And match primerOrden.ordenAtencion == '#string'
    And match primerOrden.codigoMedico == '#string'
    And match primerOrden.nombreCompletoMedico == '#string'
    And match primerOrden.puedeVerResultados == '#boolean'
    And match primerOrden.estadoPago.id == '#number'
    And match primerOrden.estadoPago.nombre == '#string'

    # Validacion de esquema
    And match response.data ==
      """
      {
        "codigoRespuesta": '#number',
        "detalleOrdenes": '#[]',
        "detalleVacunas": '#[]'
      }
      """
