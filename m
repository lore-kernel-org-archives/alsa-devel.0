From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0001708]: Onboard sound using the
	intel-hda driver does not work on P5GD1-VM motherboards
Date: Fri, 21 Jul 2006 02:32:15 +0200
Message-ID: <f50c9740d9743e7dc765ec6ab3644e37@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 308D3169
	for <alsa-devel@alsa-project.org>;
	Fri, 21 Jul 2006 02:32:16 +0200 (MEST)
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


The following issue has been CLOSED
======================================================================
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=1708> 
======================================================================
Reported By:                keith81
Assigned To:                tiwai
======================================================================
Project:                    ALSA - driver
Issue ID:                   1708
Category:                   PCI - hda-intel
Reproducibility:            always
Severity:                   major
Priority:                   normal
Status:                     closed
Distribution:               
Kernel Version:             
Resolution:                 unable to duplicate
Fixed in Version:           
======================================================================
Date Submitted:             01-04-2006 10:57 CET
Last Modified:              07-21-2006 02:32 CEST
======================================================================
Summary:                    Onboard sound using the intel-hda driver does not
work on P5GD1-VM motherboards
Description: 
I raised this issue back in July or August and received no helpful
feedback.  If you google the P5GD1-VMmobo name, along with alsa, you see
that many people with this mobo have not been able to get sound to work on
their installations of various distributions of linux.

Are there any future plans to include support for P5GD1-VM motherboards? 
No sound is a deal-breaker for me when it comes to migrating. 

I appreciate any feedback, whether it's getting sound to work on my
system, or someone saying support is in the pipes, or someone explaining
why support won't be coming.

Thanks!  Happy new year!
======================================================================

----------------------------------------------------------------------
 tiwai - 01-04-06 17:07 
----------------------------------------------------------------------
First, try the latest ALSA release (1.0.11rc2 o CVS version).

Issue History
Date Modified  Username       Field                    Change              
======================================================================
01-04-06 10:57 keith81        New Issue                                    
01-04-06 17:07 tiwai          Note Added: 0007435                          
07-21-06 02:32 Adrian Bunk    Status                   assigned => closed  
07-21-06 02:32 Adrian Bunk    Resolution               open => unable to
duplicate
======================================================================



-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys -- and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
