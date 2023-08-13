variable "public_key" {
  type = string
  default  = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQCkiKd8X4bTxIiTc6qNpSHr0TpR75Gi12mf2J3py6kd++xb0vD5ErHKMURuzOHbon25dMHVblWfq5RBdjJiQ3vPica+r4uiCyqq2W+JS1pfy5KYl8rCh2Jo7UEbkqsyw4B625e8doGb7VYWq6J8LcGYZNQA/c+AxLjPqMR7NHl8mf9/69esIuzfQuEJlYiHnkdqSIwOz+wKNJC16fhCfsmYUes3Y2yxyVZe9wg0Xq+CGz9LWihR/GslcFMOI7hvdXS6YFI69eiO/lj7l4ts5G1BtaLFW0YUT7Lu6uOaYYwnc5xu0ZSSI1oGIJgbs20YAbYKpC6ynlfNnCK3HJAh9NVaIChL+3Tv1V6gTmUFKpNRp/xjdtRE5kjNpnhxIax+Xt+THP8xyd16ZfGyGz/SMB7OGqXTnUAMWQmV1B3SPqC+KvOHn4i1GL5TUQuT+f79ocWBAwjJixb/yHT7NTSyv+Ki8krQJiZNCgKqCDWhGsDRRNgoQyehE2/daBSz95HNdu0= tuandang@TuanDangs-MacBook-Pro.local"
}

resource "aws_key_pair" "key_pair" {
  key_name   = "TEST"
  public_key = var.public_key
}
