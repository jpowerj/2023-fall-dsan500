window.document.addEventListener("DOMContentLoaded", function (event) {
  // Trying to append nav stuff
  //var $testdiv = $( "<div class='sidebar-tools-main' style='display: inline-flex !important'>testing</div>" );
  var $subtitleDiv = $("<br><span class='subtitle'>Fall 2023, Georgetown, Prof. Jacobs <a href='mailto:jj1088@georgetown.edu' target='_blank'><i class='bi bi-envelope-at ps-1'></i></a><span class='btn-group section-toggle' role='group' aria-label='Basic radio toggle button group' style='display: inline-flex !important; margin-top: 4px !important; width: 100% !important;'><input type='radio' class='btn-check pt-5' name='btnradio' id='btn-radio-02' autocomplete='off' onclick=\"window.toggleSectionClicked('02');\"><label class='btn btn-outline-secondary btn-sm' for='btn-radio-02' id='btn-label-02'>Sec 02</label><input type='radio' class='btn-check' name='btnradio' id='btn-radio-03' autocomplete='off' onclick=\"window.toggleSectionClicked('03');\"><label class='btn btn-outline-secondary btn-sm' for='btn-radio-03' id='btn-label-03'>Sec 03</label></span><br><span class='section-info subsubtitle'><span class='sec-day'>Tue</span> <span class='sec-time'>12:30pm-3pm</span><br><span class='sec-room'>ICC 219</span><br><a class='sec-zoom-link' href='https://georgetown.zoom.us/j/93896372980' target='_blank' class='icon-link' style='text-decoration: none !important;'><span class='icon pe-1'><svg class='bi' xmlns='http://www.w3.org/2000/svg' x='0px' y='0px' width='20' height='20' viewBox='0 0 50 50'><path d='M33.619,4H16.381C9.554,4,4,9.554,4,16.381v17.238C4,40.446,9.554,46,16.381,46h17.238C40.446,46,46,40.446,46,33.619	V16.381C46,9.554,40.446,4,33.619,4z M30,30.386C30,31.278,29.278,32,28.386,32H15.005C12.793,32,11,30.207,11,27.995v-9.382	C11,17.722,11.722,17,12.614,17h13.382C28.207,17,30,18.793,30,21.005V30.386z M39,30.196c0,0.785-0.864,1.264-1.53,0.848l-5-3.125	C32.178,27.736,32,27.416,32,27.071v-5.141c0-0.345,0.178-0.665,0.47-0.848l5-3.125C38.136,17.54,39,18.019,39,18.804V30.196z'></path></svg></span>S<span class='sec-num'>02</span> Zoom Link <i class='bi bi-box-arrow-up-right ps-1'></i></a></span>");
  $('.sidebar-title').append($subtitleDiv);

  // And once the sidebar is set up we can do this stuff...
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
      '.sec-w07-date': 'Oct 3',
      '.sec-w08-date': 'Oct 10',
      '.sec-w09-date': 'Oct 24',
      '.sec-start': '12:30pm',
      '.sec-p10': '12:40pm',
      '.sec-p15': '12:45pm',
      '.sec-p20': '12:50pm',
      '.sec-p30': '1:00pm',
      '.sec-p35': '1:05pm',
      '.sec-p40': '1:10pm',
      '.sec-p45': '1:15pm',
      '.sec-p50': '1:20pm',
      '.sec-p55': '1:25pm',
      '.sec-p60': '1:30pm',
      '.sec-p65': '1:35pm',
      '.sec-p70': '1:40pm',
      '.sec-p80': '1:50pm',
      '.sec-p90': '2:00pm',
      '.sec-p100': '2:10pm',
      '.sec-p130': '2:40pm',
      '.sec-p140': '2:50pm',
      '.sec-end': '3:00pm',
      '.rec-link-w05': '../recordings/recording-w05s02-1.html',
      '.rec-link-w06': '../recordings/recording-w06s02-1.html',
      '.rec-link-w07': '../recordings/recording-w07s02-1.html',
      '.rec-link-w08': '../recordings/recording-w08s02-1.html',
      '.rec-link-w09': '../recordings/recording-w09s02-1.html'
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
      '.sec-w07-date': 'Oct 4',
      '.sec-w08-date': 'Oct 11',
      '.sec-w09-date': 'Oct 25',
      '.sec-start': '3:30pm',
      '.sec-p10': '3:40pm',
      '.sec-p15': '3:45pm',
      '.sec-p20': '3:50pm',
      '.sec-p30': '4:00pm',
      '.sec-p35': '4:05pm',
      '.sec-p40': '4:10pm',
      '.sec-p45': '4:15pm',
      '.sec-p50': '4:20pm',
      '.sec-p55': '4:25pm',
      '.sec-p60': '4:30pm',
      '.sec-p65': '4:35pm',
      '.sec-p70': '4:40pm',
      '.sec-p80': '4:50pm',
      '.sec-p90': '5:00pm',
      '.sec-p100': '5:10pm',
      '.sec-p130': '5:40pm',
      '.sec-p140': '5:50pm',
      '.sec-end': '6:00pm',
      '.rec-link-w05': '../recordings/recording-w05s03-1.html',
      '.rec-link-w06': '../recordings/recording-w06s03-1.html',
      '.rec-link-w07': '../recordings/recording-w07s03-1.html',
      '.rec-link-w08': '../recordings/recording-w08s03-1.html',
      '.rec-link-w09': '../recordings/recording-w09s03-1.html'
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
      // w01
      'Wednesday, August 23, 2023': 'Tuesday, August 22, 2023',
      // w02
      'Wednesday, August 30, 2023': 'Tuesday, August 29, 2023',
      // w03
      'Wednesday, September 6, 2023': 'Tuesday, September 5, 2023',
      // w04
      'Wednesday, September 13, 2023': 'Tuesday, September 12, 2023',
      // w05
      'Wednesday, September 20, 2023': 'Tuesday, September 19, 2023',
      // w06
      'Wednesday, September 27, 2023': 'Tuesday, September 26, 2023',
      // w07
      'Wednesday, October 4, 2023': 'Tuesday, October 3, 2023',
      // w08
      'Wednesday, October 18, 2023': 'Tuesday, October 17, 2023',
      // w09
      'Wednesday, October 25, 2023': 'Tuesday, October 24, 2023'
    };
    const s03Replace = {
      // w01
      'Tuesday, August 22, 2023': 'Wednesday, August 23, 2023',
      // w02
      'Tuesday, August 29, 2023': 'Wednesday, August 30, 2023',
      // w03
      'Tuesday, September 5, 2023': 'Wednesday, September 6, 2023',
      // w04
      'Tuesday, September 12, 2023': 'Wednesday, September 13, 2023',
      // w05
      'Tuesday, September 19, 2023': 'Wednesday, September 20, 2023',
      // w06
      'Tuesday, September 26, 2023': 'Wednesday, September 27, 2023',
      // w07
      'Tuesday, October 3, 2023': 'Wednesday, October 4, 2023',
      // w08
      'Tuesday, October 17, 2023': 'Wednesday, October 18, 2023',
      // w09
      'Tuesday, October 24, 2023': 'Wednesday, October 25, 2023'
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
