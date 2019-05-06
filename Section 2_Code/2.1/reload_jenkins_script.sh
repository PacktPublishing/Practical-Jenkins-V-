#!/bin/bash
crumb_id=$(curl -s 'http://localhost:8080/crumbIssuer/api/xml?xpath=concat(//crumbRequestField,":",//crumb)' -u admin:admin)
curl -s -XPOST 'http://localhost:8080/reload' -u admin:admin -H "$crumb_id"
