From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0000586]: AC3 pass thru SPDIF has DropOuts
Date: Wed, 10 Nov 2004 23:18:05 +0100
Message-ID: <a58874243f4c363d656ea99636abb501@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [82.113.61.162])
	by alsa.alsa-project.org (ALSA's E-mail Delivery System) with ESMTP id 7BF28217
	for <alsa-devel@alsa-project.org>; Wed, 10 Nov 2004 23:18:05 +0100 (MET)
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


The following issue has been RESOLVED.
======================================================================
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=586> 
======================================================================
Reported By:                msc
Assigned To:                pzad
======================================================================
Project:                    ALSA - driver
Issue ID:                   586
Category:                   PCI - emu10k1
Reproducibility:            always
Severity:                   major
Priority:                   normal
Status:                     resolved
Distribution:               debian/unstable
Kernel Version:             2.6.8
Resolution:                 fixed
Fixed in Version:           
======================================================================
Date Submitted:             10-19-2004 14:55 CEST
Last Modified:              11-10-2004 23:18 CET
======================================================================
Summary:                    AC3 pass thru SPDIF has DropOuts
Description: 
i can't play AC3 thru (optical) SPDIF out anymore.
external receiver has a lot of dropouts.
======================================================================

----------------------------------------------------------------------
 msc - 10-19-04 20:27 
----------------------------------------------------------------------
ok thanks for info, i will check this within the next few days.

----------------------------------------------------------------------
 msc - 10-22-04 17:16 
----------------------------------------------------------------------
it works fine with 1.0.7rc2.
thanks.

Issue History
Date Modified  Username       Field                    Change              
======================================================================
10-19-04 14:55 msc            New Issue                                    
10-19-04 14:55 msc            Distribution              => debian/unstable 
10-19-04 14:55 msc            Kernel Version            => 2.6.8           
10-19-04 15:01 pzad           Note Added: 0002205                          
10-19-04 20:27 msc            Note Added: 0002208                          
10-22-04 17:16 msc            Note Added: 0002252                          
11-10-04 23:18 pzad           Status                   assigned => resolved
11-10-04 23:18 pzad           Resolution               open => fixed       
======================================================================




-------------------------------------------------------
This SF.Net email is sponsored by:
Sybase ASE Linux Express Edition - download now for FREE
LinuxWorld Reader's Choice Award Winner for best database on Linux.
http://ads.osdn.com/?ad_id=5588&alloc_id=12065&op=click
