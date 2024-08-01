# Define the path to the Maven project
$mavenProjectPath = "$pwd"
$warFilename = "greeter-mvc.war"

# Define the path to the file to copy and the destination path
$sourceFilePath = "$mavenProjectPath\target\$warFilename"
$destinationPath = "C:\Program Files\Apache Software Foundation\Tomcat 10.1\webapps"

# Change directory to the Maven project
Set-Location -Path $mavenProjectPath

# Clean the target directory
Invoke-Expression ".\mvnw clean"

# Run the Maven package command
$mvnPackage = ".\mvnw package"
Invoke-Expression $mvnPackage

# Check if the Maven command was successful
if ($LASTEXITCODE -eq 0) {
    Write-Output "Maven build successful. Proceeding to copy the file."

    # Copy the file to the destination
    Copy-Item -Path $sourceFilePath -Destination $destinationPath -Force

    if ($?) {
        Write-Output "File copied successfully."
    } else {
        Write-Output "Failed to copy the file."
    }
} else {
    Write-Output "Maven build failed. File will not be copied."
}
