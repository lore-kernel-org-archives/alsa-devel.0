From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0000814]: Add echo drivers to alsa-kernel tree
Date: Thu, 13 Jan 2005 16:17:58 +0100
Message-ID: <5e33777f8af7b716a27772c7c8c0ecfb@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [82.113.61.162])
	by alsa.alsa-project.org (ALSA's E-mail Delivery System) with ESMTP id DAA8C338
	for <alsa-devel@alsa-project.org>; Thu, 13 Jan 2005 16:17:58 +0100 (MET)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=814> 
======================================================================
Reported By:                wbrown338
Assigned To:                tiwai
======================================================================
Project:                    ALSA - driver
Issue ID:                   814
Category:                   PCI - echoaudio
Reproducibility:            always
Severity:                   feature
Priority:                   normal
Status:                     resolved
Distribution:               1.0.7 CVS snapshot.
Kernel Version:             &nbsp;2.6.10
Resolution:                 suspended
Fixed in Version:           
======================================================================
Date Submitted:             01-12-2005 21:43 CET
Last Modified:              01-13-2005 16:17 CET
======================================================================
Summary:                    Add echo drivers to alsa-kernel tree
Description: 
Greetings:

It would be great to get the echoaudio drivers added to the alsa-kernel
tree.  That way, I can use make menuconfig to build a custom kernel for
the version of linux I use.  currently I have been trying the steps on the
alsa-wiki to port the alsa-driver/pci code to the alsa-kernel/pci but the
number of compile issues is keeping me held up for the time being.  Let me
know if there is anything else you need me to report to help make this
happen.  Thanks. 
======================================================================

----------------------------------------------------------------------
 tiwai - 01-13-05 16:17 
----------------------------------------------------------------------
It's still a bit too early to move this stuff to linux kernel tree.
Maybe in the next release.

Issue History
Date Modified  Username       Field                    Change              
======================================================================
01-12-05 21:43 wbrown338      New Issue                                    
01-12-05 21:43 wbrown338      Distribution              => 1.0.7 CVS snapshot.
01-12-05 21:43 wbrown338      Kernel Version            =>  2.6.10         
01-13-05 16:17 tiwai          Status                   new => resolved     
01-13-05 16:17 tiwai          Resolution               open => suspended   
01-13-05 16:17 tiwai          Assigned To               => tiwai           
01-13-05 16:17 tiwai          Note Added: 0003185                          
======================================================================




-------------------------------------------------------
The SF.Net email is sponsored by: Beat the post-holiday blues
Get a FREE limited edition SourceForge.net t-shirt from ThinkGeek.
It's fun and FREE -- well, almost....http://www.thinkgeek.com/sfshirt
