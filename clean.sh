@echo off
echo Running Flutter commands...

echo "##########Cleaning project..."
flutter clean

echo "#########Getting dependencies..."
flutter pub get
flutter pub outdated

echo "##########upgrading flutter"
flutter pub upgrade
flutter pub outdated


echo All commands executed successfully!
pause