From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0000784]: CMI 9739A PCM does not allow volume control only on/off (when on starts with full volume)
Date: Tue, 4 Jan 2005 20:57:32 +0100
Message-ID: <9792af06046b0c8799c4a11cfb86b7d1@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [82.113.61.162])
	by alsa.alsa-project.org (ALSA's E-mail Delivery System) with ESMTP id 5E665270
	for <alsa-devel@alsa-project.org>; Tue,  4 Jan 2005 20:57:32 +0100 (MET)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=784> 
======================================================================
Reported By:                ajir
Assigned To:                
======================================================================
Project:                    ALSA - driver
Issue ID:                   784
Category:                   PCI - intel8x0
Reproducibility:            always
Severity:                   major
Priority:                   normal
Status:                     new
Distribution:               
Kernel Version:             2.6.8.1
======================================================================
Date Submitted:             01-04-2005 20:34 CET
Last Modified:              01-04-2005 20:57 CET
======================================================================
Summary:                    CMI 9739A PCM does not allow volume control only
on/off (when on starts with full volume)
Description: 
This issue was studied before but without any effect. Some says that this
codec has different hadrware and it can not be controled.BUT WINDOWS
DRIVER CAN CONTROL damn VOLUME. Please can it be fixed?
======================================================================

----------------------------------------------------------------------
 rlrevell - 01-04-05 20:57 
----------------------------------------------------------------------
Please, stop reporting this as a bug!  Besides I am sure there's already an
open bug report for it.  The upcoming ALSA 1.0.8 release will have a
"software volume" plugin that should solve the problem.

Issue History
Date Modified  Username       Field                    Change              
======================================================================
01-04-05 20:34 ajir           New Issue                                    
01-04-05 20:34 ajir           Kernel Version            => 2.6.8.1         
01-04-05 20:57 rlrevell       Note Added: 0003080                          
======================================================================




-------------------------------------------------------
The SF.Net email is sponsored by: Beat the post-holiday blues
Get a FREE limited edition SourceForge.net t-shirt from ThinkGeek.
It's fun and FREE -- well, almost....http://www.thinkgeek.com/sfshirt
