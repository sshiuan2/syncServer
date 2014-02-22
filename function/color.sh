#!/bin/bash
# Text color variables
tputUnderline=$(tput sgr 0 1)          # Underline
tputBold=$(tput bold)             # Bold
tputRed=$(tput setaf 1) #  red
tputGreen=$(tput setaf 2)
textGreen="\033[38;5;148m"
#example echo -e "My favorite color is \033[38;5;148mYellow-Green\033[39mRESET"
tputYellow=$(tput setaf 3)
tputBlue=$(tput setaf 4) #  blue
tputPurple=$(tput setaf 5)
tputLightBlue=$(tput setaf 6)
tputWhite=$(tput setaf 7) #  white
tputReset=$(tput sgr0)             # Reset
logINFO=${tputBold}${tputGreen}[INFO]${tputReset}        # Feedback
logPASS=${tputBold}${tputBlue}[PASS]${tputReset}
logWARNING=${tputBold}${tputRed}[WARNING]${tputReset}
logQUESTION=${tputBold}${tputBlue}[QUESTION]${tputReset}
