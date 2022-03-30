class mymodule {

### Script Files Directory 

file { '/opt/pacoquinha-app':
	ensure => directory,
	owner => 'root',
	group => 'root',
}

### Get from Server Paçoquinha-app Script 

file { "/opt/pacoquinha-app/pacoquinha-APP.sh":
	mode => "0755",
	owner => 'root',
	group => 'root',
	source => 'puppet:///modules/mymodule/pacoquinha-APP.sh',
}

### Get from Server Paçoquinha-backup Script

file { "/usr/local/bin/pacoquinha-backup.sh":
	mode => "0755",
	owner => 'root',
	group => 'root',
	source => 'puppet:///modules/mymodule/pacoquinha-backup.sh',
}

### Get from Server Paçoquinha-manager Script

file { "/usr/local/bin/pacoquinha-manager.sh":
	mode => "0755",
	owner => 'root',
	group => 'root',
	source => 'puppet:///modules/mymodule/pacoquinha-manager.sh',
}

### Script Management 

#execute service
	service { 'pacoquinha-manager.sh':
	ensure    => 'running',
	hasstatus => true,
	start     => '/usr/local/bin/pacoquinha-manager.sh start',
	stop      => '/usr/local/bin/pacoquinha-manager.sh stop',
	status    => '/usr/sbin/service pacoquinha-app.service status',
}

### Cron Management 

file { 'pacoquinha-backup.sh':
	path    => "/usr/bin/pacoquinha-backup.sh",
	content => "#!/usr/bin/bash\necho hello world",
}

cron { 'pacoquinha-backup.sh':
	ensure  => present,
	command => "/usr/local/bin/pacoquinha-backup.sh &",
	user    => root,
	hour    => '15',
	minute  => '30',
	require => File['pacoquinha-backup.sh'],
}

}
