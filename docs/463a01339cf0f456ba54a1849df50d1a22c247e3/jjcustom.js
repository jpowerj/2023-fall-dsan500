window.document.addEventListener("DOMContentLoaded", function (event) {
  const sectionKey = 'dsan5000-section';
  
  // Dark / light mode switch
  window.toggleSectionClicked = (sectionStr) => {
    console.log("window.toggleSectionClicked: " + sectionStr);
    applyToggleSection(sectionStr);
  };

  window.toggleIconClicked = () => {
    console.log("window.toggleIconClicked()");
    // Figure out the current section
    let curSectionStr = getSection();
    // Find its inverse
    let newSectionStr = invertSection(curSectionStr);
    // And apply that
    applyToggleSection(newSectionStr);
  }

  const defaultSection = "02";
  const getSection = () => {
    console.log("getSection()");
    if (localStorage.getItem(sectionKey) === null) {
      console.log("section was null");
      setSection(defaultSection);
    }
    if (localStorage.getItem(sectionKey) === undefined) {
      console.log("section was undefined");
      setSection(defaultSection);
    }
    if (localStorage.getItem(sectionKey) == "undefined") {
      // Sigh
      console.log("section was the string 'undefined'");
      setSection(defaultSection);
    }
    return localStorage.getItem(sectionKey);
  }

  const setSection = (secStr) => {
    localStorage.setItem(sectionKey, secStr);
  }

  const invertSection = (secStr) => {
    return(secStr == "02" ? "03" : "02");
  }

  const sectionData = {
    '02': {
      day: 'Tue',
      dayFull: 'Tuesday',
      time: '12:30pm-3pm',
      room: 'ICC 219',
      w01Date: 'Aug 23',
      w02Date: 'Aug 29',
      w03Date: 'Sep 6',
      w04Date: 'Sep 12',
      w05Date: 'Sep 19',
      w05DateFull: 'Tuesday, September 19, 2023',
      start: '12:30pm',
      p10: '12:40pm'
    },
    '03': {
      day: 'Wed',
      dayFull: 'Wednesday',
      time: '3:30pm-6pm',
      room: 'Car Barn 203',
      w01Date: 'Aug 23',
      w02Date: 'Aug 30',
      w03Date: 'Sep 6',
      w04Date: 'Sep 13',
      w05Date: 'Sep 20',
      w05DateFull: 'Wednesday, September 20, 2023',
      start: '3:30pm',
      p10: '3:40pm'
    }
  }

  const applyToggleSection = (newStr) => {
    console.log("Changing to " + newStr);
    setSection(newStr);
    // First, if we're on slides, change the toggle
    // icon accordingly
    updateToggleIcon(newStr);
    $('.sec-num').text(newStr);
    let sData = sectionData[newStr];
    $('.sec-day').text(sData.day);
    $('.sec-day-full').text(sData.dayFull);
    $('.sec-time').text(sData.time);
    $('.sec-room').text(sData.room);
    // Times
    $('.sec-start').text(sData.start);
    $('.sec-p10').text(sData.p10);
    // And the weekly dates
    $('.sec-w01-date').text(sData.w01Date);
    $('.sec-w02-date').text(sData.w02Date);
    $('.sec-w03-date').text(sData.w03Date);
    $('.sec-w04-date').text(sData.w04Date);
    $('.sec-w05-date').text(sData.w05Date);
    // A special one for the slides... Very janky
    const s02Replace = {
      'Wednesday, September 13, 2023': 'Tuesday, September 12, 2023',
      'Wednesday, September 20, 2023': 'Tuesday, September 19, 2023'
    };
    const s03Replace = {
      'Tuesday, September 12, 2023': 'Wednesday, September 13, 2023',
      'Tuesday, September 19, 2023': 'Wednesday, September 20, 2023'
    };
    let shownDate = $('p.date').text();
    //console.log(shownDate);
    if (newStr == "03" && (s03Replace.hasOwnProperty(shownDate))) {
      console.log("Replacing with s03 date");
      let replaceWith = s03Replace[shownDate];
      console.log("Replacement should be: " + replaceWith);
      $('p.date').text(replaceWith);
    }
    if (newStr == "02" && (s02Replace.hasOwnProperty(shownDate))) {
      console.log("Replacing with s02 date");
      let replaceWith = s02Replace[shownDate];
      $('p.date').text(replaceWith);
    }
  }

  const updateToggleIcon = (newSection) => {
    // Check for the toggle button
    let toggleSelector = '#section-toggle-icon';
    let toggleElt = $(toggleSelector);
    if (toggleElt.length && newSection == "03") {
      toggleElt.removeClass("bi-toggle-off");
      toggleElt.addClass("bi-toggle-on");
      return;
    }
    if (toggleElt.length && newSection == "02") {
      toggleElt.removeClass("bi-toggle-on");
      toggleElt.addClass("bi-toggle-off");
    }
  }

  let localStorageChecked = false;
  if (!localStorageChecked) {
    let curSection = getSection();
    //console.log("Detected section:");
    //console.log(curSection);
    // Check for the slider
    let radioSelector = `#btn-radio-${curSection}`;
    let radioElt = $(radioSelector);
    if (radioElt.length) {
      radioElt.click();
    }
    // Check for the toggle icon
    let toggleSelector = '#section-toggle-icon';
    let toggleElt = $(toggleSelector);
    if (toggleElt.length) {
      //updateToggleIcon(curSection);
      applyToggleSection(curSection);
    }
    localStorageChecked = true;
  }
});
