window.document.addEventListener("DOMContentLoaded", function (event) {
  const sectionKey = 'dsan5000-section';
  
  // Dark / light mode switch
  window.toggleSectionClicked = (sectionStr) => {
    console.log("window.toggleSelectionClicked: " + sectionStr);
    applyToggleSection(sectionStr);
  };

  const defaultSection = "02";
  const getSection = () => {
    if (localStorage.getItem(sectionKey) === null) {
      setSection(defaultSection);
    }
    return localStorage.getItem(sectionKey);
  }

  const setSection = (secStr) => {
    localStorage.setItem(sectionKey, secStr);
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
      start: '12:30pm'
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
      start: '12:30pm'
    }
  }

  const applyToggleSection = (newStr) => {
    console.log("Changing to " + newStr);
    setSection(newStr);
    $('.sec-num').text(newStr);
    let sData = sectionData[newStr];
    $('.sec-day').text(sData.day);
    $('.sec-day-full').text(sData.dayFull);
    $('.sec-time').text(sData.time);
    $('.sec-room').text(sData.room);
    // Times
    $('.sec-start').text(sData.start);
    // And the weekly dates
    $('.sec-w01-date').text(sData.w01Date);
    $('.sec-w02-date').text(sData.w02Date);
    $('.sec-w03-date').text(sData.w03Date);
    $('.sec-w04-date').text(sData.w04Date);
    $('.sec-w05-date').text(sData.w05Date);
  }

  let localStorageChecked = false;
  if (!localStorageChecked) {
    let curSection = getSection();
    let radioSelector = `#btn-radio-${curSection}`;
    let radioElt = $(radioSelector);
    if (radioElt.length) {
      radioElt.click();
    } else {
      applyToggleSection(curSection);
    }
    //applyToggleSection(curSection);
    localStorageChecked = true;
  }


});
