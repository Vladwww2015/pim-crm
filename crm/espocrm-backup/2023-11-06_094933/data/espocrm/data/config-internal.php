<?php
return [
  'database' => [
    'host' => 'espocrm-db',
    'port' => '',
    'charset' => NULL,
    'dbname' => 'espocrm',
    'user' => 'espocrm',
    'password' => 'cf4b654f0f2fc9bcc648',
    'driver' => 'pdo_mysql',
    'platform' => 'Mysql'
  ],
  'smtpPassword' => NULL,
  'logger' => [
    'path' => 'data/logs/espo.log',
    'level' => 'WARNING',
    'rotation' => true,
    'maxFileNumber' => 30,
    'printTrace' => false
  ],
  'restrictedMode' => false,
  'webSocketMessager' => 'ZeroMQ',
  'clientSecurityHeadersDisabled' => false,
  'clientCspDisabled' => false,
  'clientCspScriptSourceList' => [
    0 => 'https://maps.googleapis.com'
  ],
  'isInstalled' => true,
  'microtimeInternal' => 1699281776.492693,
  'passwordSalt' => '6907380809dc21d0',
  'cryptKey' => '488376843add94b9192f63cc5d1d1470',
  'hashSecretKey' => 'f6ef321978755e81582145da61f18ef6',
  'defaultPermissions' => [
    'user' => 'www-data',
    'group' => 'www-data'
  ],
  'actualDatabaseType' => 'mariadb',
  'actualDatabaseVersion' => '11.1.2',
  'webSocketZeroMQSubmissionDsn' => 'tcp://espocrm-websocket:7777',
  'webSocketZeroMQSubscriberDsn' => 'tcp://*:7777'
];
