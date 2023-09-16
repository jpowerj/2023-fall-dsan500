window.document.addEventListener("DOMContentLoaded", function (event) {

const hasAlternateSentinel = () => {  
    let sectionSentinel = getSectionSentinel();
    if (sectionSentinel !== null) {
      return sectionSentinel === "alternate";
    } else {
      return false;
    }
  }

  const setSectionSentinel = (alternate) => {
    const value = alternate ? "alternate" : "default";
    if (!isFileUrl()) {
      window.localStorage.setItem("dsan5000-section", value);
    } else {
      localAlternateSentinel = value;
    }
  }

  

  const getSectionSentinel = () => {
    if (!isFileUrl()) {
      const storageValue = window.localStorage.getItem("dsan5000-section");
      return storageValue != null ? storageValue : localAlternateSentinel;
    } else {
      return localAlternateSentinel;
    }
  }

  const sectionDefault = false;
  let localAlternateSentinel = sectionDefault ? 'alternate' : 'default';

// Dark / light mode switch
window.quartoToggleSection = () => {
    // Read the current section value 
    let toAlternate = !hasAlternateSentinel();
    toggleSection(toAlternate);
    setSectionSentinel(toAlternate);
    //toggleGiscusIfUsed(toAlternate, darkModeDefault);
};

const isFileUrl = () => { 
    return window.location.protocol === 'file:';
  }

const toggleSection = (alternate) => {
  // Switch the stylesheets
  manageTransitions('#quarto-margin-sidebar .nav-link', false);
  if (alternate) {
    console.log("Section 03");
  } else {
    console.log("Section 02");
  }
  manageTransitions('#quarto-margin-sidebar .nav-link', true);

  // Switch the toggles
  const toggles = window.document.querySelectorAll('.dsan5000-section-toggle');
  for (let i=0; i < toggles.length; i++) {
    const toggle = toggles[i];
    if (toggle) {
      if (alternate) {
        toggle.classList.add("alternate");     
      } else {
        toggle.classList.remove("alternate");
      }
    }
  }

  // Hack to workaround the fact that safari doesn't
  // properly recolor the scrollbar when toggling (#1455)
  if (navigator.userAgent.indexOf('Safari') > 0 && navigator.userAgent.indexOf('Chrome') == -1) {
    manageTransitions("body", false);
    window.scrollTo(0, 1);
    setTimeout(() => {
      window.scrollTo(0, 0);
      manageTransitions("body", true);
    }, 40);  
  }
}

// Switch to dark mode if need be
if (hasAlternateSentinel()) {
  toggleSection(true);
} else {
  toggleSection(false);
}


});
