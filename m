From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0000689]: No Optical output/toslink on riser card for Envy 24PT onboard
Date: Mon, 29 Nov 2004 02:17:44 +0100
Message-ID: <7bd516cafb79f9f7adc736013a3ef64d@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [82.113.61.162])
	by alsa.alsa-project.org (ALSA's E-mail Delivery System) with ESMTP id C0DB022E
	for <alsa-devel@alsa-project.org>; Mon, 29 Nov 2004 02:17:44 +0100 (MET)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=689> 
======================================================================
Reported By:                bana
Assigned To:                
======================================================================
Project:                    ALSA - driver
Issue ID:                   689
Category:                   PCI - ice1724
Reproducibility:            always
Severity:                   minor
Priority:                   normal
Status:                     new
Distribution:               Fedora Core
Kernel Version:             2.6.9
======================================================================
Date Submitted:             11-29-2004 02:17 CET
Last Modified:              11-29-2004 02:17 CET
======================================================================
Summary:                    No Optical output/toslink on riser card for Envy
24PT onboard
Description: 
After getting my sound working for my headphones for my onboard Envy24PT
soundcard (on a Chaintech ZNF5-150) my optical isn't working (has never
worked). It is on a riser card off of the motherboard (a CNR slot type
card) that came with the motherboard. I have tried the different outputs
by alsaplay -D hw:0,x /home/bana/test.wav but the only thing that works is
putting in default. 
======================================================================

Issue History
Date Modified  Username       Field                    Change              
======================================================================
11-29-04 02:17 bana           New Issue                                    
11-29-04 02:17 bana           Distribution              => Fedora Core     
11-29-04 02:17 bana           Kernel Version            => 2.6.9           
======================================================================




-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now. 
http://productguide.itmanagersjournal.com/
