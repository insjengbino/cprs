function broadcastLogout() {
    localStorage.setItem('logout-event', Date.now());
}

function confirmLogout() {
    if (confirm('Are you sure you want to Logout?')) {
        broadcastLogout();
        return true;
    }
    return false;
}

document.addEventListener('visibilitychange', () => {
    var lastLogoutTime = localStorage.getItem('logout-event');
    if (document.visibilityState === 'visible') {
        var newLogoutTime = localStorage.getItem('logout-event');
        if (newLogoutTime && newLogoutTime !== lastLogoutTime) {
            window.location.href = 'https://www.intercommerce.com.ph/';
        }
    }
});

window.addEventListener('focus', () => {
    var lastLogoutTime = localStorage.getItem('logout-event');
    var newLogoutTime = localStorage.getItem('logout-event');
    if (newLogoutTime && newLogoutTime !== lastLogoutTime) {
        window.location.href = 'https://www.intercommerce.com.ph/';
    }
});

window.addEventListener('storage', function(event) {
    if (event.key === 'logout-event') {
        window.location.href = 'https://www.intercommerce.com.ph/';
    }
});

// Session timeout due to inactivity; 20 mins
var inactivityTimer;
var inactivityTimeout = 20 * 60 * 1000; // 20 minutes in milliseconds
var debounceDelay = 300; // debounce delay in milliseconds
var debounceTimer;

// Debounced function to reset the timer
function debouncedResetInactivityTimer() {
    clearTimeout(debounceTimer);
    debounceTimer = setTimeout(resetInactivityTimer, debounceDelay);
}

function resetInactivityTimer() {
    clearTimeout(inactivityTimer);
    inactivityTimer = setTimeout(logoutUser, inactivityTimeout);
	console.log(inactivityTimeout);
}

function logoutUser() {
    alert('Your session has expired due to inactivity. Please log in again.');
    window.location.href = 'http://cprs.intercommerce.com.ph/cprs/logout.action';
}

// User activity events to track
var activityEvents = [
    'mousemove',
    'keydown',
    'scroll',
    'click',
    'touchstart',
    'wheel'
];

// Attach event listeners for all defined activity events
activityEvents.forEach(function(event) {
    document.addEventListener(event, debouncedResetInactivityTimer);
});

// Start the timer when the page loads
window.onload = resetInactivityTimer;

// TEST
// fetch("http://intercommerce.com.ph/api/login.asp", {
//   method: "GET",
//   credentials: "include"
// })
// .then(res => res.json())
// .then(data => console.log(data))
// .catch(err => console.error("Error:", err));

