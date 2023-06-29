# Ask the user for the duration in hours or minutes
$durationInput = Read-Host "Enter the duration (e.g., '2 hours' or '1 hour' or '30 minutes' or '1 minute'):"

# Parse the input to extract the numeric value and the unit
$durationValue = [int]($durationInput -split '\s')[0]
$durationUnit = ($durationInput -split '\s')[1]

# Convert the duration to seconds
switch ($durationUnit) {
    "hours" {
        $durationInSeconds = $durationValue * 60 * 60
        break
    }
    "hour" {
        $durationInSeconds = $durationValue * 60 * 60
        break
    }
    "minutes" {
        $durationInSeconds = $durationValue * 60
        break
    }
    "minute" {
        $durationInSeconds = $durationValue * 60
        break
    }
    default {
        Write-Host "Invalid duration unit. Please specify either 'hour(s)' or 'minute(s)'."
        exit
    }
}

# Calculate the end time
$endTime = (Get-Date).AddSeconds($durationInSeconds)

# Display the countdown
while ((Get-Date) -lt $endTime) {
    $timeLeft = $endTime - (Get-Date)
    $hoursLeft = $timeLeft.Hours
    $minutesLeft = $timeLeft.Minutes
    $secondsLeft = $timeLeft.Seconds
    $formattedTimeLeft = "{0:00}:{1:00}:{2:00}" -f $hoursLeft, $minutesLeft, $secondsLeft
    Write-Host "Shutting down in $formattedTimeLeft..."
    Start-Sleep -Seconds 1
}

# Shut down the computer
Stop-Computer -Force
