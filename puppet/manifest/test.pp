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