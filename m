From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0000918]: Behringer BCA-2000
Date: Mon, 28 Feb 2005 18:15:07 +0100
Message-ID: <2d4c14d5d725c2fee0e250a8d6116035@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Received: from bugtrack.alsa-project.org (gate.perex.cz [82.113.61.162])
	by alsa.alsa-project.org (ALSA's E-mail Delivery System) with ESMTP id 9904421C
	for <alsa-devel@alsa-project.org>; Mon, 28 Feb 2005 18:15:07 +0100 (MET)
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


The following issue has been set as DUPLICATE OF issue 0000941.
======================================================================
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=918> 
======================================================================
Reported By:                billwest00
Assigned To:                Clemens Ladisch
======================================================================
Project:                    ALSA - driver
Issue ID:                   918
Category:                   USB - usb-audio
Reproducibility:            N/A
Severity:                   minor
Priority:                   normal
Status:                     assigned
Distribution:               Demudi 1.2.1
Kernel Version:             2.4
======================================================================
Date Submitted:             02-18-2005 00:43 CET
Last Modified:              02-28-2005 18:15 CET
======================================================================
Summary:                    Behringer BCA-2000
Description: 
My appologies if this is not the correct forum.  I use Agnula Demudi 1.2.1.
 I recently purchased Behringer's new usb2.0 interface.  I added
snd-usb-audio to the /etc/modules file.  The device is not claimed by any
driver on restart.  I actually did not expect it to work, being so new.  I
just wanted to let you know that this device does not appear to work with
Demudi.

--Thanks!
Bill West
======================================================================
Relationships       ID      Summary
----------------------------------------------------------------------
duplicate of        0000941 Behringer BCA 2000 USB device not recog...
======================================================================

----------------------------------------------------------------------
 Clemens Ladisch - 02-18-05 09:34 
----------------------------------------------------------------------
Please show the output of "lsusb -v".

Issue History
Date Modified  Username       Field                    Change              
======================================================================
02-18-05 00:43 billwest00     New Issue                                    
02-18-05 00:43 billwest00     Distribution              => Demudi 1.2.1    
02-18-05 00:43 billwest00     Kernel Version            => 2.4             
02-18-05 09:34 Clemens LadischNote Added: 0003648                          
02-18-05 16:28 billwest00     Issue Monitored: billwest00                    
02-28-05 18:15 Clemens LadischRelationship added       duplicate of 0000941
======================================================================




-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
