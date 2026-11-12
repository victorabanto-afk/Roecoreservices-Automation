function fn() {
  var env = karate.env || 'preprod';
  karate.log('Ambiente:', env);

  // >>> COLOCA AQUÍ TU CONTRASEÑA REAL <<<

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

  // Login una sola vez por ejecución
  var auth = karate.callSingle('classpath:auth/login.feature', config);
  config.token = auth.token;
  config.refreshToken = auth.refreshToken;
  config.authHeader = { Authorization: 'Bearer ' + auth.token };

  karate.configure('connectTimeout', 10000);
  karate.configure('readTimeout', 30000);
  return config;
}