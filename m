From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0000757]: Noisy recording for oss emulation
Date: Wed, 29 Dec 2004 07:49:24 +0100
Message-ID: <8963bc84333a32d5fae31c07c36e0d3d@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [82.113.61.162])
	by alsa.alsa-project.org (ALSA's E-mail Delivery System) with ESMTP id DB1582A0
	for <alsa-devel@alsa-project.org>; Wed, 29 Dec 2004 07:49:24 +0100 (MET)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=757> 
======================================================================
Reported By:                tomasz_janowski
Assigned To:                
======================================================================
Project:                    ALSA - driver
Issue ID:                   757
Category:                   CORE OSS - pcm
Reproducibility:            always
Severity:                   major
Priority:                   normal
Status:                     new
Distribution:               Fedora Core 2
Kernel Version:             2.6.8.1
======================================================================
Date Submitted:             12-29-2004 07:49 CET
Last Modified:              12-29-2004 07:49 CET
======================================================================
Summary:                    Noisy recording for oss emulation
Description: 
I noticed that when I use arecord for recording on the VT82C686 AC97 Audio
sound card the sound is very good, but using the rec (OSS) program I
always have some additional sounds - static - during recording. I have on
the same computer the Ensoniq ES1371 card and almost identical setup for
it but I haven't similar problems with OSS emulation.
======================================================================

Issue History
Date Modified  Username       Field                    Change              
======================================================================
12-29-04 07:49 tomasz_janowskiNew Issue                                    
12-29-04 07:49 tomasz_janowskiDistribution              => Fedora Core 2   
12-29-04 07:49 tomasz_janowskiKernel Version            => 2.6.8.1         
======================================================================




-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now. 
http://productguide.itmanagersjournal.com/
