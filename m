From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0000669]: Creative SB Live! 24-bit External (USB) works only at a minimal level.
Date: Tue, 23 Nov 2004 21:09:54 +0100
Message-ID: <be9038fb5d310e9a1e4b4e74bbfe4deb@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [82.113.61.162])
	by alsa.alsa-project.org (ALSA's E-mail Delivery System) with ESMTP id 5C6EA2BF
	for <alsa-devel@alsa-project.org>; Tue, 23 Nov 2004 21:09:54 +0100 (MET)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=669> 
======================================================================
Reported By:                Henni
Assigned To:                Clemens Ladisch
======================================================================
Project:                    ALSA - driver
Issue ID:                   669
Category:                   USB - usb-audio
Reproducibility:            always
Severity:                   feature
Priority:                   normal
Status:                     assigned
Distribution:               Gentoo 2004.3
Kernel Version:             2.6.9-cko3
======================================================================
Date Submitted:             11-23-2004 19:23 CET
Last Modified:              11-23-2004 21:09 CET
======================================================================
Summary:                    Creative SB Live! 24-bit External (USB) works only
at a minimal level.
Description: 
The Creative SB Live! 24-bit External is a "card" similar to the Audigy 2
NX (probably its litte brother).

With the snd-usb-audio the ''only'' thing working is the stereo output. I
read that the Audigy 2 NX works far better with the snd-usb-audio.
Probably there is a way to get the SB Live! 24-bit on a similar lvl?

PS: I added some informations about it as an attachment.

======================================================================

----------------------------------------------------------------------
 pzad - 11-23-04 21:09 
----------------------------------------------------------------------
Hmm, did you tryed alsamixer ??? because there is capture volume too.

Issue History
Date Modified  Username       Field                    Change              
======================================================================
11-23-04 19:23 Henni          New Issue                                    
11-23-04 19:23 Henni          File Added: output.txt                       
11-23-04 19:23 Henni          Distribution              => Gentoo 2004.3   
11-23-04 19:23 Henni          Kernel Version            => 2.6.9-cko3      
11-23-04 19:58 Henni          Issue Monitored: Henni                       
11-23-04 21:09 pzad           Note Added: 0002527                          
======================================================================




-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now. 
http://productguide.itmanagersjournal.com/
