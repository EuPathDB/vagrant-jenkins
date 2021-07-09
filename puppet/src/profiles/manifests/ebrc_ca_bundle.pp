# install EuPathDB BRC's Certificate Authority to filesystem and add to
# system CA bundle using ca-certificates utilities.
# Hiera
#
#  The following hiera data should be set for use by the underlying
#  modules. Defaults are set in common.yaml
#  - ebrc_ca::cacert - filename of certificate
class profiles::ebrc_ca_bundle {

  $ca_name = lookup('ebrc_ca::cacert', String)

  ca::trust::add { $ca_name:
    source => "puppet:///modules/profiles/ssl/${ca_name}",
  }

  file { "/etc/pki/tls/certs/${ca_name}":
    ensure => file,
    source => "puppet:///modules/profiles/ssl/${ca_name}",
    owner  => 'root',
    group  => 'root',
    mode   => '0644',
  }

}
