# CentOS7 から AlmaLinux8へのアップグレード

ELevateのクイックスタートガイド

https://wiki.almalinux.org/elevate/ELevate-quickstart-guide.html

## 手順

### elevate-releaseパッケージのインストール

sudo yum install -y http://repo.almalinux.org/elevate/elevate-release-latest-el$(rpm --eval %rhel).noarch.rpm

### leappパッケージのインストール

インストールするOSに応じて変わる

sudo yum install -y leapp-upgrade leapp-data-almalinux

### leappを使ってプリアップデートチェック

sudo leapp preupgrade

レポートが/var/log/leapp/leapp-report.txtに作成される


初回はpreupgradeが失敗する。

/var/log/leapp/answerfileが作成されて回答が必要

###  アップグレード実行前の作業

sudo rmmod pata_acpi
echo PermitRootLogin yes | sudo tee -a /etc/ssh/sshd_config
sudo leapp answer --section remove_pam_pkcs11_module_check.confirm=True

他、leapp-report.txtでinhibitor表示の内容を対処

### アップグレード実行
sudo leapp upgrade
sudo reboot