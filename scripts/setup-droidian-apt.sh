{{- $architecture := or .architecture "arm64" -}}
{{- $suite := "trixie" -}}
{{- $use_internal_repository := or .use_internal_repository "no" -}}

architecture: {{ $architecture }}
actions:

- action: debootstrap
    suite: rolling
    components:
      - main
    keyring-file: ../apt/etc/apt/trusted.gpg.d/droidian-bootstrap.gpg
    mirror: http://releases.droidian.org/snapshots/current
    variant: minbase

  - action: overlay
    source: ../apt
    description: Adding apt overlay
    destination: /

  - action: apt
    chroot: true
    description: install apt config
    update: true
    packages:
      - ca-certificates
      - droidian-apt-config
      - droidian-archive-keyring
      - mobian-droidian-archive-keyring
