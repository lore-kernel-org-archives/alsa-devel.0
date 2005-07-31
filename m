From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0001294]: Alsa soundcard intel8xo does not compile properly with new compiled kernel
Date: Sun, 31 Jul 2005 22:23:05 +0200
Message-ID: <848dd129b3c78d3f8270166ab2c8e283@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [82.113.61.162])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 595A415C
	for <alsa-devel@alsa-project.org>; Sun, 31 Jul 2005 22:23:05 +0200 (MEST)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=1294> 
======================================================================
Reported By:                tanman
Assigned To:                
======================================================================
Project:                    ALSA - driver
Issue ID:                   1294
Category:                   PCI - intel8x0
Reproducibility:            always
Severity:                   minor
Priority:                   normal
Status:                     new
Distribution:               Fedora4
Kernel Version:             2.6.12.3
======================================================================
Date Submitted:             07-31-2005 22:23 CEST
Last Modified:              07-31-2005 22:23 CEST
======================================================================
Summary:                    Alsa soundcard intel8xo does not compile properly
with new compiled kernel
Description: 
The module snd-8x0 produces the following errors once I compiled the kernel
linux-2.6.12.3:

dmesg
snd_intel8x0: Unknown parameter `'
snd_intel8x0: Unknown parameter `'
snd_intel8x0: Unknown parameter `'

Is there anything I have to edit in the configuration files when migrating
to the latest kernel?




======================================================================

Issue History
Date Modified  Username       Field                    Change              
======================================================================
07-31-05 22:23 tanman         New Issue                                    
07-31-05 22:23 tanman         Distribution              => Fedora4         
07-31-05 22:23 tanman         Kernel Version            => 2.6.12.3        
======================================================================




-------------------------------------------------------
SF.Net email is sponsored by: Discover Easy Linux Migration Strategies
from IBM. Find simple to follow Roadmaps, straightforward articles,
informative Webcasts and more! Get everything you need to get up to
speed, fast. http://ads.osdn.com/?ad_id=7477&alloc_id=16492&op=click
