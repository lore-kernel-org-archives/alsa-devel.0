From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0002201]: Duplicate of Issue 0001622 -
	Sound freezes after less a second of play
Date: Mon, 12 Jun 2006 04:15:16 +0200
Message-ID: <690d82d14bd83bd8da88fb226dc406ab@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 5AFFA149
	for <alsa-devel@alsa-project.org>;
	Mon, 12 Jun 2006 04:15:16 +0200 (MEST)
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: alsa-devel-bounces@lists.sourceforge.net
Errors-To: alsa-devel-bounces@lists.sourceforge.net
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org


A NOTE has been added to this issue.
======================================================================
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=2201> 
======================================================================
Reported By:                ggeorgak
Assigned To:                
======================================================================
Project:                    ALSA - driver
Issue ID:                   2201
Category:                   PCI - via82xx
Reproducibility:            always
Severity:                   block
Priority:                   normal
Status:                     new
Distribution:               OpenSuSE
Kernel Version:             2.6.16.13-4-smp
======================================================================
Date Submitted:             06-12-2006 02:55 CEST
Last Modified:              06-12-2006 04:15 CEST
======================================================================
Summary:                    Duplicate of Issue 0001622 - Sound freezes after
less a second of play
Description: 
It's a duplicate of issue 0001622, though that issue is marked as resolved
and the patch is upstreamed to newer versions of alsa (1.0.9 mentioned
there). Again the motheroboard is Asus A8V-MX with onboard Realtek AC97
sound chip. Glady I will provide any information asked.
======================================================================

----------------------------------------------------------------------
 rlrevell - 06-12-06 03:07 
----------------------------------------------------------------------
What is the output of "cat /proc/asound/version"?

----------------------------------------------------------------------
 ggeorgak - 06-12-06 04:15 
----------------------------------------------------------------------
Advanced Linux Sound Architecture Driver Version 1.0.11rc3 (Sun Jan 22
09:27:15 2006 UTC).

Issue History
Date Modified  Username       Field                    Change              
======================================================================
06-12-06 02:55 ggeorgak       New Issue                                    
06-12-06 02:55 ggeorgak       Distribution              => OpenSuSE        
06-12-06 02:55 ggeorgak       Kernel Version            => 2.6.16.13-4-smp 
06-12-06 02:56 ggeorgak       Issue Monitored: ggeorgak                    
06-12-06 03:07 rlrevell       Note Added: 0010156                          
06-12-06 04:15 ggeorgak       Note Added: 0010159                          
======================================================================
