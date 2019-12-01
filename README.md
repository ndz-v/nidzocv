# My CV Template

<!--
command to convert a pdf page to png
convert -density 200 main.pdf\[\0] -quality 100 -background white -flatten coverletter.png
-->

## How to use

Fill main.tex, sidebar.tex and maincontent.tex with information and build it.

### Example for main information in main.tex

```latex
\setfirstName{Vorname}
\setlastName{Nachname}
\setAddress{Musterstrasse 30}
\setZipcode{12345}
\setCity{Musterstadt}
\setEmail{vorname.nachname@mail.de}
\setPhone{+49 162 1234 567}

\setPicture{media/profilepic.png}
\setSignaturePicture{media/signatur.png}

\setPosition{Position Stelle}
\setjobofferlocation{Stellenanzeige auf \href{www.googl.de}{google.de}\\}
\setPositionId{Position ID}

\setCompanyName{Firmenname}
\setCompanyAddress{Musterstr. 2}
\setCompanyZip{12345}
\setCompanyCity{Musterstadt}
```

<img src="https://github.com/nidzov/nidzocv/blob/master/media/coverletter.png" width="400">

<img src="https://github.com/nidzov/nidzocv/blob/master/media/cv.png" width="400">
