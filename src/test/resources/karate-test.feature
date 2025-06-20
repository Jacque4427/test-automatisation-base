Feature: Test de API súper simple

  Background:
    * configure ssl = true
    * def username = 'testuser'
    * def urlBase = `http://bp-se-test-cabcd9b246a5.herokuapp.com/${username}/api/characters`
    * def personajeId = 39

  Scenario: T-API-Marvel-API-CA1- Obtener todos los personajes con response 200
    * header content-type = 'application/json'
    Given url urlBase
    When method GET
    Then status 200
    And print response

  Scenario: T-API-Marvel-API-CA2- Crear nuevo personaje con response 200
    * header content-type = 'application/json'
    Given url urlBase
    And def personajeBody = read('classpath:../personajeData.json')
    And request personajeBody
    When method POST
    Then status 201
    And print response

  Scenario Outline: T-API-Marvel-API-CA3- Actualizar personaje con response 200
    * header content-type = 'application/json'
    Given url `${urlBase}/${personajeId}`
    And def personajeBody = read('classpath:../personajeData.json')
    And set personajeBody.name = <new_name>
    And request personajeBody
    When method PUT
    Then status 200
    And print response
    Examples:
      | new_name |
      | 'Carmita' |

  Scenario: T-API-Marvel-API-CA4- Delete personaje con response 200
    * header content-type = 'application/json'
    Given url `${urlBase}/${personajeId}`
    When method DELETE
    Then status 204
    And print response
