function updateCountDownTimer() {
    const startDate = {{startDate}};
    const endDate = {{endDate}};
    const CountDownTimerId = {{id}};
    const CountDownTimerPreId = {{preId}};

    const current = new Date();

    let timeLeft = 0;
    if(current < startDate) {
        document.getElementById(CountDownTimerPreId).innerHTML = "Time left to start";
        timeLeft = startDate.getTime() - current.getTime();
    } else {
        document.getElementById(CountDownTimerPreId).innerHTML = "Time remaining";
        timeLeft = endDate.getTime() - current.getTime();
    }

    // Abort if time is up
    if(timeLeft < 0)
    {
        document.getElementById(CountDownTimerId).innerHTML = "Time's up!";
        return;
    }

    let hours = Math.floor(timeLeft / (1000*60*60));
    let mins = Math.floor(timeLeft/(1000 * 60) - hours * 60);
    let secs = Math.floor(timeLeft/1000 - mins * 60 - hours * 60 * 60);

    document.getElementById(CountDownTimerId).innerHTML =
        hours + ":" + (mins<10?"0":"") + mins + "<span id=\"seconds\">:" + (secs<10?"0":"") + secs +"</span>";
}

updateCountDownTimer();

setInterval(updateCountDownTimer,1000);