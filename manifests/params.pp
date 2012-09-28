class postfix::params {

  # non OS specific options
  $postfix_smtp_listen = '127.0.0.1'
  $root_mail_recipient = 'nobody'
  $postfix_use_amavisd = 'no'
  $postfix_use_dovecot_lda = 'no'
  $postfix_use_schleuder = 'no'
  $postfix_use_sympa = 'no'
  $postfix_mail_user = 'vmail'

  case $::operatingsystem {
    redhat, centos: {
      
      $master_os_template = template('postfix/master.cf.redhat.erb', 'postfix/master.cf.common.erb')
      $mailx_package = 'mailx'
      
      case $::lsbmajdistrelease {
        '4':     { $postfix_seltype = 'etc_t' }
        '5','6': {
          $postfix_seltype = 'postfix_etc_t'
          $postfix_aliases_seltype = 'etc_aliases_t'
        }
        default: { $postfix_seltype = undef }
      }
    }
    debian, ubuntu, kfreebsd: {
      $postfix_seltype = undef
      $postfix_aliases_seltype = undef
      $master_os_template = template('postfix/master.cf.debian.erb', 'postfix/master.cf.common.erb')
      $mailx_package = $::lsbdistcodename ? {
        'squeeze' => 'bsd-mailx',
        'lucid'   => 'bsd-mailx',
      }
    }
    default: {
      $postfix_aliases_seltype = undef
      $postfix_seltype = undef
      $mailx_package = 'mailx'
    }
  }
}
