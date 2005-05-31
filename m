From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0000071]: sizzly sound with ac97 and linux 2.6.3/2.6.2
Date: Tue, 31 May 2005 18:02:08 +0200
Message-ID: <ed1f9e73ac8060f7c264aa1d0b8089ea@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [82.113.61.162])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id C98BE1B4
	for <alsa-devel@alsa-project.org>; Tue, 31 May 2005 18:02:08 +0200 (MEST)
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


The following issue has been CLOSED
======================================================================
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=71> 
======================================================================
Reported By:                MsK
Assigned To:                perex
======================================================================
Project:                    ALSA - driver
Issue ID:                   71
Category:                   PCI - via82xx
Reproducibility:            always
Severity:                   tweak
Priority:                   normal
Status:                     closed
Distribution:               Gentoo 1.4
Kernel Version:             linux 2.6.3/2.6.2
Resolution:                 suspended
Fixed in Version:           
======================================================================
Date Submitted:             02-18-2004 22:39 CET
Last Modified:              05-31-2005 18:02 CEST
======================================================================
Summary:                    sizzly sound with ac97 and linux 2.6.3/2.6.2
Description: 
The sound always sizzles with linux 2.6.3 ( alsa 1.0.2c ) and linux 2.6.2.
It does'nt sizzles with linux 2.6.0 ( alsa 0.9.7 ) and with alsa 0.9.8.
It sizzles with older versions of alsa like 0.9.2 or 0.9.3. I was very
happy when this was solved :)
But sorry, i can't gave you more information :/
======================================================================

----------------------------------------------------------------------
 perex - 03-23-04 16:35 
----------------------------------------------------------------------
No reaction from user.

----------------------------------------------------------------------
 noaq - 05-19-04 22:52 
----------------------------------------------------------------------
Reminder sent to perex

For some reason I can't add notes to this bug. I think that I have this
problem also and I might be able to help out in debugging it.

I have noticed that if i resample tests from 44.1khz to 48khz the sizzle
disappears

Issue History
Date Modified  Username       Field                    Change              
======================================================================
02-18-04 22:39 MsK            New Issue                                    
02-18-04 22:40 MsK            Note Added: 0000265                          
03-05-04 19:58 tiwai          Note Added: 0000514                          
03-23-04 16:35 perex          Status                   new => resolved     
03-23-04 16:35 perex          Resolution               open => suspended   
03-23-04 16:35 perex          Assigned To               => perex           
03-23-04 16:35 perex          Note Added: 0000671                          
05-19-04 22:46 noaq           Issue Monitored: noaq                        
05-19-04 22:52 noaq           Note Added: 0001156                          
05-31-05 18:02 perex          Status                   resolved => closed  
======================================================================




-------------------------------------------------------
This SF.Net email is sponsored by Yahoo.
Introducing Yahoo! Search Developer Network - Create apps using Yahoo!
Search APIs Find out how you can build Yahoo! directly into your own
Applications - visit http://developer.yahoo.net/?fr=offad-ysdn-ostg-q22005
