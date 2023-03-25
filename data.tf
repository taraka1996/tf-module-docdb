data "aws_ssm_parameter" "user" {
    name = "${var.env}.dcodb.user"
}

data "aws_ssm_parameter" "pass" {
      name = "${var.env}.docdb.pass"

}