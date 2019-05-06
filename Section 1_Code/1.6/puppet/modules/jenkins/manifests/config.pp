class jenkins::config {
    file { 'groovy_script_directory':
        path   => '/var/lib/jenkins/init.groovy.d',
        owner  => 'jenkins',
        group  => 'jenkins',
        mode   => '0755',
        ensure => directory
    }

    file { 'security_groovy_script':
        path    => '/var/lib/jenkins/init.groovy.d/security.groovy',
        owner   => 'jenkins',
        group   => 'jenkins',
        source  => 'puppet:///modules/jenkins/security.groovy',
        mode    => '0644',
        require => File['groovy_script_directory']
    }

    file { 'plugins_groovy_script':
        path    => '/var/lib/jenkins/init.groovy.d/installPlugins.groovy',
        owner   => 'jenkins',
        group   => 'jenkins',
        source  => 'puppet:///modules/jenkins/installPlugins.groovy',
        mode    => '0644',
        require => File['groovy_script_directory']
    }

    file { 'nginx_config_jenkins':
        path   => '/etc/nginx/conf.d/jenkins.conf',
        owner  => 'root',
        group  => 'root',
        source => 'puppet:///modules/jenkins/jenkins.conf',
        mode   => '0644'
    }

    file { 'nginx_config':
        path   => '/etc/nginx/nginx.conf',
        owner  => 'root',
        group  => 'root',
        source => 'puppet:///modules/jenkins/nginx.conf',
        mode   => '0644'
    }

    file { 'jenkins_sysconfig':
        path   => '/etc/sysconfig/jenkins',
        owner  => 'root',
        group  => 'root',
        source => 'puppet:///modules/jenkins/jenkins',
        mode   => '0644'
    }
}
