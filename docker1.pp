package { 'docker':
ensure => present,
}
service { 'docker':
ensure => running,
require => Package['docker'],
}
exec { 'rm':
command => '/bin/docker rm -f $(sudo docker ps -a -q)',
}
exec { 'build':
command => '/bin/docker build /etc/puppet/manifests -t website',
require => Exec['rm']
}
exec { 'run':
command => '/bin/docker run -it -d -p 82:80 -d website',
}

