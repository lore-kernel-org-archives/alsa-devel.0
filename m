From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0000664]: ac97_quirk with SIS 7012 [ALC202] don't permit to have sound from the headphones, only internal speakers work.
Date: Mon, 22 Nov 2004 18:29:22 +0100
Message-ID: <3208b622824058f5ab1efdb9fb38ab57@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [82.113.61.162])
	by alsa.alsa-project.org (ALSA's E-mail Delivery System) with ESMTP id 1A8582A5
	for <alsa-devel@alsa-project.org>; Mon, 22 Nov 2004 18:29:23 +0100 (MET)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=664> 
======================================================================
Reported By:                ignition
Assigned To:                
======================================================================
Project:                    ALSA - driver
Issue ID:                   664
Category:                   PCI - intel8x0
Reproducibility:            always
Severity:                   feature
Priority:                   normal
Status:                     new
Distribution:               GNU/Linux Slackware 10.0
Kernel Version:             2.4.28
======================================================================
Date Submitted:             11-22-2004 18:29 CET
Last Modified:              11-22-2004 18:29 CET
======================================================================
Summary:                    ac97_quirk with SIS 7012 [ALC202] don't permit to
have sound from the headphones, only internal speakers work.
Description: 
module: intel8x0
card: SiS SI7012
chip: Realtek ALC202 rev 0

All ok but when I plug a jack from the headphones (or hi-fi system), there
is no sound.
And when I plug a jack halfway, I hear mono sound with bad quality from
internal speaker AND from the headphones.
======================================================================

Issue History
Date Modified  Username       Field                    Change              
======================================================================
11-22-04 18:29 ignition       New Issue                                    
11-22-04 18:29 ignition       File Added: report                           
11-22-04 18:29 ignition       Distribution              => GNU/Linux Slackware
10.0
11-22-04 18:29 ignition       Kernel Version            => 2.4.28          
======================================================================




-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now. 
http://productguide.itmanagersjournal.com/
