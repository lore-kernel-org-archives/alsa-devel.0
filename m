From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0001815]: bass and treble controls do not work properly with soundblaster extigy
Date: Fri, 3 Feb 2006 20:57:21 +0100
Message-ID: <692d086126bf4205ad2599e230937765@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id A04AA195
	for <alsa-devel@alsa-project.org>; Fri,  3 Feb 2006 20:57:21 +0100 (MET)
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org


The following issue has been SUBMITTED.
======================================================================
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=1815> 
======================================================================
Reported By:                ezust
Assigned To:                Clemens Ladisch
======================================================================
Project:                    ALSA - driver
Issue ID:                   1815
Category:                   USB - usb-audio
Reproducibility:            always
Severity:                   minor
Priority:                   normal
Status:                     assigned
Distribution:               debian unstable
Kernel Version:             2.6.14
======================================================================
Date Submitted:             02-03-2006 20:57 CET
Last Modified:              02-03-2006 20:57 CET
======================================================================
Summary:                    bass and treble controls do not work properly with
soundblaster extigy
Description: 
Using kmix or alsamixer, trying to drag the bass and treble controls below
50% does not work - the slider keeps jumping up to the 80%-100% range, so
it is impossible to reduce the output bass level below 50%


======================================================================

Issue History
Date Modified  Username       Field                    Change              
======================================================================
02-03-06 20:57 ezust          New Issue                                    
02-03-06 20:57 ezust          Distribution              => debian unstable 
02-03-06 20:57 ezust          Kernel Version            => 2.6.14          
======================================================================




-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=103432&bid=230486&dat=121642
