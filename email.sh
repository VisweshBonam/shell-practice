#!/bin/bash

{
echo "To: Viswesh.bonam@gmail.com"
echo "Subject:Testing Gmail"
echo "Content-Type: text/html"
echo ""
echo "Testing"
} | msmtp "viswesh.bonam@gmail.com"