From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0000309]: I don't get sound from rear-right speaker
Date: Wed, 17 Nov 2004 19:00:34 +0100
Message-ID: <ac79e3b2090d5ae4881f1e903a923055@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [82.113.61.162])
	by alsa.alsa-project.org (ALSA's E-mail Delivery System) with ESMTP id 823E127B
	for <alsa-devel@alsa-project.org>; Wed, 17 Nov 2004 19:00:34 +0100 (MET)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=309> 
======================================================================
Reported By:                ttb
Assigned To:                
======================================================================
Project:                    ALSA - driver
Issue ID:                   309
Category:                   PCI - emu10k1
Reproducibility:            always
Severity:                   major
Priority:                   normal
Status:                     new
Distribution:               
Kernel Version:             2.6.6
======================================================================
Date Submitted:             05-27-2004 04:06 CEST
Last Modified:              11-17-2004 19:00 CET
======================================================================
Summary:                    I don't get sound from rear-right speaker
Description: 
I don't get sound from rear-right speaker.
Also when playing my terminator 2 DVD THX Sound test, when it says it is
activating the rear-right channel, it activates the rear-left channel.
Could all the rear audio be going to the rear-left?
======================================================================

----------------------------------------------------------------------
 pzad - 05-27-04 17:18 
----------------------------------------------------------------------
Are rear speaker good connected (plug is well plugged) ???
Try to use speaker-test from alsa-util 1.0.5rc1 package.

----------------------------------------------------------------------
 rlrevell - 11-17-04 19:00 
----------------------------------------------------------------------
Can you verify this is still a bug?  Maybe this can be closed.  No one else
has reported the issue...

Issue History
Date Modified  Username       Field                    Change              
======================================================================
05-27-04 04:06 ttb            New Issue                                    
05-27-04 04:06 ttb            Kernel Version            => 2.6.6           
05-27-04 17:18 pzad           Note Added: 0001264                          
11-17-04 19:00 rlrevell       Note Added: 0002438                          
======================================================================




-------------------------------------------------------
This SF.Net email is sponsored by: InterSystems CACHE
FREE OODBMS DOWNLOAD - A multidimensional database that combines
robust object and relational technologies, making it a perfect match
for Java, C++,COM, XML, ODBC and JDBC. www.intersystems.com/match8
