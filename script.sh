#steps

tmsh modify /sys db users.strictpasswords value disable
tmsh modify auth user admin prompt-for-password

cd /var/config/rest/downloads
curl -L -o f5-declarative-onboarding-1.46.0-7.noarch.rpm https://github.com/F5Networks/f5-declarative-onboarding/releases/download/v1.46.0/f5-declarative-onboarding-1.46.0-7.noarch.rpm


DATA="{\"operation\":\"INSTALL\",\"packageFilePath\":\"/var/config/rest/downloads/f5-declarative-onboarding-1.46.0-7.noarch.rpm\"}"

curl -k -u "admin:admin" -X POST "https://localhost/mgmt/shared/iapp/package-management-tasks" \
    -H "Origin: https://localhost" \
    -H "Content-Type: application/json;charset=UTF-8" \
    --data-binary "$DATA"

curl -sku "admin:admin" https://localhost/mgmt/shared/declarative-onboarding/info


