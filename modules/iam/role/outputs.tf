output "role_arn" {
  value = aws_iam_role.role[0].arn
}
output "role_name" {
  value = aws_iam_role.role[0].name
}
output "role_id" {
  value = aws_iam_role.role[0].id
}
output "role_unique_id" {
  value = aws_iam_role.role[0].unique_id
}
