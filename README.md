
# 3-grupa-rolands-jankovskis-ansible-project

3. grupa Rolands Jankovskis 5MD ansible projekts - haproxy. Plānots izveidot terraform struktūru instancēm un ansible playbookus mājasdarba izpildei un haproxy uzstādīšanai
  

## Teraform daļa
  

Terraform projekts sagatavots ar VPC un EC2 moduļiem root direktorijā, automatizētai ansible projekta startēšanai gatavā saderīga infrastruktūra.
  

### VPC Modulis
  

VPC modulim pieskirts 192.168.0.0/16 subnets un 2 publiskie apakssubneti [192.168.1.0/24;192.168.2.0/24] Publisko subnetu instancem tiek pieskirta publiska ip adrese. Konfigureta security grupa piekļuvei uz 80 un 443 portiem, izejosais traffiks atlauts viss, ieksejais VPC traffiks atļauts VISS, kā arī SSH piekļuve atļauta no provaidera subneta.
  

### EC2 modulis
  

EC2 konfigurētas 3 Ubuntu 20.04 instances ar pieasaistītu ssh atslēgu. Master instance ir piegatavots shell skripts hostname nomaiņai un ansible uzstādīšanai. Host instancēm (2) ir pievienoti skripti atkarībā no instances vārda kur tiek uzstādīts pareizais hostname. Security grupa un tīklošana sasaistīta ar VPC moduli. Master ansible instancē tiek instalēta privātā atslēga no .assets\secrets\secret-key.pem un host ansible instamcēm tiek instalēta master publiskā atslēga no .\assets\secrets\public-key.pub. EC2 pievienots template lai automatiski veidotos ansible hosts fails, kas tiek instalēts master instancē. EC2 startēs ansible playbook lu-vumc-devops.ansible-ubuntu uz host1.


### Terraform palaišana


Terraform palaiz no root direktorijas ar terraform.tfvars. Terraform izveidos infrastruktūru un startēs ansible playbooku veidojot weblapu uz host1.
