From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0000913]: subwoofer not working
Date: Thu, 17 Feb 2005 20:31:49 +0100
Message-ID: <112cdab47ebb2ec9ca2e49a4ec25ffb5@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Received: from bugtrack.alsa-project.org (gate.perex.cz [82.113.61.162])
	by alsa.alsa-project.org (ALSA's E-mail Delivery System) with ESMTP id C353A269
	for <alsa-devel@alsa-project.org>; Thu, 17 Feb 2005 20:31:49 +0100 (MET)
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


A NOTE has been added to this issue.
======================================================================
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=913> 
======================================================================
Reported By:                matteo
Assigned To:                
======================================================================
Project:                    ALSA - driver
Issue ID:                   913
Category:                   PCI - intel8x0
Reproducibility:            always
Severity:                   minor
Priority:                   normal
Status:                     new
Distribution:               debian/sarge
Kernel Version:             2.6.11-rc4
======================================================================
Date Submitted:             02-16-2005 19:39 CET
Last Modified:              02-17-2005 20:31 CET
======================================================================
Summary:                    subwoofer not working
Description: 
hi, i got a ASUS W1000 laptop, sound's working now after the latest patch
but i still can't get the subwoofer channel working, any suggestion ?
I can hear it if i play a cd, but not from the pcm!

thx in advance

Matteo

======================================================================

----------------------------------------------------------------------
 tiwai - 02-17-05 20:31 
----------------------------------------------------------------------
Try speaker-test in alsa-utils package whether the PCM output works.

Issue History
Date Modified  Username       Field                    Change              
======================================================================
02-16-05 19:39 matteo         New Issue                                    
02-16-05 19:39 matteo         File Added: ac97registers                    
02-16-05 19:39 matteo         Distribution              => debian/sarge    
02-16-05 19:39 matteo         Kernel Version            => 2.6.11-rc4      
02-17-05 20:31 tiwai          Note Added: 0003637                          
======================================================================




-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
