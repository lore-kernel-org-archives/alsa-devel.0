From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0000435]: No current support for the ICH6R & ALC880 devices
Date: Sun, 12 Dec 2004 14:02:47 +0100
Message-ID: <34321cccf021f24771ccdcd527fddf8f@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [82.113.61.162])
	by alsa.alsa-project.org (ALSA's E-mail Delivery System) with ESMTP id AAF602AF
	for <alsa-devel@alsa-project.org>; Sun, 12 Dec 2004 14:02:47 +0100 (MET)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=435> 
======================================================================
Reported By:                snaketails
Assigned To:                
======================================================================
Project:                    ALSA - driver
Issue ID:                   435
Category:                   PCI - intel8x0
Reproducibility:            always
Severity:                   feature
Priority:                   normal
Status:                     new
Distribution:               Gentoo
Kernel Version:             2.6.7
======================================================================
Date Submitted:             08-12-2004 02:50 CEST
Last Modified:              12-12-2004 14:02 CET
======================================================================
Summary:                    No current support for the ICH6R & ALC880 devices
Description: 
As this is a new mobo, there is no driver configuration that supports this
newer buss interface devices, so there is no sound from the mobo.
The inability for the mobo to run SATA under Linux is not an issue here,
as I am using the SiS SATA driver, only issue is sound
======================================================================

----------------------------------------------------------------------
 snaketails - 08-23-04 06:33 
----------------------------------------------------------------------
Is there any way I could help with this driver?

I will test any mods that have been done, unfortunatly I guess I don't
know enough about doing C programming (only what I did for school in the
late '80s)

----------------------------------------------------------------------
 jdthood - 12-12-04 14:02 
----------------------------------------------------------------------
"Crackling sound" also reported at http://bugs.debian.org/281546

Issue History
Date Modified  Username       Field                    Change              
======================================================================
08-12-04 02:50 snaketails     New Issue                                    
08-12-04 02:50 snaketails     Distribution              => Gentoo          
08-12-04 02:50 snaketails     Kernel Version            => 2.6.7           
08-12-04 07:32 pzad           Note Added: 0001551                          
08-13-04 02:03 snaketails     Note Added: 0001560                          
08-16-04 06:01 snaketails     Note Added: 0001569                          
08-18-04 04:28 snaketails     Note Added: 0001575                          
08-18-04 11:53 tiwai          Note Added: 0001576                          
08-23-04 06:33 snaketails     Note Added: 0001610                          
12-12-04 14:02 jdthood        Note Added: 0002815                          
======================================================================




-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now. 
http://productguide.itmanagersjournal.com/
