# PURPOSE:
# sets up chocolately package provider on windows OS
#
# HIERA DATA:
#  repo_path: URL path to Chocolately package on repo server
#  version = Chocolately version to be installed
#
# HIERA EXAMPLE:
# profile::chocolatey:
#   repo_path: '/Install/packages/windows/chocolatey/chocolatey.0.9.9.11.nupkg'
#   version: '0.9.9.11'
#
# DEPENDENCIES:
# puppet module install badgerious-windows_env
# puppet module install chocolatey-chocolatey
# puppet module install puppetlabs-powershell

class profile_chocolatey {
  # profile_dotnet requirement for chocolatey
  require profile_dotnet

  # HIERA LOOKUP:
  # --> PUPPET CODE VARIABLES:
  # URL of repository server
  $repo_url            = hiera('global::repo_url')
  # hash of chocolatey settings
  $chocolatey          = hiera('profile::chocolatey')
  $chocolatey_path     = $chocolatey[repo_path] # repo path to installer
  $chocolatey_version  = $chocolatey[version] # version to install

  # HIERA LOOKUP VALIDATION:
  validate_string($repo_url)
  validate_hash($chocolatey)

  # PUPPET CODE:
  # installs chocolatey package
  class {'chocolatey':
    chocolatey_download_url => "${repo_url}${chocolatey_path}",
    use_7zip                => false,
  }

  # VALIDATION CODE:
  # --> MODIFY VARIABLES BELOW:
  $profile_name    = 'profile_chocolatey'         # set to profile name
  $validation_data = $chocolatey_version # set to data you'd like to validate

  # Puppet custom define type
  # documented in: site/validation_script/manifests/init.pp
  # DO NOT MODIFY BELOW !!!
  validation_script { $profile_name:
    profile_name    => $profile_name,
    validation_data => $validation_data,
  }

}
