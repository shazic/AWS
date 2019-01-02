#####################################################################################################
### storage/main.tf
### defines the storage/database layer
#####################################################################################################

# Get the avaialable AZs
data "aws_availability_zones" "available" {}

resource "aws_db_instance" "main" {
    
}
