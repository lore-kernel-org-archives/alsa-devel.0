From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0001307]: cs46xx module load error with kernel 2.6.13-rc5
Date: Wed, 3 Aug 2005 18:25:33 +0200
Message-ID: <fc8284f7c9f9f0e0957b0e490740ba7c@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [82.113.61.162])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 81BF7165
	for <alsa-devel@alsa-project.org>; Wed,  3 Aug 2005 18:25:33 +0200 (MEST)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=1307> 
======================================================================
Reported By:                jfeise
Assigned To:                
======================================================================
Project:                    ALSA - driver
Issue ID:                   1307
Category:                   PCI - cs46xx
Reproducibility:            always
Severity:                   major
Priority:                   normal
Status:                     new
Distribution:               Slackware 10.1
Kernel Version:             2.6.13-rc5
======================================================================
Date Submitted:             08-03-2005 18:25 CEST
Last Modified:              08-03-2005 18:25 CEST
======================================================================
Summary:                    cs46xx module load error with kernel 2.6.13-rc5
Description: 
Using Slackware 10.1 with kernel 2.6.13-rc5, the cs46xx module is not
loaded and reports lots of unknown symbols in dmesg. See the attached file
with the dmesg output.
I am using ALSA 1.0.9a.
On the same machine, using kernel 2.6.10, everything works.

======================================================================

Issue History
Date Modified  Username       Field                    Change              
======================================================================
08-03-05 18:25 jfeise         New Issue                                    
08-03-05 18:25 jfeise         File Added: cs46xx.out                       
08-03-05 18:25 jfeise         Distribution              => Slackware 10.1  
08-03-05 18:25 jfeise         Kernel Version            => 2.6.13-rc5      
======================================================================




-------------------------------------------------------
SF.Net email is sponsored by: Discover Easy Linux Migration Strategies
from IBM. Find simple to follow Roadmaps, straightforward articles,
informative Webcasts and more! Get everything you need to get up to
speed, fast. http://ads.osdn.com/?ad_id=7477&alloc_id=16492&op=click
