From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0001133]: openal gives no sound with alsa driver
Date: Sat, 28 May 2005 07:22:31 +0200
Message-ID: <6ee8122d01d43e1291daa9187fdb32a1@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [82.113.61.162])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 4282E222
	for <alsa-devel@alsa-project.org>; Sat, 28 May 2005 07:22:31 +0200 (MEST)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=1133> 
======================================================================
Reported By:                qwer1234
Assigned To:                
======================================================================
Project:                    ALSA - driver
Issue ID:                   1133
Category:                   PCI - via82xx
Reproducibility:            always
Severity:                   major
Priority:                   normal
Status:                     new
Distribution:               slackware-current
Kernel Version:             2.6.12-rc5
======================================================================
Date Submitted:             05-28-2005 07:22 CEST
Last Modified:              05-28-2005 07:22 CEST
======================================================================
Summary:                    openal gives no sound with alsa driver
Description: 
When I add this to ~/.openalrc
 (define devices '(alsa))
 (define alsa-device "default")
 (define speaker-num 2)
I get no sound with openalrc.
I use dmix plugin.
======================================================================

Issue History
Date Modified  Username       Field                    Change              
======================================================================
05-28-05 07:22 qwer1234       New Issue                                    
05-28-05 07:22 qwer1234       Distribution              => slackware-current
05-28-05 07:22 qwer1234       Kernel Version            => 2.6.12-rc5      
======================================================================




-------------------------------------------------------
This SF.Net email is sponsored by Yahoo.
Introducing Yahoo! Search Developer Network - Create apps using Yahoo!
Search APIs Find out how you can build Yahoo! directly into your own
Applications - visit http://developer.yahoo.net/?fr=offad-ysdn-ostg-q22005
