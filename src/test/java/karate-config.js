function fn() {
  var env = karate.env || 'preprod';
  karate.log('Ambiente:', env);

  var authUser = java.lang.System.getenv('AUTH_USER') 
                 || karate.properties['authUser'] 
                 || 'RWBLAB_TEST';

  var authPassword = java.lang.System.getenv('AUTH_PASSWORD') 
                     || karate.properties['authPassword'] 
                     || 'F9$kP2nL7@sY3!rM8';

  var config = {
    baseUrl: 'https://ww2test.labroe.com/roecoreservices_preprod_digital',
    authUser: authUser,
    authPassword: authPassword
  };

  // 1. Login Core una sola vez por ejecucion
  var auth = karate.callSingle('classpath:auth/login.feature', config);
  config.token = auth.token;
  config.refreshToken = auth.refreshToken;
  config.authHeader = { Authorization: 'Bearer ' + auth.token };

  // 2. Login Paciente una sola vez por ejecucion (almacena Authorization-Token-Login bajo la misma metodologia)
  var authPac = karate.callSingle('classpath:auth/login-paciente.feature', config);
  config.tokenPaciente = authPac.tokenPaciente;
  config.authHeaderPaciente = { Authorization: 'Bearer ' + authPac.tokenPaciente };

  karate.configure('connectTimeout', 10000);
  karate.configure('readTimeout', 30000);
  return config;
}
