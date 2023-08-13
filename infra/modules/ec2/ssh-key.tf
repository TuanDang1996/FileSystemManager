variable "public_key" {
  type = string
  default  = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQC+HR5tnIJQKn5/P3ubQaxMO/BOcxM99VErVLn4dsfVrwMj9LlAj/cOA2m9A/57ZSFukZB9o6eB3hbB/C3/rX9LOAJJeI5V+ygz6a9mIzAB5g1/7Kya9mwOp6T4qrG6Zk1TEEutistVxBfgfGBBW8O3qGTb+zZHLTVjOkAtBKDAbaRcho5J+PA7dk5gEP/LmLFXY/joC6iZEdvOgP0PyZ0Dw1oqp1On0XU2yP5hLiUgGphCoGonr+tovJrKfuJoiJPm9xJKl39ZKDT6iZx/kfS0zCoaI1zPrgMru8ZeZs5rvGGMKB4HnpQdK8yVSNiCTfWha76kh6WUVfm+e6t+MwUqrWf1JRTrBaJkZpoAucsi/v5qQL6ip1BYcaxEonyr71orCGyt4og0rLpNWmESi+0G2p27KhUOVwFILhT/LhFiFarIrUSpHvibv3WkdhQySBYJKTzBHTGRmhRyK1GrtoScGtp+MRKNyaHD16oiVX3r6RPJmGsnbQAkQ/eVVbwDHrM= tuandang@TuanDangs-MacBook-Pro.local"
}

resource "aws_key_pair" "key_pair" {
  key_name   = "TEST"
  public_key = var.public_key
}
