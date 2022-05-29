# 3-grupa-rolands-jankovskis-terraform-project repozitorijs

Terraform projekts ar VPC un EC2 moduļiem, priekš Nginx servera.

### VPC Modulis

VPC modulim pieskirts 192.168.0.0/16 subnets un 4 apakssubneti.
2 publiskie subneti [192.168.1.0/24;192.168.2.0/24] un 2 privāti subneti [192.168.3.0/24;192.168.4.0/24.] Publisko subnetu instancem pieskirt publisku ip adresi, bet privata subneta aiz NAT. Natam tiek pieskirts elastic ip.

Konfigureta security grupa piekļuvei uz 80 un 443 portiem, izejosais traffiks atlauts viss

### EC2 modulis

EC2 konfigurēta Ubuntu 20.04 instance ar pieasaistītu ssh atslēģu un sagatavotu skriptu nginx uzstādīšanai. Security grupa un tīklošana sasaistīta ar VPC moduli.

### Terraform palaišana

Terraform palaiz no .\services\$env\nginx-web-server direktorijas atlasot nepieciesamo environment [dev\prod\main]