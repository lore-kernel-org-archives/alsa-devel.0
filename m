From: bugtrack@alsa-project.org
Subject: [ALSA - liboss 0001098]: aoss openal    gives too fast sound.
Date: Tue, 24 May 2005 11:59:36 +0200
Message-ID: <95ac2915bff8141db59605086007a665@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [82.113.61.162])
	by alsa.alsa-project.org (ALSA's E-mail Delivery System) with ESMTP id A96141D7
	for <alsa-devel@alsa-project.org>; Tue, 24 May 2005 11:59:36 +0200 (MEST)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=1098> 
======================================================================
Reported By:                qwer1234
Assigned To:                
======================================================================
Project:                    ALSA - liboss
Issue ID:                   1098
Category:                   
Reproducibility:            always
Severity:                   major
Priority:                   normal
Status:                     new
======================================================================
Date Submitted:             05-09-2005 17:09 CEST
Last Modified:              05-24-2005 11:59 CEST
======================================================================
Summary:                    aoss openal    gives too fast sound.
Description: 
Opanal layer gives too fast sound when I use aoss wrapper and I get this
error multiple times:

native_blitbuffer: select error occured

======================================================================

----------------------------------------------------------------------
 qwer1234 - 05-19-05 16:59 
----------------------------------------------------------------------
How can I check which alsa driver version do I have in my 2.6 kernel?
I use 2.6.11.10.

----------------------------------------------------------------------
 tiwai - 05-24-05 11:59 
----------------------------------------------------------------------
You can see the driver version in /proc/asound/version.

Issue History
Date Modified  Username       Field                    Change              
======================================================================
05-09-05 17:09 qwer1234       New Issue                                    
05-09-05 17:15 qwer1234       Issue Monitored: qwer1234                    
05-17-05 17:52 tiwai          Note Added: 0004681                          
05-17-05 17:53 tiwai          Note Added: 0004682                          
05-18-05 00:38 qwer1234       Note Added: 0004685                          
05-18-05 00:41 qwer1234       Note Edited: 0004685                         
05-18-05 14:53 tiwai          Note Added: 0004687                          
05-18-05 14:55 tiwai          Note Added: 0004688                          
05-19-05 13:37 qwer1234       Note Added: 0004689                          
05-19-05 14:12 tiwai          Note Added: 0004690                          
05-19-05 16:59 qwer1234       Note Added: 0004694                          
05-24-05 11:59 tiwai          Note Added: 0004712                          
======================================================================




-------------------------------------------------------
This SF.Net email is sponsored by Oracle Space Sweepstakes
Want to be the first software developer in space?
Enter now for the Oracle Space Sweepstakes!
http://ads.osdn.com/?ad_id=7412&alloc_id=16344&op=click
