From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0001329]: input part of kmix don't show any settings
Date: Sat, 13 Aug 2005 01:51:36 +0200
Message-ID: <739e283beba6e2e4e9164f9329c0f745@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [82.113.61.162])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 920141AE
	for <alsa-devel@alsa-project.org>; Sat, 13 Aug 2005 01:51:36 +0200 (MEST)
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


The following issue requires your FEEDBACK.
======================================================================
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=1329> 
======================================================================
Reported By:                submax82
Assigned To:                jcdutton
======================================================================
Project:                    ALSA - driver
Issue ID:                   1329
Category:                   PCI - ca0106
Reproducibility:            always
Severity:                   feature
Priority:                   normal
Status:                     feedback
Distribution:               debian
Kernel Version:             2.6.12.4
======================================================================
Date Submitted:             08-12-2005 14:59 CEST
Last Modified:              08-13-2005 01:51 CEST
======================================================================
Summary:                    input part of kmix don't show any settings
Description: 
The input section of kmix, on kde, do not show any settings: cd, line-in,
mic ecc... Those are not present! This is big lack!
======================================================================

----------------------------------------------------------------------
 jcdutton - 08-13-05 01:51 
----------------------------------------------------------------------
Please post the output of:
cat /proc/asound/verson
cat /proc/asound/cards


Issue History
Date Modified  Username       Field                    Change              
======================================================================
08-12-05 14:59 submax82       New Issue                                    
08-12-05 14:59 submax82       Distribution              => debian          
08-12-05 14:59 submax82       Kernel Version            => 2.6.12.4        
08-13-05 01:51 jcdutton       Note Added: 0005799                          
08-13-05 01:51 jcdutton       Status                   assigned => feedback
======================================================================




-------------------------------------------------------
SF.Net email is Sponsored by the Better Software Conference & EXPO
September 19-22, 2005 * San Francisco, CA * Development Lifecycle Practices
Agile & Plan-Driven Development * Managing Projects & Teams * Testing & QA
Security * Process Improvement & Measurement * http://www.sqe.com/bsce5sf
