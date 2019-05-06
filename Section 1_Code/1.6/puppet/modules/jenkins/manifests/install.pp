class jenkins::install {
    file { 'jenkins_repo':
        path   => '/etc/yum.repos.d/jenkins.repo',
        source => 'https://pkg.jenkins.io/redhat-stable/jenkins.repo',
        ensure => present,
        mode   => '0644'
    }

    exec { 'jenkins_repo_key':
        command   => '/bin/rpm --import https://pkg.jenkins.io/redhat-stable/jenkins.io.key',
        unless    => '/bin/rpm -q jenkins',
        subscribe => File['jenkins_repo'],
        require   => File['jenkins_repo']
    }

    package { 'epel-repo':
        name   => 'epel-release',
        ensure => present,
        source => 'https://dl.fedoraproject.org/pub/epel/7/x86_64/Packages/e/epel-release-7-11.noarch.rpm'
    }

    $packages = [ 'jenkins', 'java-1.8.0-openjdk', 'nginx', 'git' ]

    package { $packages:
        ensure    => present,
        require   => [ File['jenkins_repo'], Package['epel-repo'] ]
    }
}
