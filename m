From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0000452]: Rate control sticks in IEC958 value
Date: Wed, 18 Aug 2004 12:51:49 +0200 (CEST)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <20040818105149.91A951102F@server.perex-int.cz>
Content-Type: text/plain; charset=iso-8859-1
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from mail.perex.cz (gate.perex.cz [82.113.61.162])
	by alsa.alsa-project.org (ALSA's E-mail Delivery System) with ESMTP id E15A825D
	for <alsa-devel@alsa-project.org>; Wed, 18 Aug 2004 12:51:49 +0200 (MEST)
Received: from server.perex-int.cz (server.perex-int.cz [192.168.100.2])
	by gate.perex-int.cz (Perex's E-mail Delivery System) with ESMTP id A115B18CF4
	for <alsa-devel@alsa-project.org>; Wed, 18 Aug 2004 12:51:49 +0200 (MEST)
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


The following bug has been SUBMITTED.
======================================================================
https://bugtrack.alsa-project.org/alsa-bug/bug_view_page.php?bug_id=0000452
======================================================================
Reported By:                Andrew
Assigned To:                
======================================================================
Project:                    ALSA - driver
Bug ID:                     452
Category:                   PCI - ice1724
Reproducibility:            always
Severity:                   block
Priority:                   normal
Status:                     new
Distribution:               
Kernel Version:             
======================================================================
Date Submitted:             08-18-2004 12:51 CEST
Last Modified:              08-18-2004 12:51 CEST
======================================================================
Summary:                    Rate control sticks in IEC958 value
Description: 
After setting Multi Track Internal Clock control
to IEC958 value, this control sticks in this value.
It is impossible to change the control value to any
other of the enumerated values. Rebooting does not
help here. All audio apps do not work now.
======================================================================

Bug History
Date Modified  Username       Field                    Change              
======================================================================
08-18-04 12:51 Andrew         New Bug                                      
======================================================================


-------------------------------------------------------
SF.Net email is sponsored by Shop4tech.com-Lowest price on Blank Media
100pk Sonic DVD-R 4x for only $29 -100pk Sonic DVD+R for only $33
Save 50% off Retail on Ink & Toner - Free Shipping and Free Gift.
http://www.shop4tech.com/z/Inkjet_Cartridges/9_108_r285
