# onpremise-to-aws-with-terraform
on premise 3-tier 환경에서 AWS Cloud 환경으로 Migration을 하는데 Terraform을 활용하여 진행함
migration 작업은 빈번하게 일어나는 작업이 아니므로 Terraform을 통하여 AWS 환경을 만드는 것을 자동화 할 필요는 굳이 없다고 생각하지만, 학습 차원에서 Terraform도 곁들여서 진행해보았다.
Terraform code는 두 개의 폴더로 나누어진다. migration을 하기 전에 실행하는 code와 migration을 진행한 후에 실행하는 code가 있다.
code를 두 개로 분리한 이유는 migration을 할 AWS 환경을 미리 만들어놓아야 하고 migration이 진행된 후에 만들 수 있는 AWS 리소스들도 따로 있기 때문이다.(AMI, AutoScalingGroup 등)
web, was 서버는 AWS MGN(Application Migration Service) 서비스를 통해 진행하고 db는 AWS DMS(Database Migration Service)를 활용하여 migration을 진행함
