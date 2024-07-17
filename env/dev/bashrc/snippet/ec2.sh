complete -C aws_completer aws

INSTANCE_TYPE=""
KEYPAIR_NAME=""
SUBNET_ID=""
SECURITY_GROUP_ID=""
DEFAULT_INSTANCE_TYPE_X86="c7i.4xlarge"
DEFAULT_INSTANCE_TYPE_ARM="c7g.4xlarge"

function ec2-run() {
    NAME=$1
    AMI_ID=$2

    if [ ! $INSTANCE_TYPE ]; then
	IS_ARM=$3

	if [ "$IS_ARM" = false ]; then
	    INSTANCE_TYPE=$DEFAULT_INSTANCE_TYPE_X86
	    echo setting $INSTANCE_TYPE
	else
	    INSTANCE_TYPE=$DEFAULT_INSTANCE_TYPE_ARM
	    echo setting $INSTANCE_TYPE
	fi

	CLEAR_INSTANCE_TYPE=true
    fi

    aws ec2 run-instances \
	--count 1 \
	--instance-type $INSTANCE_TYPE \
	--image-id $AMI_ID \
	--key-name $KEYPAIR_NAME \
	--subnet-id $SUBNET_ID \
	--security-group-ids $SECURITY_GROUP_ID \
	--ebs-optimized \
	--block-device-mapping '[{"DeviceName": "/dev/xvda", "Ebs": {"VolumeSize": 1024, "VolumeType": "gp3"}}]' \
	--tag-specifications "ResourceType=instance,Tags=[{Key=Name,Value=$NAME}]"

    if [ "$CLEAR_INSTANCE_TYPE" = true ]; then
	INSTANCE_TYPE=""
	CLEAR_INSTANCE_TYPE=false
    fi
}

function rec2() {
    NAME=$1
    AMI_ID=$2
    ec2-run $NAME $AMI_ID false
}

function rec2a() {
    NAME=$1
    AMI_ID=$2
    ec2-run $NAME $AMI_ID true
}

function rec2-ssm() {
    if [ $# -ne 3 ]; then
	echo "Please specify instance name."
	return
    fi

    NAME=$1

    SSM_PATH=$2
    AMI_ID=$(aws ssm get-parameters --output text \
		 --query="Parameters[].Value" --names $SSM_PATH)

    IS_ARM=$3

    ec2-run $NAME $AMI_ID $IS_ARM
}

function ral23() {
    NAME=$1
    SSM_PATH="/aws/service/ami-amazon-linux-latest/al2023-ami-kernel-6.1-x86_64"
    rec2-ssm $NAME $SSM_PATH false
}

function ral23a() {
    NAME=$1
    SSM_PATH="/aws/service/ami-amazon-linux-latest/al2023-ami-kernel-6.1-arm64"
    rec2-ssm $NAME $SSM_PATH true
}

function ral2() {
    NAME=$1
    SSM_PATH="/aws/service/ami-amazon-linux-latest/amzn2-ami-hvm-x86_64-gp2"
    rec2-ssm $NAME $SSM_PATH false
}

function ral2a() {
    NAME=$1
    SSM_PATH="/aws/service/ami-amazon-linux-latest/amzn2-ami-hvm-arm64-gp2"
    rec2-ssm $NAME $SSM_PATH true
}

function ral1() {
    NAME=$1
    SSM_PATH="/aws/service/ami-amazon-linux-latest/amzn-ami-hvm-x86_64-gp2"
    rec2-ssm $NAME $SSM_PATH false
}

function ec2-serial() {
    INSTANCE_ID=$1

    aws ec2-instance-connect send-serial-console-ssh-public-key \
	--instance-id ${INSTANCE_ID} \
	--serial-port 0 \
	--ssh-public-key file://~/.ssh/id_rsa.pub && \
	ssh -o 'PubkeyAcceptedKeyTypes +ssh-rsa' \
	    ${INSTANCE_ID}.port0@serial-console.ec2-instance-connect.ap-northeast-1.aws
}
