From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0000552]: FATAL: Error inserting snd_azx
Date: Mon, 27 Dec 2004 15:48:45 +0100
Message-ID: <1791b4ba266a668b022b8cc0e65a2832@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [82.113.61.162])
	by alsa.alsa-project.org (ALSA's E-mail Delivery System) with ESMTP id 8D9B6244
	for <alsa-devel@alsa-project.org>; Mon, 27 Dec 2004 15:48:45 +0100 (MET)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=552> 
======================================================================
Reported By:                footcow
Assigned To:                tiwai
======================================================================
Project:                    ALSA - driver
Issue ID:                   552
Category:                   PCI - azx
Reproducibility:            always
Severity:                   block
Priority:                   normal
Status:                     closed
Distribution:               Debian
Kernel Version:             2.6.8.1
Resolution:                 fixed
Fixed in Version:           
======================================================================
Date Submitted:             09-30-2004 01:29 CEST
Last Modified:              12-27-2004 15:48 CET
======================================================================
Summary:                    FATAL: Error inserting snd_azx
Description: 
Impossible to make running the AZX Alsa driver on my PC, ASUS P5GD2 Premium
motherbord with 0000:00:1b.0 0403: Intel Corp. 82801FB/FBM/FR/FW/FRW (ICH6
Family) High Definition Audio Controller (rev 03) integrated sound.

======================================================================

----------------------------------------------------------------------
 footcow - 11-23-04 22:01 
----------------------------------------------------------------------
No sorry I put another bug report for last release 1.0.7 ...
https://bugtrack.alsa-project.org/alsa-bug/view.php?id=666

I have no sound, no mixer ... more details in this bug report ...
But since 1.0.7rc2 ... the module loaded do not crash anymore my linux
:o)

But I will be really happy to give you some help for testing with my
configuration (AsusTek P5GD2) ... I really want to get sound ! ;o)

----------------------------------------------------------------------
 rlrevell - 11-23-04 22:04 
----------------------------------------------------------------------
OK then this one should be closed.

Issue History
Date Modified  Username       Field                    Change              
======================================================================
09-30-04 01:29 footcow        New Issue                                    
09-30-04 01:29 footcow        Distribution              => Debian          
09-30-04 01:29 footcow        Kernel Version            => 2.6.8.1         
11-23-04 21:48 footcow        Note Added: 0002529                          
11-23-04 21:54 rlrevell       Note Added: 0002532                          
11-23-04 22:01 footcow        Note Added: 0002533                          
11-23-04 22:04 rlrevell       Note Added: 0002534                          
11-24-04 12:28 tiwai          Status                   new => resolved     
11-24-04 12:28 tiwai          Resolution               open => fixed       
11-24-04 12:28 tiwai          Assigned To               => tiwai           
12-27-04 15:48 tiwai          Status                   resolved => closed  
======================================================================




-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now. 
http://productguide.itmanagersjournal.com/
