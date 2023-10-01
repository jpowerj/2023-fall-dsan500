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
      '.sec-num': '02',
      '.sec-day': 'Tue',
      '.sec-day-full': 'Tuesday',
      '.sec-time': '12:30pm-3pm',
      '.sec-room': 'ICC 219',
      '.sec-zoom-link': 'https://georgetown.zoom.us/j/93896372980',
      '.sec-w01-date': 'Aug 23',
      '.sec-w02-date': 'Aug 29',
      '.sec-w03-date': 'Sep 6',
      '.sec-w04-date': 'Sep 12',
      '.sec-w05-date': 'Sep 19',
      '.sec-w06-date': 'Sep 26',
      '.sec-start': '12:30pm',
      '.sec-p10': '12:40pm',
      '.sec-p30': '1:00pm',
      '.sec-p40': '1:10pm',
      '.sec-p45': '1:15pm',
      '.sec-p50': '1:20pm',
      '.sec-p55': '1:25pm',
      '.sec-p60': '1:30pm',
      '.sec-p70': '1:40pm',
      '.sec-p90': '2:00pm',
      '.sec-p100': '2:10pm',
      '.sec-p130': '2:40pm',
      '.sec-p140': '2:50pm',
      '.sec-end': '3:00pm',
      '.rec-link-w05': '../recordings/recording-w05s02-1.html'
    },
    '03': {
      '.sec-num': '03',
      '.sec-day': 'Wed',
      '.sec-day-full': 'Wednesday',
      '.sec-time': '3:30pm-6pm',
      '.sec-room': 'Car Barn 203',
      '.sec-zoom-link': 'https://georgetown.zoom.us/j/99159827749',
      '.sec-w01-date': 'Aug 23',
      '.sec-w02-date': 'Aug 30',
      '.sec-w03-date': 'Sep 6',
      '.sec-w04-date': 'Sep 13',
      '.sec-w05-date': 'Sep 20',
      '.sec-w06-date': 'Sep 27',
      '.sec-start': '3:30pm',
      '.sec-p10': '3:40pm',
      '.sec-p30': '4:00pm',
      '.sec-p40': '4:10pm',
      '.sec-p45': '4:15pm',
      '.sec-p50': '4:20pm',
      '.sec-p55': '4:25pm',
      '.sec-p60': '4:30pm',
      '.sec-p70': '4:40pm',
      '.sec-p90': '5:00pm',
      '.sec-p100': '5:10pm',
      '.sec-p130': '5:40pm',
      '.sec-p140': '5:50pm',
      '.sec-end': '6:00pm',
      '.rec-link-w05': '../recordings/recording-w05s03-1.html'
    }
  }

  const applyToggleSection = (newStr) => {
    console.log("Changing to " + newStr);
    setSection(newStr);
    // First, if we're on slides, change the toggle
    // icon accordingly
    updateToggleIcon(newStr);
    let sData = sectionData[newStr];
    for (const [sKey, sVal] of Object.entries(sData)) {
      if (sKey.startsWith(".rec-link")) {
        $(sKey).attr('href', sVal);
      } else if (sKey == ".sec-zoom-link") {
        $(sKey).attr('href', sVal);
      } else {
        $(sKey).text(sVal);
      }
      //console.log(`${key}: ${value}`);
    }
    // A special one for the slides... Very janky
    const s02Replace = {
      'Wednesday, September 13, 2023': 'Tuesday, September 12, 2023',
      'Wednesday, September 20, 2023': 'Tuesday, September 19, 2023',
      'Wednesday, September 27, 2023': 'Tuesday, September 26, 2023',
    };
    const s03Replace = {
      'Tuesday, September 12, 2023': 'Wednesday, September 13, 2023',
      'Tuesday, September 19, 2023': 'Wednesday, September 20, 2023',
      'Tuesday, September 26, 2023': 'Wednesday, September 27, 2023',
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
      // And bold the name
      let oldLabelElt = $('#toggle-02-label');
      oldLabelElt.css('font-weight', 'normal')
      let newLabelElt = $('#toggle-03-label');
      newLabelElt.css('font-weight', 'bolder');
      return;
    }
    if (toggleElt.length && newSection == "02") {
      toggleElt.removeClass("bi-toggle-on");
      toggleElt.addClass("bi-toggle-off");
      let oldLabelElt = $('#toggle-03-label');
      oldLabelElt.css('font-weight', 'normal');
      let newLabelElt = $('#toggle-02-label');
      newLabelElt.css('font-weight', 'bolder');
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
