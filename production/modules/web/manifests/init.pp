class web {

	case $::osfamily{

                "RedHat":{
                        $pacotes = ["httpd"]
			service {'firewalld':
				ensure => stopped,
				enable => false
			}
                }

                "Debian":{
                        $pacotes = ["apache2"]
			exec{'atualizando_repo':
				command => "/usr/bin/apt update"
			}
                }
        }

        package{$pacotes:
                ensure => present
                }

	service{$pacotes:
		ensure => running
		}

        file{"/var/www/html/index.html":
                source => "puppet:///modules/web/index.html",
                ensure => present
        }
}
