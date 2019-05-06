class jenkins::service {
    service { 'jenkins':
        ensure => running
    }

    service { 'nginx':
        ensure => running
    }
}
