From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0002214]: Problem recording sound from
	an USB device.
Date: Fri, 16 Jun 2006 23:41:19 +0200
Message-ID: <29a10952ef50ab4ffe0e9493ef20f8ff@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 541F9181
	for <alsa-devel@alsa-project.org>;
	Fri, 16 Jun 2006 23:41:19 +0200 (MEST)
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


The following issue has been SUBMITTED.
======================================================================
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=2214> 
======================================================================
Reported By:                nbaggus
Assigned To:                Clemens Ladisch
======================================================================
Project:                    ALSA - driver
Issue ID:                   2214
Category:                   USB - usb-audio
Reproducibility:            always
Severity:                   major
Priority:                   normal
Status:                     assigned
Distribution:               gentoo
Kernel Version:             2.6.16-r9
======================================================================
Date Submitted:             06-16-2006 23:41 CEST
Last Modified:              06-16-2006 23:41 CEST
======================================================================
Summary:                    Problem recording sound from an USB device.
Description: 
Equipment used: yealink usb Cyber phone
Sound applications just hang when trying to read from the device.

(kphone, arecord etc.) 
This is equivalent to bug 1903, except that now the kernel standard
version is used and not a whole range of alsa-driver kits.


======================================================================

Issue History
Date Modified  Username       Field                    Change              
======================================================================
06-16-06 23:41 nbaggus        New Issue                                    
06-16-06 23:41 nbaggus        Distribution              => gentoo          
06-16-06 23:41 nbaggus        Kernel Version            => 2.6.16-r9       
======================================================================
