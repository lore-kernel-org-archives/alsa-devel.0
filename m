From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0000131]: Sound is very bad in kernel 2.6.* with Intel 82801CA/CAM AC'97 Audio
Date: Fri, 1 Apr 2005 22:55:59 +0200
Message-ID: <f52d83ca5dbd736bf904837df3497c41@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [82.113.61.162])
	by alsa.alsa-project.org (ALSA's E-mail Delivery System) with ESMTP id 6392C235
	for <alsa-devel@alsa-project.org>; Fri,  1 Apr 2005 22:55:59 +0200 (MEST)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=131> 
======================================================================
Reported By:                Ahmad
Assigned To:                
======================================================================
Project:                    ALSA - driver
Issue ID:                   131
Category:                   PCI - intel8x0
Reproducibility:            always
Severity:                   block
Priority:                   normal
Status:                     new
Distribution:               Gentoo
Kernel Version:             2.6.3
======================================================================
Date Submitted:             03-13-2004 19:42 CET
Last Modified:              04-01-2005 22:55 CEST
======================================================================
Summary:                    Sound is very bad in kernel 2.6.* with Intel
82801CA/CAM AC'97 Audio
Description: 
Using Alsa in kernel 2.6.* with Intel 82801CA/CAM AC'97 Audio gives me very
bad sound and produce many many errors in /var/log/messages

======================================================================

----------------------------------------------------------------------
 perex - 03-15-04 12:11 
----------------------------------------------------------------------
Sorry, it's only guess. Please, try it and let me know. If it helps, it's
ACPI bug and it should be reported to the ACPI group.

----------------------------------------------------------------------
 jdthood - 04-01-05 22:55 
----------------------------------------------------------------------
Submitter: Did you see any improvement with "acpi=off"?  Does the problem
still exist in later versions of the ALSA driver?

Issue History
Date Modified  Username       Field                    Change              
======================================================================
03-13-04 19:42 Ahmad          New Issue                                    
03-13-04 19:42 Ahmad          Distribution              => Gentoo          
03-13-04 19:42 Ahmad          Kernel Version            => 2.6.3           
03-14-04 19:45 perex          Note Added: 0000602                          
03-14-04 19:45 perex          Category                 CORE - pcm => PCI -
intel8x0
03-15-04 05:07 Ahmad          Note Added: 0000607                          
03-15-04 12:11 perex          Note Added: 0000608                          
04-20-04 20:07 ilia           Issue Monitored: ilia                        
04-20-04 20:11 ilia           Note Added: 0000889                          
04-20-04 20:13 ilia           Note Edited: 0000889                         
04-20-04 20:33 ilia           Note Deleted: 0000889                        
04-26-04 22:24 segoh          Issue Monitored: segoh                       
04-01-05 22:55 jdthood        Note Added: 0004295                          
======================================================================




-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
