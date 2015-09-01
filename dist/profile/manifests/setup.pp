class profile::setup {

  if $::osfamily == 'RedHat' {
    #include ::yum
    #realize(Yum::Repo['puppet', 'puppet_deps'])

    resources {'yumrepo':
      purge => true,
    }
    class {'epel':
      epel_mirrorlist => 'absent',
      epel_baseurl    => 'http://16.0.96.20:3142/epel.mirrors.ovh.net/epel/$releasever/$basearch'
    }

    yumrepo { 'centos-base':
      baseurl        => 'http://16.0.96.20:3142/centos.mirrors.ovh.net/ftp.centos.org/$releasever/os/$basearch',
      gpgkey         => "gpgkey=file:///etc/pki/rpm-gpg/RPM-GPG-KEY-CentOS-${facts['operatingsystemmajrelease']}",
      descr          => 'CentOS-$releasever - Base',
    }
  }

  user {'root':
    ensure         => 'present',
    uid            => '0',
    gid            => '0',
    purge_ssh_keys => true,
    home           => '/root',
  }
}
