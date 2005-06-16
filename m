From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0001196]: my soundcard is not detected and irritating me
Date: Thu, 16 Jun 2005 12:52:53 +0200
Message-ID: <b4d9aac1b5d5c75e79e812f88c462d54@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [82.113.61.162])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 7425D186
	for <alsa-devel@alsa-project.org>; Thu, 16 Jun 2005 12:52:53 +0200 (MEST)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=1196> 
======================================================================
Reported By:                sai prasad
Assigned To:                perex
======================================================================
Project:                    ALSA - driver
Issue ID:                   1196
Category:                   0_compilation problem_!!!
Reproducibility:            always
Severity:                   major
Priority:                   normal
Status:                     assigned
Distribution:               
Kernel Version:             kernel-2.6.5-1.358smp
======================================================================
Date Submitted:             06-16-2005 12:52 CEST
Last Modified:              06-16-2005 12:52 CEST
======================================================================
Summary:                    my soundcard is not detected and irritating me
Description: 
I have downloaded alsa-1.0.9rc4a.
I followed the following steps:
1: bunzip2 alsa-1.0.9rc4a.tar.bz2
2: tar xvf alsa-1.0.9rc4a.tar
3: cd alsa-1.0.9rc4a
4: 1.

      The driver: "./configure --with-oss=yes --with-cards=hda-intel",
then "make", and "sudo make install".
   2.

      The library, oss-lib, and utils - simply "./configure" "make" "sudo
make install"
   3.

      Run "sudo alsaconf" and configure the sound card.
   4.

      Reboot.
Some of the above are failed
Still  i have not succeeded
I get vexed
Please help me
======================================================================

Issue History
Date Modified  Username       Field                    Change              
======================================================================
06-16-05 12:52 sai prasad     New Issue                                    
06-16-05 12:52 sai prasad     Kernel Version            => kernel-2.6.5-1.358smp
======================================================================




-------------------------------------------------------
SF.Net email is sponsored by: Discover Easy Linux Migration Strategies
from IBM. Find simple to follow Roadmaps, straightforward articles,
informative Webcasts and more! Get everything you need to get up to
speed, fast. http://ads.osdn.com/?ad_id=7477&alloc_id=16492&op=click
