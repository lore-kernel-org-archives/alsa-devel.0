From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0000339]: sound quality terrible on DELL (emu10k1x)
Date: Thu, 16 Dec 2004 18:17:33 +0100
Message-ID: <24ddb395828f2da1a2a46c605ce06d2d@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [82.113.61.162])
	by alsa.alsa-project.org (ALSA's E-mail Delivery System) with ESMTP id F1F0D214
	for <alsa-devel@alsa-project.org>; Thu, 16 Dec 2004 18:17:33 +0100 (MET)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=339> 
======================================================================
Reported By:                bench2
Assigned To:                tiwai
======================================================================
Project:                    ALSA - driver
Issue ID:                   339
Category:                   PCI - emu10k1
Reproducibility:            always
Severity:                   major
Priority:                   normal
Status:                     closed
Distribution:               gentoo
Kernel Version:             2.6.5
Resolution:                 fixed
Fixed in Version:           
======================================================================
Date Submitted:             06-18-2004 17:16 CEST
Last Modified:              12-16-2004 18:17 CET
======================================================================
Summary:                    sound quality terrible on DELL (emu10k1x)
Description: 
I have a DELL with their modded soundblaster card. I have installed the
alsa-driver emu10k1*x* (no such option in category). The sound is
terrible. It often hangs (like a cracked record), often I get the error
message «cannot open /dev/dsp». Sometimes only xine will play a movie
(with sound, I mean), sometime only mplayer, sometimes neither.
======================================================================

----------------------------------------------------------------------
 rlrevell - 11-14-04 00:54 
----------------------------------------------------------------------
please close this bug; the user reports that is is fixed.  besides, this
one should have gone under emu10k1x not emu10k1.

----------------------------------------------------------------------
 tiwai - 11-16-04 16:26 
----------------------------------------------------------------------
Ok, closed now.

Issue History
Date Modified  Username       Field                    Change              
======================================================================
06-18-04 17:16 bench2         New Issue                                    
06-18-04 17:16 bench2         Distribution              => gentoo          
06-18-04 17:16 bench2         Kernel Version            => 2.6.5           
06-19-04 11:25 bench2         Issue Monitored: bench2                      
06-19-04 23:43 bench2         Note Added: 0001322                          
06-20-04 04:58 fmoraes        Note Added: 0001323                          
06-25-04 21:57 bench2         Note Added: 0001338                          
07-06-04 22:08 fmoraes        Note Added: 0001388                          
11-14-04 00:54 rlrevell       Note Added: 0002405                          
11-16-04 16:26 tiwai          Status                   new => resolved     
11-16-04 16:26 tiwai          Resolution               open => fixed       
11-16-04 16:26 tiwai          Assigned To               => tiwai           
11-16-04 16:26 tiwai          Note Added: 0002426                          
12-16-04 18:17 tiwai          Status                   resolved => closed  
======================================================================




-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now. 
http://productguide.itmanagersjournal.com/
