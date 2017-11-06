// function updateCountDownTimer() { const date_start = new Date(2017,11,2,10,30,0,0); const date_end = new Date(2017,11,2,20,0,0,0); const CountDownTimerId = \"CountDownTimer-HARDCODED_ID\"; const current = new Date(); let timeLeft = 0; if(current < date_start) { document.getElementById(CountDownTimerId).innerHTML = \"Time left to start:\"; timeLeft = date_start.getTime() - current.getTime(); } else { document.getElementById(CountDownTimerId).innerHTML = \"Time remaining:\"; timeLeft = date_end.getTime() - current.getTime(); } // Abort if time is up if(timeLeft < 0) { document.getElementById(CountDownTimerId).innerHTML = \"Time's up!\"; return; } let hours = Math.floor(timeLeft / (1000*60*60)); let mins = Math.floor(timeLeft/(1000 * 60) - hours * 60); let secs = Math.floor(timeLeft/1000 - mins * 60 - hours * 60 * 60); document.getElementById(CountDownTimerId).innerHTML += hours + \":\" + (mins<10?\"0\":\"\") + mins + \"<span id=\\"seconds\\">:\" + (secs<10?\"0\":\"\") + secs +\"</span>\"; } updateCountDownTimer(); setInterval(updateCountDownTimer,1000);

function updateCountDownTimer() {
    // TODO: Escape HERE!, remove Dates, lets Swift Insert them! :D
    const date_start = new Date(2017,11,2,10,30,0,0);
    const date_end = new Date(2017,11,2,20,0,0,0);
    const CountDownTimerId = "CountDownTimer-HARDCODED_ID";
    const CountDownTimerPreId = "CountDownTimer-HARDCODED_PRE_ID";

    const current = new Date();

    let timeLeft = 0;
    if(current < date_start) {
        document.getElementById(CountDownTimerPreId).innerHTML = "Time left to start";
        timeLeft = date_start.getTime() - current.getTime();
    } else {
        document.getElementById(CountDownTimerPreId).innerHTML = "Time remaining";
        timeLeft = date_end.getTime() - current.getTime();
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