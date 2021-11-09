$perftimers = @{};

# Function to start a timer and add it to the timer registry
function _perf_timer_start {
    param (
        $TimerName
    )

    $stopwatch = New-Object System.Diagnostics.Stopwatch
    $stopwatch.Start()
    $perftimers.$TimerName = $stopwatch
}

# Function to fetch a timer from the timer registry, stop it, and return the elapsed time
function _perf_timer_stop {
    param (
        $TimerName
    )

    if (!($perftimers[$TimerName])) {
        throw "Timer $TimerName has not been started"
    }

    $stopwatch = $perftimers[$TimerName]
    $stopwatch.Stop()
    pprint("$TimerName " + ($stopwatch.Elapsed.TotalMilliseconds.ToString() -split '\,')[0] + "ms")

    $perftimers[$TimerName] = $null
}