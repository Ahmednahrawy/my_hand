@echo off
echo Running Flutter commands...

echo "##########git add all..."
git add .
echo "#########git commit fake..."
git commit -m "Fake commit for testing"

echo "##########git push"
git push -u origin

echo All commands executed successfully!
