From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0001381]: No sound on Thinkpad T40p
Date: Wed, 31 Aug 2005 09:50:29 +0200
Message-ID: <1b095c513e937e9f78b21bdf9a8bb14b@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [82.113.61.162])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 80A871F6
	for <alsa-devel@alsa-project.org>; Wed, 31 Aug 2005 09:50:29 +0200 (MEST)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=1381> 
======================================================================
Reported By:                Soft
Assigned To:                
======================================================================
Project:                    ALSA - driver
Issue ID:                   1381
Category:                   PCI - intel8x0
Reproducibility:            always
Severity:                   major
Priority:                   normal
Status:                     new
Distribution:               Debian
Kernel Version:             
======================================================================
Date Submitted:             08-31-2005 09:50 CEST
Last Modified:              08-31-2005 09:50 CEST
======================================================================
Summary:                    No sound on Thinkpad T40p
Description: 
When attempting to play a sound on a Thinkpad T40p, all sound players
behave as if playing normally, but no sound comes out of the speakers. 
This is with Debian Sarge + various package upgrades to testing, with a
number of kernels from 2.4.27 through 2.6.13-rc6-mm1, alsa-driver
1.0.8/1.0.9/1.0.10rc1.

I have already tried various "tricks", including muting Headphone Jack
Sense and Line Jack Sense.  Please see the following thread on alsa-user
mailing-list:
http://sourceforge.net/mailarchive/forum.php?thread_id=8013709&forum_id=1751
for more information.
======================================================================

Issue History
Date Modified  Username       Field                    Change              
======================================================================
08-31-05 09:50 Soft           New Issue                                    
08-31-05 09:50 Soft           Distribution              => Debian          
======================================================================




-------------------------------------------------------
SF.Net email is Sponsored by the Better Software Conference & EXPO
September 19-22, 2005 * San Francisco, CA * Development Lifecycle Practices
Agile & Plan-Driven Development * Managing Projects & Teams * Testing & QA
Security * Process Improvement & Measurement * http://www.sqe.com/bsce5sf
