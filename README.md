# My CV Template

<!--
command to convert a pdf page to png
convert -density 200 main.pdf\[\0] -quality 100 -background white -flatten coverletter.png
-->

Coverletter             |  CV
:-------------------------:|:-------------------------:
![](https://github.com/nidzov/nidzocv/blob/master/media/coverletter.png)  |  ![](https://github.com/nidzov/nidzocv/blob/master/media/cv.png)

## How to use

Fill main.tex, cvsidebar.tex and cvbody.tex with information and build it.

### Example for main information in main.tex

```latex
\setFirstName{Vorname}
\setLastName{Nachname}
\setAddress{Musterstrasse 30}
\setZipcode{12345}
\setCity{Musterstadt}
\setEmail{vorname.nachname@mail.de}
\setPhone{+49 162 1234 567}

\setPicture{media/profilepic.png}
\setSignaturePicture{media/signatur.png}

\setCompanyName{Firmenname}
\setContactPerson{Kontakt Person\\}
\setCompanyAddress{Musterstr. 2}
\setCompanyZip{12345}
\setCompanyCity{Musterstadt}
\setPosition{Bewerber}

\setJobofferURL{Stelle auf google.de,}
\setPositionId{Job ID 1234}
```
