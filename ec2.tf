resource "aws_key_pair" "user_key" {
  key_name   = var.ssh_key_name
  public_key = var.ssh_pub_key
}

resource "aws_instance" "test_instance" {
  instance_type               = var.instance_type
  vpc_security_group_ids      = [aws_security_group.ssh_sg.id]
  key_name                    = aws_key_pair.user_key.key_name
  associate_public_ip_address = true
  ami                         = data.aws_ami.amazon_linux.id
  # Copy the backup script to the instance and configure cron job
  user_data = <<-EOF
              #cloud-config
              package_update: true
              packages:
                - cronie
                - awscli

              write_files:
                - encoding: b64
                  path: /usr/local/bin/backup_script.sh
                  permissions: '0755'
                  owner: ec2-user
                  content: |
                    ${base64encode(templatefile("${path.module}/backup_script.sh.tftpl", { bucket_name = var.bucket_name }))}

              runcmd:
                - sleep 40
                - systemctl enable crond
                - systemctl start crond
                - echo "0 2 * * * /usr/local/bin/backup_script.sh" | crontab -u ec2-user -
              EOF

  user_data_replace_on_change = true
  iam_instance_profile        = aws_iam_instance_profile.instance_profile.name

  instance_market_options {
    market_type = "spot"
    spot_options {
      max_price = 0.0035
    }
  }

  root_block_device {
    volume_size           = "10"
    volume_type           = "gp3"
    delete_on_termination = true
  }

  tags = {
    Name        = var.instance_name
    Environment = var.environment
  }
}

resource "aws_security_group" "ssh_sg" {
  name        = var.sg_name
  description = "Security group for external ssh instance"
  vpc_id      = data.aws_vpc.default.id

  ingress {
    description = "Allow SSH access"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    description = "Allow all outbound traffic"
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}
