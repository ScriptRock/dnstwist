#!/bin/bash
set -e

SHORT_SHA=$(git rev-parse --short HEAD)

echo "Building image..."

docker build --platform linux/amd64 -t "us.gcr.io/vendor-risk-development/dnstwist:$SHORT_SHA" .

docker tag "us.gcr.io/vendor-risk-development/dnstwist:$SHORT_SHA" "us.gcr.io/vendor-risk-production/dnstwist:$SHORT_SHA"

./test-output.sh "us.gcr.io/vendor-risk-development/dnstwist:$SHORT_SHA"

echo "Pushing development image..."

docker push "us.gcr.io/vendor-risk-development/dnstwist:$SHORT_SHA"

echo "Pushing production image..."

docker push "us.gcr.io/vendor-risk-production/dnstwist:$SHORT_SHA"

printf "\n\nDone. Successfully pushed images:\nus.gcr.io/vendor-risk-development/dnstwist:%s\nus.gcr.io/vendor-risk-production/dnstwist:%s\n" $SHORT_SHA $SHORT_SHA
