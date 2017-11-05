// "function updateClock() { const current = new Date(); Array.from(document.getElementsByClassName(\"\(CurrentTime.className)\")).map(function(x) { x.innerHTML = current.getHours()+\":\"+ (current.getMinutes()<10?\"0\":\"\") + current.getMinutes(); });} updateClock(); setInterval(updateClock,1000);",

// The JavaScript file used by Sc

function updateClock() {
    const current = new Date();
    Array.from(document.getElementsByClassName("\(className)")).map(function(x) {
        x.innerHTML = current.getHours()+":"+ (current.getMinutes()<10?"0":"") + current.getMinutes();
    });
}

updateClock();

setInterval(updateClock,1000);
