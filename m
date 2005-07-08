From: bugtrack@alsa-project.org
Subject: [ALSA - utils 0000798]: Make alsaconf optinal able to create an asound.conf
Date: Fri, 8 Jul 2005 10:35:27 +0200
Message-ID: <e72c2f9389c86a8a28dc733e59d71da3@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [82.113.61.162])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 6D0F717A
	for <alsa-devel@alsa-project.org>; Fri,  8 Jul 2005 10:35:27 +0200 (MEST)
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


The following issue has been CLOSED
======================================================================
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=798> 
======================================================================
Reported By:                christeck
Assigned To:                
======================================================================
Project:                    ALSA - utils
Issue ID:                   798
Category:                   alsaconf
Reproducibility:            always
Severity:                   feature
Priority:                   normal
Status:                     closed
Resolution:                 won't fix
Fixed in Version:           
======================================================================
Date Submitted:             01-09-2005 22:05 CET
Last Modified:              07-08-2005 10:35 CEST
======================================================================
Summary:                    Make alsaconf optinal able to create an asound.conf
Description: 
An asound.conf is difficult to create manually due to its difficult to
understand syntax. Would be great if alsaconf could optional create it, so
the user can

* Define in which order the cards appear (e.g., internal AC97, Modem,
USB-Audio and an USB MIDI card)

* Define some dmix devices

* Else? Not familiar enough with dmix, I do not use it :)
======================================================================

----------------------------------------------------------------------
 christeck - 01-19-05 18:33 
----------------------------------------------------------------------
You're certainly right, but it seems that I cannot close this entry; I
guess you have permissions, can you please close this entry?

Thanks and sorry for the traffic :) .

----------------------------------------------------------------------
 tiwai - 01-19-05 18:38 
----------------------------------------------------------------------
OK, closing now.

Issue History
Date Modified  Username       Field                    Change              
======================================================================
01-09-05 22:05 christeck      New Issue                                    
01-19-05 15:29 jdthood        Note Added: 0003287                          
01-19-05 16:48 tiwai          Note Added: 0003293                          
01-19-05 16:54 jdthood        Note Added: 0003297                          
01-19-05 16:56 tiwai          Note Added: 0003298                          
01-19-05 18:33 christeck      Note Added: 0003309                          
01-19-05 18:38 tiwai          Status                   new => resolved     
01-19-05 18:38 tiwai          Resolution               open => won't fix   
01-19-05 18:38 tiwai          Assigned To               => tiwai           
01-19-05 18:38 tiwai          Note Added: 0003312                          
01-19-05 18:38 tiwai          Assigned To              tiwai =>            
07-08-05 10:35 perex          Status                   resolved => closed  
======================================================================




-------------------------------------------------------
This SF.Net email is sponsored by the 'Do More With Dual!' webinar happening
July 14 at 8am PDT/11am EDT. We invite you to explore the latest in dual
core and dual graphics technology at this free one hour event hosted by HP, 
AMD, and NVIDIA.  To register visit http://www.hp.com/go/dualwebinar
