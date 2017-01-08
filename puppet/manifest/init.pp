if versioncmp($::puppetversion,'3.6.1') >= 0 {
    $allow_virtual_packages = hiera('allow_virtual_packages',false)
    Package {
    allow_virtual => $allow_virtual_packages,
    }
}
#########
node web {
    include pckgsextra
}
class pckgsextra{
    package { ['git','ant','openvpn' , 'tar', 'telnet', 'java-1.7.0-openjdk-devel', 'java-1.7.0-openjdk', 'nano'] :
        ensure  => present,
    }
}