if versioncmp($::puppetversion,'3.6.1') >= 0 {
    $allow_virtual_packages = hiera('allow_virtual_packages',false)
    Package {
    allow_virtual => $allow_virtual_packages,
    }
}
#########
node web01 {
    include pckgsextra
    include proyecto
}
node mem01 {
    include pckgsextra
    include pckgmemcached
}
node /^app0[0-9]/ {
    include pckgsextra
    include pckgsextraCompile
    include appsrv
}
class pckgsextraCompile {
    #'openvpn',
    package { [ 'git', 'ant','java-1.7.0-openjdk-devel', 'java-1.7.0-openjdk'] :
        ensure  => present,
    }
}
class pckgsextra{
    package { ['tar', 'nmap', 'telnet', 'nano'] :
        ensure  => present,
    }
    file { '/etc/hosts':
        ensure  => file,
        owner => root,
        group => root,
        mode  => 644,
        content => "
        192.168.100.14 dbase.local.com
        192.168.100.13 cache.local.com
        192.168.100.12 app02.local.com
        192.168.100.11 app01.local.com
        192.168.100.10 www.proyecto.local.com
        ",
    }
    file { '/etc/environment':
        ensure  => file,
        owner => root,
        group => root,
        mode  => 644,
        content => "
        LANG=es_MX.utf-8
        LC_ALL=es_MX.utf-8",
    }
    
}
######*****Instalación de Memcached*****************#####################################
class pckgmemcached {
    class { 'memcached': }
}
class networking {

}
class usuariosRequeridos {
    user { "nginx":
        ensure     => present,
        gid        => "nginx",
        groups     => ["vagrant","apache"],
         # For the user to exist
        require => [Group['nginx'],Group['vagrant']]
    }
    user { "vagrant":
        ensure     => present,
        gid        => "vagrant",
        groups     => ["vagrant","nginx","apache"],
        require => [Group['nginx'],Group['vagrant'],Group['apache']]
    }
    group {"nginx":
        ensure     => present,
    }
    group {"vagrant":
        ensure     => present,
    }
    group {"apache":
        ensure     => present,
    }
}
class websrv {
    class { 'nginx': sendfile => off } #moved to hiera.yaml
    #Servidores de aplicacion
    nginx::resource::upstream { 'puppet_rack_app':
          members => [
            'app02.local.com:9001',
            'app01.local.com:9001'
          ]
    }
    include usuariosRequeridos
}
#############================#############

class appsrv {
    require yum::repo::remi
    require yum::repo::epel
    require yum::repo::remi_php56
    # For the user to exist
    include usuariosRequeridos
    package { 'libtidy':
        ensure  => present,
    }
    package { 'libtidy-devel':
        ensure  => present,
    }
    package { 'php-tidy':
        ensure  => present,
    }
    class { php::fpm::daemon:
        log_owner => 'nginx',
        log_group => 'nginx',
        log_dir_mode => '0775',
    }
    php::fpm::conf { 'www':
        listen                  => '9001',
        listen_allowed_clients  => '192.168.100.10',
        user                    => 'nginx',
    }
    php::module { [ 'pecl-apcu',
        'pear',
        'pdo',
        'mysqlnd',
        'pgsql',
        'pecl-mongo',
        'pecl-sqlite',
        'mbstring',
        'mcrypt',
        'xml',
        'php-devel',
        'pecl-memcached',
        'gd',
        'soap']:
        notify  => Service['php-fpm'],
    }
    php::ini { '/etc/php.ini':
        short_open_tag              => 'On',
        asp_tags                    => 'Off',
        date_timezone               => 'America/Mexico_City',
        error_reporting             => 'E_ALL & ~E_DEPRECATED',
        display_errors              => 'On',
        html_errors                 => 'On',
        session_cookie_secure       => '1',
        session_save_handler        => 'memcached',
        session_save_path           => '192.168.100.13:11211',
        notify  => Service['php-fpm'],
    }
    file { '/var/log/php-fpm/www-error.log':
        ensure => "file",
        owner  => "nginx",
        group  => "nginx",
        mode   => 777
    }
    file { '/var/log/php-fpm/error.log':
        ensure => "file",
        owner  => "nginx",
        group  => "nginx",
        mode   => 777,
    }
}
#############================#############

class proyecto {
    require websrv
    
    nginx::resource::vhost { 'www.proyecto.local.com':
        www_root                => '/www/www.proyecto.local.com/public',
        ssl                     => true,
        ssl_cert                => '/vagrant/puppet/certs/server.crt',
        ssl_key                 => '/vagrant/puppet/certs/server.key',
        index_files             => [ 'index.php' ],
        use_default_location    => true,
        location_cfg_append     => { 
            try_files => '$uri $uri/ /index.php$is_args$args'
        }
    }
    nginx::resource::location { "www.proyecto.local.com":
        ensure          => present,
        ssl              => true,
        vhost           => 'www.proyecto.local.com',
        www_root        => '/www/www.proyecto.local.com/public',
        location        => '~ \.php$',
        index_files     => ['index.php'],
        proxy           => undef,
        fastcgi         => "puppet_rack_app",
        fastcgi_script  => undef,
        location_cfg_append => { 
            fastcgi_connect_timeout => '5h',
            fastcgi_read_timeout    => '5h',
            fastcgi_send_timeout    => '5h',
            fastcgi_param    => "APPLICATION_ENV 'development'"
        }
    }
}