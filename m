From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0000937]: No sound unless using OSS driver
Date: Wed, 13 Apr 2005 17:24:04 +0200
Message-ID: <c9d7be625c8bb8dee519880c693ff4f5@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [82.113.61.162])
	by alsa.alsa-project.org (ALSA's E-mail Delivery System) with ESMTP id 68DE323C
	for <alsa-devel@alsa-project.org>; Wed, 13 Apr 2005 17:24:04 +0200 (MEST)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=937> 
======================================================================
Reported By:                ruffasdagut
Assigned To:                
======================================================================
Project:                    ALSA - driver
Issue ID:                   937
Category:                   PCI - via82xx
Reproducibility:            always
Severity:                   crash
Priority:                   normal
Status:                     new
Distribution:               Fedora
Kernel Version:             2.6
======================================================================
Date Submitted:             02-24-2005 01:14 CET
Last Modified:              04-13-2005 17:24 CEST
======================================================================
Summary:                    No sound unless using OSS driver
Description: 
I have no sound from the system unless using the OSS option in gstreamer
properties. If I do this I get sound but no control over the volume or
mute. I dont really need all the digital parts, but just the Basic sound
would be nice. I am going to include the ouput from the alsa debug program
I found online. Thanks for looking into this issue.
======================================================================

----------------------------------------------------------------------
 ruffasdagut - 02-24-05 23:27 
----------------------------------------------------------------------
Either I didnt install the CVS properly or it didnt fix the problem. I have
sound, but no control over the volume. I am not 100% I did the CVS install
correct. Also did I need to remove the version that Fedora put?

----------------------------------------------------------------------
 jdthood - 04-13-05 17:24 
----------------------------------------------------------------------
Submitter: Any improvement in the 1.0.9rc2 release?

Issue History
Date Modified  Username       Field                    Change              
======================================================================
02-24-05 01:14 ruffasdagut    New Issue                                    
02-24-05 01:14 ruffasdagut    File Added: debug.log                        
02-24-05 01:14 ruffasdagut    Distribution              => Fedora          
02-24-05 01:14 ruffasdagut    Kernel Version            => 2.6             
02-24-05 22:00 tiwai          Note Added: 0003725                          
02-24-05 23:27 ruffasdagut    Note Added: 0003730                          
02-24-05 23:29 ruffasdagut    Issue Monitored: ruffasdagut                    
02-24-05 23:29 ruffasdagut    Issue End Monitor: ruffasdagut                    
04-13-05 17:24 jdthood        Note Added: 0004475                          
======================================================================




-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
