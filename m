From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0000885]: usx2y is unsupported in v 1.08 builds
Date: Fri, 11 Feb 2005 17:22:30 +0100
Message-ID: <230c8f93c495d488885b0614d94f100e@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Received: from bugtrack.alsa-project.org (gate.perex.cz [82.113.61.162])
	by alsa.alsa-project.org (ALSA's E-mail Delivery System) with ESMTP id B5C1C1AF
	for <alsa-devel@alsa-project.org>; Fri, 11 Feb 2005 17:22:30 +0100 (MET)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=885> 
======================================================================
Reported By:                hamishtpb
Assigned To:                karsten
======================================================================
Project:                    ALSA - driver
Issue ID:                   885
Category:                   USB - usb-usx2y
Reproducibility:            always
Severity:                   major
Priority:                   normal
Status:                     assigned
Distribution:               Gentoo 2004.3
Kernel Version:             2.4.28-Gentoo-r5
======================================================================
Date Submitted:             02-06-2005 05:57 CET
Last Modified:              02-11-2005 17:22 CET
======================================================================
Summary:                    usx2y is unsupported in v 1.08 builds
Description: 
Whever I try to build any 1.0.8 alsa-driver I get "unsupported card error"
when I set usb-usx2y as my card. I have manually installed 1.0.7 and the
compile went smoothly.
======================================================================

----------------------------------------------------------------------
 Clemens Ladisch - 02-11-05 15:42 
----------------------------------------------------------------------
Are you using a 64-bit system?

----------------------------------------------------------------------
 hamishtpb - 02-11-05 17:22 
----------------------------------------------------------------------
No - I am using an Athlon XP 2400+ (2GHz).

Issue History
Date Modified  Username       Field                    Change              
======================================================================
02-06-05 05:57 hamishtpb      New Issue                                    
02-06-05 05:57 hamishtpb      Distribution              => Gentoo 2004.3   
02-06-05 05:57 hamishtpb      Kernel Version            => 2.4.28-Gentoo-r5
02-06-05 05:57 hamishtpb      Issue Monitored: hamishtpb                    
02-06-05 15:53 hamishtpb      Note Added: 0003525                          
02-09-05 11:55 tiwai          Note Added: 0003545                          
02-09-05 12:23 hamishtpb      Note Added: 0003549                          
02-09-05 12:44 hamishtpb      Note Added: 0003551                          
02-09-05 12:53 hamishtpb      Note Edited: 0003551                         
02-11-05 15:42 Clemens LadischNote Added: 0003564                          
02-11-05 17:22 hamishtpb      Note Added: 0003565                          
======================================================================




-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
