function updateClock() {
    const id = {{id}};
    const current = new Date();
    document.getElementById(id).innerHTML = current.getHours()+":"+(current.getMinutes()<10?"0":"") + current.getMinutes();
}

updateClock();

setInterval(updateClock,1000);
