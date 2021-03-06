## PURPOSE:

Sets up chocolately package provider on windows OS

## HIERA DATA:
```
global::repo_url: <repository url>

profile::chocolatey:
  repo_path: <URL path to Chocolately package on repo server>
  version: <Chocolately version to be installed>
```
## HIERA EXAMPLE:
```
  global::repo_url: "http://server.foo.bar"

  profile::chocolatey:
    repo_path: '/chocolatey/chocolatey.0.9.9.11.nupkg'
    version: '0.9.9.11'

```

## MODULE DEPENDENCIES:
```
puppet module install badgerious-windows_env
puppet module install chocolatey-chocolatey
puppet module install puppetlabs-powershell
```
## USAGE:

#### Puppetfile:
```
mod "badgerious-windows_env", '2.2.2'
mod "chocolatey-chocolatey",  '1.2.1'
mod "puppetlabs-powershell", '1.0.6'

mod 'validation_script',
  :git => 'https://github.com/firechiefs/validation_script',
  :ref => '1.0.0'

mod 'profile_chocolatey',
  :git => 'https://github.com/firechiefs/profile_chocolatey',
  :ref => '1.0.0'
```
#### Manifests:
```
class role::*rolename* {
  include profile_chocolatey
}
```
