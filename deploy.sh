#/bin/bash
# Tom Needham 14/10/2016

# Simple deploy script to copy over the code to the locomotive
# Requries that ssh keys have been previously configured for authentication

# Usage: ./deploy.sh user@host

# Check we have the latest dependancies
echo "Installing latest dependancies\n"
npm install

# Clear last build tar
echo "Removing old build file\n";
rm build.tar

# Build a tar file with everything in it
echo "Collecting together new code ready for deployment\n";
tar -zf ./* -C build.tar

# Kill existing instances
echo "Killing existing controller instances\n";
ssh $1 killall node

# Copy over the code
echo "Copying code to locomotive\n";
scp -Rv build.tar $1:/home/pi/ $2

# Remove the current expanded folder
echo "Removing existing code\n";
ssh $1 rm -r /home/pi/wrc-server

# Extract the new code
echo "Extracting new code\n";
ssh $1 tar -xvf build.tar -o wrc-server

echo 'Done.'
