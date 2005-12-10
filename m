From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0001639]: No proper mixer for Aureon Mk II
Date: Sat, 10 Dec 2005 21:03:51 +0100
Message-ID: <73bd37358ca4ae0dfb7b6ccc1dc84597@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 09F0216F
	for <alsa-devel@alsa-project.org>; Sat, 10 Dec 2005 21:03:51 +0100 (MET)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=1639> 
======================================================================
Reported By:                Nikratio
Assigned To:                Clemens Ladisch
======================================================================
Project:                    ALSA - driver
Issue ID:                   1639
Category:                   USB - usb-audio
Reproducibility:            always
Severity:                   major
Priority:                   normal
Status:                     assigned
Distribution:               Ubuntu Breezy
Kernel Version:             Linux nokile 2.6.12-10-686 #1 Fri Nov 18 12:09:04
UTC 2005 i686 GNU/Linux
======================================================================
Date Submitted:             12-10-2005 21:03 CET
Last Modified:              12-10-2005 21:03 CET
======================================================================
Summary:                    No proper mixer for Aureon Mk II
Description: 
My aureon produces fine sound, but unfortunately I'm not really able to
control it: Alsamixer offers me the controls "PCM", "Speaker" and
"Speaker" (yes, same name). Only one of the speaker controls has any
effect at all. Unfortunately it's mono and I can't control the channels
independently. I'd be really glad if there were some more useful controls
with more useful names :-).


======================================================================

Issue History
Date Modified  Username       Field                    Change              
======================================================================
12-10-05 21:03 Nikratio       New Issue                                    
12-10-05 21:03 Nikratio       Distribution              => Ubuntu Breezy   
12-10-05 21:03 Nikratio       Kernel Version            => Linux nokile
2.6.12-10-686 #1 Fri Nov 18 12:09:04 UTC 2005 i686 GNU/Linux
======================================================================




-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://ads.osdn.com/?ad_id=7637&alloc_id=16865&op=click
