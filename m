From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0000696]: Doom 3 crashes when using alsa
Date: Wed, 1 Dec 2004 20:18:50 +0100
Message-ID: <d7f29f02103b6a6c2419f81002844d8c@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [82.113.61.162])
	by alsa.alsa-project.org (ALSA's E-mail Delivery System) with ESMTP id DECB7231
	for <alsa-devel@alsa-project.org>; Wed,  1 Dec 2004 20:18:50 +0100 (MET)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=696> 
======================================================================
Reported By:                Mo6eB
Assigned To:                
======================================================================
Project:                    ALSA - driver
Issue ID:                   696
Category:                   PCI - intel8x0
Reproducibility:            always
Severity:                   minor
Priority:                   normal
Status:                     new
Distribution:               Gentoo
Kernel Version:             2.6.9
======================================================================
Date Submitted:             12-01-2004 20:18 CET
Last Modified:              12-01-2004 20:18 CET
======================================================================
Summary:                    Doom 3 crashes when using alsa
Description: 
Doom 3 crashes with the following error message:
snd_pcm_writei short write: 4095 out of 4096
snd_pcm_writei short write: 4095 out of 4096
doom.x86: pcm.c:5957: snd_pcm_mmap_commit: Assertion `frames <=
snd_pcm_mmap_avail(pcm)' failed.
signal caught: Aborted

======================================================================

Issue History
Date Modified  Username       Field                    Change              
======================================================================
12-01-04 20:18 Mo6eB          New Issue                                    
12-01-04 20:18 Mo6eB          Distribution              => Gentoo          
12-01-04 20:18 Mo6eB          Kernel Version            => 2.6.9           
======================================================================




-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now. 
http://productguide.itmanagersjournal.com/
